/*
 * CombatManager.h
 *
 *  Created on: 21/01/2010
 *      Author: victor
 */

#ifndef COMBATMANAGER_H_
#define COMBATMANAGER_H_

#include "engine/engine.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/creature/NonPlayerCreatureObject.h"
#include "server/zone/objects/tangible/weapon/WeaponObject.h"
#include "server/zone/objects/tangible/wearables/ArmorObject.h"

class CombatQueueCommand;

class CombatManager : public Singleton<CombatManager>, public Logger {

public:
	const static int BLOCK = 1;
	const static int DODGE = 2;
	const static int COUNTER = 3;
	const static int MISS = 4;


	const static int HEALTH = 1;
	const static int ACTION = 2;
	const static int MIND = 4;
	const static int RANDOM = 8;

public:
	CombatManager() {
		setLoggingName("CombatManager");
		setGlobalLogging(false);
		setLogging(false);
	}

	/**
	 * Attempts combat between 2 creature objects
	 * @pre { attacker locked }
	 * @post { attacker locked }
	 * @param attacker attacking object
	 * @param defender defender object
	 * @param lockDefender will crosslock with attacker if true
	 * @return true on success
	 */
	bool startCombat(CreatureObject* attacker, TangibleObject* defender, bool lockDefender = true);

	/**
	 * Attempts to stop combat
	 * @pre { attacker locked }
	 * @post { attacker locked }
	 * @param attacker CreatureObject that attempts peace state
	 * @return true on succes
	 */
	bool attemptPeace(CreatureObject* attacker);

	/**
	 * Attempts combat action
	 * @pre { attacker locked, defender unlocked }
	 * @post { attacker locked, defender unlocked }
	 * @param attacker Attacker trying the action
	 * @param defender Defender of the action
	 * @param poolsToDamage bitmask of what pool to damage (bit 1 health, 2 action, 4 mind, 8 random)
	 * @return returns -1 on failure to start combat or damage on succesfull combat
	 */
	int doCombatAction(CreatureObject* attacker, TangibleObject* defenderObject, CombatQueueCommand* command);

	/**
	 * Requests duel
	 * @param player player that is trying to duel target
	 * @param targetPlayer target
	 * @pre { player != targetPlayer, player is locked }
	 * @post { player is locked }
	 */
	void requestDuel(PlayerCreature* player, PlayerCreature* targetPlayer);

	/**
	 * Requests end duel
	 * @param player player that is trying to end duel to target
	 * @param targetPlayer target
	 * @pre { player != targetPlayer, player is locked }
	 * @post { player is locked }
	 */
	void requestEndDuel(PlayerCreature* player, PlayerCreature* targetPlayer);

	/**
	 * Clears duel list
	 * @param player player to clear duel list
	 * @pre { player is locked }
	 * @post { player is locked }
	 */
	void freeDuelList(PlayerCreature* player, bool spam = false);

	/**
	 * Declines duel
	 * @param player player that is trying to end duel to target
	 * @param targetPlayer target
	 * @pre { player != targetPlayer, player is locked }
	 * @post { player is locked }
	 */
	void declineDuel(PlayerCreature* player, PlayerCreature* targetPlayer);

	float calculateWeaponAttackSpeed(CreatureObject* attacker, WeaponObject* weapon, float skillSpeedRatio);
	bool attemptApplyDot(CreatureObject* attacker, CreatureObject* defender, CombatQueueCommand* command);

	//all the combat math will go here
protected:

	const static uint32 defaultAttacks[9];

	int doTargetCombatAction(CreatureObject* attacker, CreatureObject* defenderObject, CombatQueueCommand* command);
	int doAreaCombatAction(CreatureObject* attacker, TangibleObject* defenderObject, CombatQueueCommand* command);
	int doTargetCombatAction(CreatureObject* attacker, TangibleObject* defenderObject, CombatQueueCommand* command);

