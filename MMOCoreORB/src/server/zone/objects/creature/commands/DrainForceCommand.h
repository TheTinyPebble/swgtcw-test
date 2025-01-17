/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef DRAINFORCECOMMAND_H_
#define DRAINFORCECOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "CombatQueueCommand.h"

class DrainForceCommand : public CombatQueueCommand {
public:

	DrainForceCommand(const String& name, ZoneProcessServer* server)
		: CombatQueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		if (creature->hasAttackDelay() || !creature->checkPostureChangeDelay())
			return GENERALERROR;

		if (isWearingArmor(creature)) {
			return NOJEDIARMOR;
		}

		// Fail if target is not a player...

		ManagedReference<SceneObject*> object = server->getZoneServer()->getObject(target);

		if (object == NULL)
			return INVALIDTARGET;

		CreatureObject* targetCreature = cast<CreatureObject*>( object.get());

		if (targetCreature == NULL || targetCreature->isDead() || (targetCreature->isIncapacitated() && !targetCreature->isFeigningDeath()) || !targetCreature->isAttackableBy(creature))
			return INVALIDTARGET;

		if(!checkDistance(creature, targetCreature, range))
			return TOOFAR;

		if (!CollisionManager::checkLineOfSight(creature, targetCreature)) {
			creature->sendSystemMessage("@combat_effects:cansee_fail");//You cannot see your target.
			return GENERALERROR;
		}

		Locker clocker(targetCreature, creature);

		//ManagedReference<PlayerObject*> targetGhost = targetCreature->getPlayerObject();
		ManagedReference<PlayerObject*> playerGhost = creature->getPlayerObject();

		//if (targetGhost == NULL || playerGhost == NULL)
		//	return GENERALERROR;

		CombatManager* manager = CombatManager::instance();

		if (manager->startCombat(creature, targetCreature, false)) { //lockDefender = false because already locked above.
			int forceSpace = playerGhost->getForcePowerMax() - playerGhost->getForcePower();
			if (forceSpace <= 0) //Cannot Force Drain if attacker can't hold any more Force.
				return GENERALERROR;
			if (targetCreature->isPlayerCreature()){
				return GENERALERROR;
			}
			int maxDrain = minDamage; //Value set in command lua.
			int forceEnh = 0;
			if(playerGhost->getJediState() == 4) {
				forceEnh = creature->getSkillMod("force_enhancement_light");
			} else if (playerGhost->getJediState() == 8) {
				forceEnh = creature->getSkillMod("force_enhancement_dark");
			}

			maxDrain = maxDrain + (forceEnh * 7.5);

			//int targetForce = targetGhost->getForcePower();
			//if (targetForce <= 0) {
			//	creature->sendSystemMessage("@jedi_spam:target_no_force"); //That target does not have any Force Power.
			//	return GENERALERROR;
			//}
			//maxDrain = 275;
			//int forceShield = targetCreature->getSkillMod("force_shield");
			//int toughness = targetCreature->getSkillMod("unarmed_toughness");
			//if (targetCreature->getSkillMod("twohandmelee_toughness") > toughness){toughness = targetCreature->getSkillMod("twohandmelee_toughness");}
			//if (targetCreature->getSkillMod("onehandmelee_toughness") > toughness){toughness = targetCreature->getSkillMod("onehandmelee_toughness");}
			//if (targetCreature->getSkillMod("polearm_toughness") > toughness){toughness = targetCreature->getSkillMod("polearm_toughness");}
			//if (targetCreature->getSkillMod("lightsaber_toughness") > toughness){toughness = targetCreature->getSkillMod("lightsaber_toughness");}

			//if (forceShield>0){
			//	maxDrain = maxDrain*(1-(forceShield/100));
			//}
			//if (toughness>0){
			//	maxDrain = maxDrain*(1-(toughness/100));
			//}
			if (!targetCreature->isPlayerCreature()){
				maxDrain = 100;
			}
			//int forceDrain = targetForce >= maxDrain ? maxDrain : targetForce; //Drain whatever Force the target has, up to max.
			int forceDrain = maxDrain;
			forceDrain = maxDrain+(System::random(50));
			if (forceDrain > forceSpace)
				forceDrain = forceSpace; //Drain only what attacker can hold in their own Force pool.

			playerGhost->setForcePower(playerGhost->getForcePower() + forceDrain);
			//targetGhost->setForcePower(targetGhost->getForcePower() - forceDrain);

			uint32 animCRC = getAnimationString().hashCode();
			creature->doCombatAnimation(targetCreature, animCRC, 0x1, 0xFF);
			manager->broadcastCombatSpam(creature, targetCreature, NULL, forceDrain, "cbt_spam", combatSpam, 1);
			return doCombatAction(creature, target);
			return SUCCESS;
		}

		return GENERALERROR;

	}

	float getCommandDuration(CreatureObject* object, const UnicodeString& arguments) const {
		return defaultTime * 3.0;
	}

};

#endif //DRAINFORCECOMMAND_H_
