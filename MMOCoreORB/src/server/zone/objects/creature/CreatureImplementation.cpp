/*
 * CreatureImplementation.cpp
 *
 *  Created on: 10/23/2010
 *      Author: Kyle
 */

#include "CreatureObject.h"
#include "Creature.h"
#include "AiAgent.h"
#include "server/zone/packets/object/ObjectMenuResponse.h"
#include "server/zone/packets/chat/ChatSystemMessage.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/zone/objects/building/BuildingObject.h"
#include "server/zone/objects/group/GroupObject.h"
#include "server/zone/objects/creature/events/DespawnCreatureTask.h"
#include "server/zone/managers/creature/CreatureManager.h"
#include "server/zone/Zone.h"
#include "server/zone/managers/combat/CombatManager.h"
#include "server/zone/objects/tangible/threat/ThreatMap.h"
#include "server/zone/managers/collision/CollisionManager.h"

//#define DEBUG

void CreatureImplementation::notifyPositionUpdate(QuadTreeEntry* entry) {

	AiAgentImplementation::notifyPositionUpdate(entry);

	if(getPvpStatusBitmask() == CreatureFlag::NONE || isDead())
		return;

	int radius = 32;

	if(getParent() != NULL && getParent()->isCellObject())
		radius = 12;

	int awarenessRadius = getFerocity() + radius;

	if(!entry->isInRange(_this, awarenessRadius))
		return;

#ifdef DEBUG
	info("Passed range check", true);
#endif

	SceneObject* scno = cast<SceneObject*>( entry);

	// don't worry about this if no one's around, and do it for any creature
	if (scno == _this || numberOfPlayersInRange <= 0  || !scno->isCreatureObject() || isRetreating() || isFleeing() || isInCombat())
		return;

	if (followObject == NULL || followObject == scno) {
		CreatureObject* creo = cast<CreatureObject*>( scno);

		if(creo->getPvpStatusBitmask() == CreatureFlag::NONE)
			return;

		/// If not in combat, ignore creatures in different cells
		if(!isInCombat() && getParent() != NULL) {
			if(getParent() != creo->getParent())
				return;
		}

		// TODO: determine if creature can be seen by this (mask scent, et. al.)

		// determine if creature can be a threat
		if (creo->isAiAgent()) {
			AiAgent* aio = cast<AiAgent*>(creo);
			if ((aio->getFerocity() <= 0 || getFerocity() <= 0) && aio->getLevel() >= getLevel())
				return;
		} else if (this->isAttackableBy(creo) && isInRange(scno, 15) && !creo->isDead()) { //no aigent<->aigent combat for now
			activateAwarenessEvent(creo);
		}
	}
}

void CreatureImplementation::doAwarenessCheck(Coordinate& start, uint64 time, CreatureObject* target) {

#ifdef DEBUG
	info("Starting doAwarenessCheck", true);
#endif

	if (isDead() || getZone() == NULL || time == 0 || target->isDead())
		return;

	if(!isAggressiveTo(target))
		return;

#ifdef DEBUG
	info("Passed aggressive check", true);
#endif

	if(!CollisionManager::checkLineOfSight(target, _this))
		return;

#ifdef DEBUG
	info("Passed LOS check", true);
#endif

	if(isCamouflaged(target))
		return;

	// calculate average speed
	Vector3 deltaV(target->getPositionX() - start.getPositionX(), target->getPositionY() - start.getPositionY(), 0);
	float avgSpeed = deltaV.squaredLength() / (time) * 1000000;

	// set frightened or threatened
	// TODO: weight this by ferocity/level difference
	if (isStalker() && isAggressiveTo(target)) {
		if (followObject == NULL)
			setStalkObject(target);
		else if (avgSpeed <= (target->getWalkSpeed() * target->getWalkSpeed()))
			addDefender(target);
	} else if (isAggressiveTo(target))
		addDefender(target);
	else if (avgSpeed <= (target->getWalkSpeed() * target->getWalkSpeed())) {
		setOblivious();
	} else if (followObject == NULL) {
		setWatchObject(target);
		showFlyText("npc_reaction/flytext", "alert", 0xFF, 0, 0);
	} else if (followObject->isCreatureObject() && target == followObject) {
		ManagedReference<CreatureObject*> creo = dynamic_cast<CreatureObject*>(followObject.get());
		// determine if frightened or threatened
		if (creo->isAiAgent()) {
			AiAgent* aio = cast<AiAgent*>(creo.get());
			if (getFerocity() > aio->getFerocity() && getLevel() >= aio->getLevel())
				addDefender(aio);
			else if (getLevel() < aio->getLevel()) {
				if (!tryRetreat())
					runAway(target);
			} else
				setOblivious();
		} else if (creo->isPlayerCreature()) {
			CreatureObject* play = cast<CreatureObject*>(creo.get());
			// TODO: tweak this formula based on feedback
			if ((getFerocity() * getLevel() / 4) < play->getLevel()) {
				if (!tryRetreat())
					runAway(target);
			} else
				addDefender(play);
		}
	}

	activateRecovery();
	activateMovementEvent();
}