	float getWeaponRangeModifier(float currentRange, WeaponObject* weapon);

	int applyDefensePenalties(CreatureObject* defender, int attackType, int defense);
	int applyAccuracyPenalties(CreatureObject* creature, int attackType, int accuracy);

	uint32 getDefaultAttackAnimation(CreatureObject* creature);

	/**
	 * @returns % to hit
	 */
	int getHitChance(CreatureObject* creature, CreatureObject* targetCreature, WeaponObject* weapon, int accuracyBonus);

	/**
	 * returns 0 - hit, 1 - block, 2 - dodge, 3 - counter-attack
	 */
	int checkSecondaryDefenses(CreatureObject* creature, CreatureObject* targetCreature, WeaponObject* weapon);

	float hitChanceEquation(float attackerAccuracy, float accuracyBonus, float targetDefense, float defenseBonus);
	int calculatePostureModifier(CreatureObject* creature, CreatureObject* targetCreature);

	int getAttackerAccuracyModifier(CreatureObject* attacker, WeaponObject* weapon);
	int getDefenderDefenseModifier(CreatureObject* defender, WeaponObject* weapon);
	int getDefenderSecondaryDefenseModifier(CreatureObject* defender, WeaponObject* weapon);
	int getDamageModifier(CreatureObject* attacker, WeaponObject* weapon);
	int getSpeedModifier(CreatureObject* attacker, WeaponObject* weapon);
	float calculateDamage(CreatureObject* attacker, CreatureObject* defender, int poolToDamage);
	float calculateDamage(CreatureObject* attacker, TangibleObject* defender);
	void checkKnockDown(CreatureObject* creature, CreatureObject* targetCreature, int chance);
	void checkPostureDown(CreatureObject* creature, CreatureObject* targetCreature, int chance);
	void checkPostureUp(CreatureObject* creature, CreatureObject* targetCreature, int chance);
	bool checkConeAngle(SceneObject* targetCreature, float angle, float creatureVectorX, float creatureVectorY, float directionVectorX, float directionVectorY);

	void doMiss(CreatureObject* attacker, CreatureObject* defender, int damage, const String& cbtSpam);
	void doCounterAttack(CreatureObject* creature, CreatureObject* defender, int damage, const String& cbtSpam);
	void doBlock(CreatureObject* creature, CreatureObject* defender, int damage, const String& cbtSpam);
	void doDodge(CreatureObject* creature, CreatureObject* defender, int damage, const String& cbtSpam);

	int applyDamage(CreatureObject* attacker, TangibleObject* defender, float damageMultiplier, int poolsToDamage);
	int applyDamage(CreatureObject* attacker, CreatureObject* defender, float damageMultiplier, int poolsToDamage);
	void applyStates(CreatureObject* creature, CreatureObject* targetCreature, CombatQueueCommand* tskill);

	int getArmorObjectReduction(CreatureObject* attacker, ArmorObject* armor);
	int getArmorReduction(CreatureObject* attacker, CreatureObject* defender, WeaponObject* weapon, float damage, int poolsToDamage);
	int getArmorNpcReduction(CreatureObject* attacker, AiAgent* defender, WeaponObject* weapon);
	int getHealthArmorReduction(CreatureObject* attacker, CreatureObject* defender);
	int getActionArmorReduction(CreatureObject* attacker, CreatureObject* defender);
	int getMindArmorReduction(CreatureObject* attacker, CreatureObject* defender);

	/**
	 * returns bitmask with what pools to damage
	 */
	int calculatePoolsToDamage(int poolsToDamage);

	/**
	 * returns false on insufficient
	 */
	bool applySpecialAttackCost(CreatureObject* attacker, CombatQueueCommand* command);

	void broadcastCombatSpam(CreatureObject* attacker, TangibleObject* defender, TangibleObject* weapon, uint32 damage, const String& stringid);

};


#endif /* COMBATMANAGER_H_ */