void CreatureImplementation::runAway(CreatureObject* target) {
	if (target == NULL)
		return;

	setOblivious();

	threatMap->removeAll();

	Vector3 runTrajectory(getPositionX() - target->getPositionX(), getPositionY() - target->getPositionY(), 0);
	runTrajectory = runTrajectory * (100 / runTrajectory.length());
	runTrajectory += target->getPosition();

	patrolPoints.removeAll();
	setNextPosition(runTrajectory.getX(), getZone()->getHeight(runTrajectory.getX(), runTrajectory.getY()), runTrajectory.getY(), getParent());

	showFlyText("npc_reaction/flytext", "afraid", 0xFF, 0, 0);


	fleeing = true;

	CombatManager::instance()->forcePeace(_this);

	activateMovementEvent();
}

void CreatureImplementation::fillObjectMenuResponse(ObjectMenuResponse* menuResponse, CreatureObject* player) {

	/*menuResponse->addRadialMenuItem(205, 1, "@pet/pet_menu:menu_enter_exit");
	menuResponse->addRadialMenuItem(61, 3, "");

	if (checkInRangeGarage() && !isDestroyed())
		menuResponse->addRadialMenuItem(62, 3, "Repair");*/

	if (player->isInRange(_this, 10.0f)
			&& !player->isInCombat() && player->hasSkill("outdoors_scout_novice")
			&& isDead() && canHarvestMe(player)) {

		menuResponse->addRadialMenuItem(112, 3, "@sui:harvest_corpse");

		if (getMeatType() != "")
			menuResponse->addRadialMenuItemToRadialID(112, 234, 3, "@sui:harvest_meat");

		if (getHideType() != "")
			menuResponse->addRadialMenuItemToRadialID(112, 235, 3, "@sui:harvest_hide");

		if (getBoneType() != "")
			menuResponse->addRadialMenuItemToRadialID(112, 236, 3, "@sui:harvest_bone");
	}

	/*if (player->isInRange(getPositionX(), getPositionY(), 10.0f) && player->hasBiologicalSignature()
			&& getObjectCRC() == 0x78E5C3B5 && getCreatureLinkID() == player->getObjectID()){
		omr->addRadialParent(137, 3, "Transfer Bio-Signature");
	}*/
}

int CreatureImplementation::handleObjectMenuSelect(CreatureObject* player, byte selectedID) {
	if (getZone() == NULL)
		return 0;

	if ((selectedID == 112 || selectedID == 234 || selectedID == 235 || selectedID == 236) &&
			canHarvestMe(player)) {

		getZone()->getCreatureManager()->harvest(_this, player, selectedID);
		alreadyHarvested->add(player->getObjectID());

		return 0;
	}

	return AiAgentImplementation::handleObjectMenuSelect(player, selectedID);
}

void CreatureImplementation::fillAttributeList(AttributeListMessage* alm, CreatureObject* player) {
	AiAgentImplementation::fillAttributeList(alm, player);

	int creaKnowledge = player->getSkillMod("creature_knowledge");

	if (getHideType().isEmpty() && getBoneType().isEmpty() && getMeatType().isEmpty()) {
		return;
	}

	if (creaKnowledge >= 5) {
		if (isAggressiveTo(player))
			alm->insertAttribute("aggro", "yes");
		else
			alm->insertAttribute("aggro", "no");
		if (isStalker())
			alm->insertAttribute("stalking", "yes");
		else
			alm->insertAttribute("stalking", "no");
	}

	if (creaKnowledge >= 10) {
		if (getTame() >= 0.0f && isBaby())
			alm->insertAttribute("tamable", "yes");
		else
			alm->insertAttribute("tamable", "no");
	}

	if (creaKnowledge >= 20) {
		if (!getHideType().isEmpty()) {
			StringBuffer hideName;
			hideName << "@obj_attr_n:" << getHideType();
			alm->insertAttribute("res_hide", hideName.toString());
		} else
			alm->insertAttribute("res_hide", "---");
		if (!getBoneType().isEmpty()) {
			StringBuffer boneName;
			boneName << "@obj_attr_n:" << getBoneType();
			alm->insertAttribute("res_bone", boneName.toString());
		} else
			alm->insertAttribute("res_bone", "---");
		if (!getMeatType().isEmpty()) {
			StringBuffer meatName;
			meatName << "@obj_attr_n:" << getMeatType();
			alm->insertAttribute("res_meat", meatName.toString());
		} else
			alm->insertAttribute("res_meat", "---");
	}

	if (creaKnowledge >= 30) {
		if (isKiller())
			alm->insertAttribute("killer", "yes");
		else
			alm->insertAttribute("killer", "no");
	}

	if (creaKnowledge >= 40) {
		alm->insertAttribute("ferocity", (int) getFerocity());
	}

	if (creaKnowledge >= 50)
		alm->insertAttribute("challenge_level", getLevel());

	//int skillNum = skillCommands.size();
	CreatureAttackMap* attackMap = getAttackMap();
	int skillNum = 0;
	if (attackMap != NULL)
		skillNum = attackMap->size();

	if (creaKnowledge >= 70) {
		String skillname = "none";
		if (skillNum >= 1)
			skillname = attackMap->getCommand(0);

		StringBuffer skillMsg;
		skillMsg << "@combat_effects:" << skillname;

		alm->insertAttribute("pet_command_18", skillMsg.toString());
	}

	if (creaKnowledge >= 80) {
		String skillname = "none";
		if (skillNum >= 2)
			skillname = attackMap->getCommand(1);

		StringBuffer skillMsg;
		skillMsg << "@combat_effects:" << skillname;

		alm->insertAttribute("pet_command_19", skillMsg.toString());
	}

	if (creaKnowledge >= 90)
		alm->insertAttribute("basetohit", getChanceHit());

	if (creaKnowledge >= 100) {
		StringBuffer damageMsg;
		damageMsg << getDamageMin() << "-" << getDamageMax();
		alm->insertAttribute("cat_wpn_damage", damageMsg.toString());
	}
}

void CreatureImplementation::scheduleDespawn() {
	if (getPendingTask("despawn") != NULL)
		return;

	Reference<DespawnCreatureTask*> despawn = new DespawnCreatureTask(_this);
	//despawn->schedule(300000); /// 5 minutes
	addPendingTask("despawn", despawn, 45000); /// 45 seconds
}

bool CreatureImplementation::hasOrganics() {
	return ((getHideMax() + getBoneMax() + getMeatMax()) > 0);
}

bool CreatureImplementation::canHarvestMe(CreatureObject* player) {



	if (!hasOrganics())
		return false;

	if (player->getSkillMod("creature_harvesting") < 1)
		return false;

	if(alreadyHarvested == NULL)
		alreadyHarvested = new Vector<unsigned long long>();

	for(int i = 0; i < alreadyHarvested->size(); ++i) {
		if(alreadyHarvested->get(i) == player->getObjectID())
			return false;
	}

	if (lootOwner != NULL) {

		if(player == lootOwner)
			return true;

		if(player->isGrouped()) {
			ManagedReference<GroupObject*> group = lootOwner->getGroup();

			if (group == NULL)
				return false;

			if (group->hasMember(player))
				return true;
		}
	}

	return false;
}
