/*
 * AiAgentImplementation.cpp
 *
 *  Created on: 13/07/2010
 *      Author: victor
 */

#include "AiAgent.h"

#include "events/AiThinkEvent.h"
#include "events/AiMoveEvent.h"
#include "events/AiWaitEvent.h"
#include "events/AiAwarenessEvent.h"
#include "events/RespawnCreatureTask.h"
#include "events/DespawnCreatureOnPlayerDissappear.h"
#include "server/zone/managers/combat/CombatManager.h"
#include "server/zone/managers/creature/CreatureManager.h"
#include "server/zone/managers/templates/TemplateManager.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "server/zone/objects/tangible/weapon/WeaponObject.h"
#include "server/zone/managers/templates/TemplateManager.h"
#include "server/zone/managers/creature/CreatureTemplate.h"
#include "server/zone/managers/creature/CreatureTemplateManager.h"
#include "server/zone/managers/combat/CombatManager.h"
#include "server/zone/packets/scene/UpdateTransformMessage.h"
#include "server/zone/packets/scene/LightUpdateTransformMessage.h"
#include "server/zone/packets/scene/LightUpdateTransformWithParentMessage.h"
#include "server/zone/packets/scene/UpdateTransformWithParentMessage.h"
#include "server/zone/packets/object/StringList.h"
#include "server/zone/packets/object/NpcConversationMessage.h"
#include "server/zone/packets/object/StartNpcConversation.h"
#include "server/zone/packets/object/StopNpcConversation.h"
#include "server/zone/objects/creature/events/DespawnCreatureTask.h"
#include "server/zone/Zone.h"
#include "server/zone/ZoneServer.h"
#include "PatrolPoint.h"
#include "AiObserver.h"

void AiAgentImplementation::loadTemplateData(SharedObjectTemplate* templateData) {
	CreatureObjectImplementation::loadTemplateData(templateData);
	objectTemplate = templateData;
}

void AiAgentImplementation::loadTemplateData(CreatureTemplate* templateData) {
	npcTemplate = templateData;

	setPvpStatusBitmask(npcTemplate->getPvpBitmask());
	//npcTemplate->getCreatureBitmask(); -- TODO: need to add a bitmask for AI (pack, herd, etc)
	level = npcTemplate->getLevel();

	Vector<String> wepgroups = npcTemplate->getWeapons();
	for (int i = 0; i < wepgroups.size(); ++i) {
		Vector<String> weptemps = CreatureTemplateManager::instance()->getWeapons(wepgroups.get(i));
		uint32 crc = weptemps.get(System::random(weptemps.size() - 1)).hashCode();
		ManagedReference<WeaponObject*> weao = dynamic_cast<WeaponObject*>(server->getZoneServer()->createObject(crc, 0));
		weao->setMinDamage((weao->getMinDamage() / 2) + npcTemplate->getDamageMin());
		weao->setMaxDamage((weao->getMaxDamage() / 2) + npcTemplate->getDamageMax());
		weapons.add(weao);
	}

	// add the default weapon
	weapons.add(getWeapon());

	// set the damage of the default weapon
	getWeapon()->setMinDamage(npcTemplate->getDamageMin());
	getWeapon()->setMaxDamage(npcTemplate->getDamageMax());

	int ham;
	baseHAM.removeAll();
	for (int i = 0; i < 9; ++i) {
		if (i % 3 == 0) {
			ham = System::random(npcTemplate->getBaseHAMmax() - npcTemplate->getBaseHAM()) + npcTemplate->getBaseHAM();
			baseHAM.add(ham);
		} else
			baseHAM.add(ham/100);
	}

	hamList.removeAll();
	for (int i = 0; i < 9; ++i) {
		hamList.add(baseHAM.get(i));
	}

	maxHamList.removeAll();
	for (int i = 0; i < 9; ++i) {
		maxHamList.add(baseHAM.get(i));
	}

	objectName = npcTemplate->getObjectName();
}

void AiAgentImplementation::initializeTransientMembers() {
	npcTemplate = NULL;

	SharedObjectTemplate* templ = TemplateManager::instance()->getTemplate(serverObjectCRC);
	objectTemplate = templ;
}

void AiAgentImplementation::doRecovery() {
	if (isDead() || zone == NULL)
		return;

	activateHAMRegeneration();
	activateStateRecovery();
	activatePostureRecovery();

	if (damageOverTimeList.hasDot() && damageOverTimeList.isNextTickPast()) {
		damageOverTimeList.activateDots(_this);
	}

	CreatureObject* target = damageMap.getHighestThreatCreature();

	if (target != NULL && !defenderList.contains(target))
		addDefender(target);

	if (target == NULL && defenderList.size() > 0) {
		SceneObject* tarObj = defenderList.get(0);
		if (tarObj->isCreatureObject())
			target = (CreatureObject*)tarObj;
	}

	if (!isInCombat() || defenderList.size() <= 0 || target == NULL) {
		tryRetreat();
		activateRecovery();
		return;
	}

	if (target != NULL && (!target->isInRange(_this, 128) || !target->isAttackableBy(_this))) {
		CombatManager::instance()->attemptPeace(target);
		activateRecovery();
		return;
	}

	if (commandQueue.size() > 5) {
		activateRecovery();
		return;
	}

	if (target != followObject)
		setDefender(target);

	selectWeapon();

	if (System::random(2) == 0) {
		// do special attack
		CreatureAttackMap* attackMap = npcTemplate->getAttacks();
		int attackNum = attackMap->getRandomAttackNumber();
		String args = attackMap->getArguments(attackNum);


		if (!validateStateAttack(target, args)) {
			// do default attack
			enqueueCommand(String("defaultattack").hashCode(), 0, target->getObjectID(), "");
		} else {
			// queue special attack
			unsigned int actionCRC = attackMap->getCommand(attackNum).hashCode();
			enqueueCommand(actionCRC, 0, target->getObjectID(), args);

			if (System::random(4) == 0) {
				// queue second special attack (rudimentary combo)
				int secondAttackNum = attackMap->getRandomAttackNumber();
				args = attackMap->getArguments(secondAttackNum);

				if (validateStateAttack(target, args) && secondAttackNum != attackNum) {
					actionCRC = attackMap->getCommand(attackNum).hashCode();
					enqueueCommand(actionCRC, 0, target->getObjectID(), args);
				}
			}
		}
	} else
		enqueueCommand(String("defaultattack").hashCode(), 0, target->getObjectID(), "");

	activateRecovery();
}

int AiAgentImplementation::notifyAttack(Observable* observable) {
	// TODO: add reaction attacks
	return 0;
}

int AiAgentImplementation::notifyCallForHelp(Observable* observable, ManagedObject* arg1) {
	// TODO: add aggroing
	return 0;
}

void AiAgentImplementation::selectWeapon() {
	float dist = getDistanceTo(followObject.get());
	float diff = 1024.f;
	WeaponObject* finalWeap = getWeapon();

	for (int i = 0; i < weapons.size(); ++i) {
		WeaponObject* weap = weapons.get(i);
		float range = abs(weap->getIdealRange() - dist);
		if (range < diff) {
			diff = range;
			finalWeap = weap;
		}
	}

	setWeapon(finalWeap, true);
}

bool AiAgentImplementation::validateStateAttack(CreatureObject* target, String& args) {
	StringTokenizer tokenizer(args);
	tokenizer.setDelimeter(";");

	while (tokenizer.hasMoreTokens()) {
		String singleArg;
		tokenizer.getStringToken(singleArg);

		if (singleArg.indexOf("Chance") != -1) {
			String stateName = singleArg.subString(0, args.indexOf("Chance"));
			uint64 state = CreatureState::getState(stateName);
			if (target->hasState(state) || (stateName == "postureDown" && target->isProne()) || (stateName == "knockdown" && target->isKnockedDown()) || (stateName == "postureUp" && target->isStanding())) {
				return false;

			}
		}
	}

	return true;
}

void AiAgentImplementation::setDespawnOnNoPlayerInRange(bool val) {
	if (despawnOnNoPlayerInRange == val)
		return;

	despawnOnNoPlayerInRange = val;

	if (val && numberOfPlayersInRange <= 0) {
		if (despawnEvent == NULL) {
			despawnEvent = new DespawnCreatureOnPlayerDissappear(_this);
		}

		if (!despawnEvent->isScheduled())
			despawnEvent->schedule(30000);
	}
}

bool AiAgentImplementation::tryRetreat() {
	try {
		if (homeLocation.getPositionX() == 0 && homeLocation.getPositionY() == 0 && homeLocation.getPositionZ() == 0)
			return false;

		if (lastSuccessfulCombatAction.miliDifference() <= 30000) {
			return false;
		} else if (homeLocation.isInRange(_this, 100))
			return false;

		setOblivious();

		showFlyText("npc_reaction/flytext", "afraid", 0xFF, 0, 0);

		homeLocation.setReached(false);

		damageMap.removeAll();

		patrolPoints.removeAll();
		patrolPoints.add(homeLocation);

		CombatManager::instance()->forcePeace(_this);

		activateMovementEvent();
	} catch (Exception& e) {
		error(e.getMessage());
		e.printStackTrace();
	} catch (...) {
		error("unreported exception caught in AiAgentImplementation::tryRetreat()");
	}

	return true;
}

void AiAgentImplementation::setDefender(SceneObject* defender) {
	CreatureObjectImplementation::setDefender(defender);

	AiObserver* observer;
	if (aiObserverMap.size() == 0) {
		observer = new AiObserver(_this);
		ObjectManager::instance()->persistObject(observer, 1, "aiobservers");
		aiObserverMap.put(observer);
	} else {
		observer = aiObserverMap.get(0);
		for (int i = 0; i < defenderList.size(); ++i)
			defenderList.get(i)->dropObserver(ObserverEventType::SPECIALATTACK, observer);
	}

	defender->registerObserver(ObserverEventType::SPECIALATTACK, observer);

	setFollowObject(defender);

	activateRecovery();
}

void AiAgentImplementation::addDefender(SceneObject* defender) {
	if (defenderList.size() == 0)
		showFlyText("npc_reaction/flytext", "threaten", 0xFF, 0, 0);

	CreatureObjectImplementation::addDefender(defender);

	activateRecovery();
}

void AiAgentImplementation::removeDefender(SceneObject* defender) {
	CreatureObjectImplementation::removeDefender(defender);

	if (defender != NULL) {
		if (defender->isCreatureObject())
			damageMap.dropDamage((CreatureObject*)defender);

		defender->dropObserver(ObserverEventType::SPECIALATTACK, aiObserverMap.get(0));
	}

	if (followObject == defender) {
		CreatureObject* target = damageMap.getHighestThreatCreature();

		if (target == NULL && defenderList.size() > 0) {
			SceneObject* tarObj = defenderList.get(0);
			if (tarObj->isCreatureObject())
				target = (CreatureObject*)tarObj;
		}

		if (target == NULL) {
			setOblivious();
		} else  {
			setDefender(target);
		}
	}

	activateRecovery();
}

/**
 * Cleares the combat state
 * @pre { this object is locked }
 * @post { this object is locked, this object is not in a combat state }
 * @param clearDefenders if true the defender vector willl be emptied
 */
void AiAgentImplementation::clearCombatState(bool clearDefenders) {
	CreatureObjectImplementation::clearCombatState(clearDefenders);

	damageMap.removeAll();

	setOblivious();
}

void AiAgentImplementation::notifyInsert(QuadTreeEntry* entry) {
	SceneObject* scno = (SceneObject*) (((SceneObjectImplementation*) entry)->_getStub());

	if (scno == _this)
		return;

	if (scno->isPlayerCreature())
		++numberOfPlayersInRange;
}

void AiAgentImplementation::clearDespawnEvent() {
	despawnEvent = NULL;
}

void AiAgentImplementation::respawn(Zone* zone, int level) {
	if (this->zone != NULL)
		return;

	setLevel(level);

	initializePosition(homeLocation.getPositionX(), homeLocation.getPositionZ(), homeLocation.getPositionY());

	SceneObject* cell = homeLocation.getCell();

	Locker zoneLocker(zone);

	if (cell != NULL)
		cell->addObject(_this, -1);

	insertToZone(zone);
}

void AiAgentImplementation::notifyDespawn(Zone* zone) {
	if (respawnTimer == 0)
		return;

	if (objectTemplate == NULL || npcTemplate == NULL)
		return;

	Reference<Task*> task = new RespawnCreatureTask(_this, zone, level);

	loadTemplateData(objectTemplate);
	loadTemplateData(npcTemplate);
	stateBitmask = 0;
	posture = CreaturePosture::UPRIGHT;
	shockWounds = 0;
	damageMap.removeAll();

	task->schedule(respawnTimer * 1000);
}

void AiAgentImplementation::scheduleDespawn() {

	Reference<DespawnCreatureTask*> despawn = new DespawnCreatureTask(_this);
	despawn->schedule(10000);
}

void AiAgentImplementation::notifyDissapear(QuadTreeEntry* entry) {
	SceneObject* scno = (SceneObject*) (((SceneObjectImplementation*) entry)->_getStub());

	if (scno == _this)
		return;

	if (scno->isPlayerCreature()) {
		if ((--numberOfPlayersInRange <= 0)  && (despawnEvent == NULL)) {
			despawnEvent = new DespawnCreatureOnPlayerDissappear(_this);
			despawnEvent->schedule(30000);
		}
	}
}

void AiAgentImplementation::activateAwarenessEvent(CreatureObject *target) {
	if (awarenessEvent == NULL) {
		awarenessEvent = new AiAwarenessEvent(_this, target);

		awarenessEvent->schedule(1000);
	}

	if (!awarenessEvent->isScheduled()) {
		awarenessEvent->setTarget(target);
		awarenessEvent->schedule(1000);
	}
}

void AiAgentImplementation::activateRecovery() {
	if (thinkEvent == NULL) {
		thinkEvent = new AiThinkEvent(_this);

		thinkEvent->schedule(2000);
	}

	if (!thinkEvent->isScheduled())
		thinkEvent->schedule(2000);
}

void AiAgentImplementation::activatePostureRecovery() {
	if (isProne() || isKnockedDown() || isKneeling())
		executeObjectControllerAction(0xA8A25C79); // stand
}

void AiAgentImplementation::updateCurrentPosition(PatrolPoint* pos) {
	PatrolPoint* nextPosition = pos;

	setPosition(nextPosition->getPositionX(), nextPosition->getPositionZ(),
		nextPosition->getPositionY());

	SceneObject* cell = nextPosition->getCell();

	/*StringBuffer reachedPosition;
	reachedPosition << "(" << positionX << ", " << positionY << ")";
	info("reached " + reachedPosition.toString(), true);*/

	if (cell != NULL)
		updateZoneWithParent(cell, false, false);
	else
		updateZone(false, false);
}


void AiAgentImplementation::checkNewAngle() {
	if (followObject == NULL)
		return;

	Vector3 thisWorldPos = getWorldPosition();
	Vector3 targetWorldPos = followObject->getWorldPosition();

	float directionangle = atan2(targetWorldPos.getX() - thisWorldPos.getX(), targetWorldPos.getY() - thisWorldPos.getY());

	/*StringBuffer msg;
	msg << "direction angle " << String::valueOf(directionangle) << " getRadians " << direction.getRadians();

	info(msg.toString(), true);*/

	if (directionangle < 0) {
		float a = M_PI + directionangle;
		directionangle = M_PI + a;
	}

	float err = fabs(directionangle - direction.getRadians());

	if (err < 0.05) {
		//info("not updating " + String::valueOf(directionangle), true);
		return;
	}

	direction.setHeadingDirection(directionangle);

	if (!nextStepPosition.isReached()) {
		broadcastNextPositionUpdate(&nextStepPosition);
	} else {
		++movementCounter;

		if (parent != NULL && parent->isCellObject())
			updateZoneWithParent(parent, true, true);
		else
			updateZone(true, true);
	}
}

void AiAgentImplementation::doMovement() {
	//info("doMovement", true);
	if (isDead() || zone == NULL)
		return;

	if (currentSpeed != 0) {
		updateCurrentPosition(&nextStepPosition);
		nextStepPosition.setReached(true);
	}

	float maxDistance = 5;

	if (followObject != NULL) {
		// drop everything and go after the target, this will also chase the target without having to reach them to change direction
		//patrolPoints.removeAll();

		switch (followState) {
		case AiAgent::OBLIVIOUS:
			break;
		case AiAgent::WATCHING:
			setNextPosition(getPositionX(), getPositionZ(), getPositionY(), getParent());
			setDirection(atan2(followObject->getPositionX() - getPositionX(), followObject->getPositionX() - getPositionX()));
			checkNewAngle();
			updateCurrentPosition(&patrolPoints.get(0));
			break;
		case AiAgent::STALKING:
			setNextPosition(followObject->getPositionX(), followObject->getPositionZ(), followObject->getPositionY(), followObject->getParent());
			maxDistance = 25;
			break;
		case AiAgent::FOLLOWING:
			setNextPosition(followObject->getPositionX(), followObject->getPositionZ(), followObject->getPositionY(), followObject->getParent());
			// stop in weapons range
			if (weapon != NULL )
				maxDistance = weapon->getIdealRange();
			break;
		default:
			setOblivious();
			break;
		}
	}

	if (isRetreating() || isFleeing())
		maxDistance = 0.5;

	float dist = 0;

	float dx, dy;
	ManagedReference<SceneObject*> cellObject;

	bool found = false;

	Vector3 thisWorldPos = getWorldPosition();
	PatrolPoint* nextPosition = NULL;

	while (!found && patrolPoints.size() != 0) {
		nextPosition = &patrolPoints.elementAt(0);

		cellObject = nextPosition->getCell();

		Vector3 nextWorldPos = nextPosition->getWorldPosition();

		dx = nextWorldPos.getX() - thisWorldPos.getX();
		dy = nextWorldPos.getY() - thisWorldPos.getY();

		dist = thisWorldPos.squaredDistanceTo(nextWorldPos);

		if (dist <= maxDistance * maxDistance && cellObject == parent) {
			patrolPoints.remove(0);

			nextPosition = NULL;
		} else
			found = true;
	}

	if (!found) {
		currentSpeed = 0;
		//info("not found in doMovement", true);

		if (isRetreating())
			homeLocation.setReached(true);

		if (isFleeing())
			fleeing = false;

		if (followObject != NULL)
			activateMovementEvent();
		else
			notifyObservers(ObserverEventType::DESTINATIONREACHED);

		return;
	}

	if (!isStanding()) {
		activateMovementEvent();
		return;
	}

	float newPositionX, newPositionZ, newPositionY;

	float updateTicks = float(UPDATEMOVEMENTINTERVAL) / 1000.f;

	//info("runSpeed: " + String::valueOf(runSpeed), true);

	float newSpeed = runSpeed;
	if (followObject == NULL && !isFleeing() && !isRetreating()) // TODO: think about implementing a more generic "walk, don't run" criterion
		newSpeed = walkSpeed;

	currentSpeed = newSpeed;
	newSpeed *= updateTicks;

	dist = Math::sqrt(dist);

	newPositionX = thisWorldPos.getX() + (newSpeed * (dx / dist));
	newPositionY = thisWorldPos.getY() + (newSpeed * (dy / dist));
	newPositionZ = zone->getHeight(newPositionX, newPositionY);

	float directionangle = atan2(newPositionX - thisWorldPos.getX(), newPositionY - thisWorldPos.getY());

	direction.setHeadingDirection(directionangle);

	if ((parent != NULL && parent != cellObject) || (cellObject != NULL && dist <= newSpeed)) {
		nextStepPosition = *nextPosition;
	} else {
		if (dist <= newSpeed)
			nextStepPosition = *nextPosition;
		else
			nextStepPosition.setPosition(newPositionX, newPositionZ, newPositionY);

		nextStepPosition.setCell(NULL);
	}

	nextStepPosition.setReached(false);

	broadcastNextPositionUpdate(&nextStepPosition);

	activateMovementEvent();
}

void AiAgentImplementation::activateMovementEvent() {
	if (moveEvent == NULL) {
		moveEvent = new AiMoveEvent(_this);

		moveEvent->schedule(UPDATEMOVEMENTINTERVAL);
	}

	if (!moveEvent->isScheduled())
		moveEvent->schedule(UPDATEMOVEMENTINTERVAL);
}

void AiAgentImplementation::activateWaitEvent() {
	if (waitEvent == NULL) {
		waitEvent = new AiWaitEvent(_this);

		waitEvent->schedule(UPDATEMOVEMENTINTERVAL * 10);
	}

	if (!waitEvent->isScheduled())
		waitEvent->schedule(UPDATEMOVEMENTINTERVAL * 10);
}

void AiAgentImplementation::setNextPosition(float x, float z, float y, SceneObject* cell) {
	PatrolPoint point(x, z, y, cell);

	if (patrolPoints.size() == 0)
		patrolPoints.add(point);
	else
		patrolPoints.setElementAt(0, point);
}

void AiAgentImplementation::broadcastNextPositionUpdate(PatrolPoint* point) {
	BasePacket* msg = NULL;
	++movementCounter;

	if (point == NULL) {
		if (parent != NULL)
			msg = new UpdateTransformWithParentMessage(_this);
		else
			msg = new UpdateTransformMessage(_this);
	} else {
		if (point->getCell() != NULL)
			msg = new LightUpdateTransformWithParentMessage(_this, point->getPositionX(), point->getPositionZ(), point->getPositionY(), point->getCell()->getObjectID());
		else
			msg = new LightUpdateTransformMessage(_this, point->getPositionX(), point->getPositionZ(), point->getPositionY());
	}

	broadcastMessage(msg, false);
}

int AiAgentImplementation::notifyObjectDestructionObservers(TangibleObject* attacker, int condition) {
	if (zone != NULL) {
		CreatureManager* creatureManager = zone->getCreatureManager();

		creatureManager->notifyDestruction(attacker, _this, condition);
	}

	return CreatureObjectImplementation::notifyObjectDestructionObservers(attacker, condition);
}

int AiAgentImplementation::notifyConverseObservers(CreatureObject* converser) {
	notifyObservers(ObserverEventType::CONVERSE, converser);

	return 1;
}

int AiAgentImplementation::inflictDamage(TangibleObject* attacker, int damageType, int damage, bool destroy, bool notifyClient) {
	activateRecovery();

	if (attacker->isPlayerCreature()) {
		PlayerCreature* player = (PlayerCreature*) attacker;

		if (damage > 0) {
			damageMap.addDamage(player, damage);

			if (System::random(5) == 1) {
				setDefender(player);
			}
		}
	}

	return CreatureObjectImplementation::inflictDamage(attacker, damageType, damage, destroy, notifyClient);
}


void AiAgentImplementation::fillAttributeList(AttributeListMessage* alm, PlayerCreature* player) {

	if (isDead()) {
		return;
	}

	if (getArmor() == 0)
		alm->insertAttribute("armorrating", "None");
	else if (getArmor() == 1)
		alm->insertAttribute("armorrating", "Light");
	else if (getArmor() == 2)
		alm->insertAttribute("armorrating", "Medium");
	else if (getArmor() == 3)
		alm->insertAttribute("armorrating", "Heavy");

	if (getKinetic() == 100)
		alm->insertAttribute("cat_armor_special_protection.armor_eff_kinetic", "100%");

	if (getEnergy() == 100)
		alm->insertAttribute("cat_armor_special_protection.armor_eff_energy", "100%");

	if (getElectricity() == 100)
		alm->insertAttribute("cat_armor_special_protection.armor_eff_elemental_electrical", "100%");

	if (getStun() == 100)
		alm->insertAttribute("cat_armor_special_protection.armor_eff_stun", "100%");

	if (getBlast() == 100)
		alm->insertAttribute("cat_armor_special_protection.armor_eff_blast", "100%");

	if (getHeat() == 100)
		alm->insertAttribute("cat_armor_special_protection.armor_eff_elemental_heat", "100%");

	if (getCold() == 100)
		alm->insertAttribute("cat_armor_special_protection.armor_eff_elemental_cold", "100%");

	if (getAcid() == 100)
		alm->insertAttribute("cat_armor_special_protection.armor_eff_elemental_acid", "100%");

	if (getLightSaber() == 100)
		alm->insertAttribute("cat_armor_special_protection.armor_eff_restraint", "100%");

	if (getKinetic() > 0 && getKinetic() < 100) {
		StringBuffer txt;
		txt << round(getKinetic()) << "%";
		alm->insertAttribute("cat_armor_effectiveness.armor_eff_kinetic", txt.toString());
	}

	if (getEnergy() > 0 && getEnergy() < 100) {
		StringBuffer txt;
		txt << round(getEnergy()) << "%";
		alm->insertAttribute("cat_armor_effectiveness.armor_eff_energy", txt.toString());
	}

	if (getElectricity() > 0 && getElectricity() < 100) {
		StringBuffer txt;
		txt << round(getElectricity()) << "%";
		alm->insertAttribute("cat_armor_effectiveness.armor_eff_elemental_electrical", txt.toString());
	}

	if (getStun() > 0 && getStun() < 100) {
		StringBuffer txt;
		txt << round(getStun()) << "%";
		alm->insertAttribute("cat_armor_effectiveness.armor_eff_stun", txt.toString());
	}

	if (getBlast() > 0 && getBlast() < 100) {
		StringBuffer txt;
		txt << round(getBlast()) << "%";
		alm->insertAttribute("cat_armor_effectiveness.armor_eff_blast", txt.toString());
	}

	if (getHeat() > 0 && getHeat() < 100) {
		StringBuffer txt;
		txt << round(getHeat()) << "%";
		alm->insertAttribute("cat_armor_effectiveness.armor_eff_elemental_heat", txt.toString());
	}

	if (getCold() > 0 && getCold() < 100) {
		StringBuffer txt;
		txt << round(getCold()) << "%";
		alm->insertAttribute("cat_armor_effectiveness.armor_eff_elemental_cold", txt.toString());
	}

	if (getAcid() > 0 && getAcid() < 100) {
		StringBuffer txt;
		txt << round(getAcid()) << "%";
		alm->insertAttribute("cat_armor_effectiveness.armor_eff_elemental_acid", txt.toString());
	}

	if (getLightSaber() > 0 && getLightSaber() < 100) {
		StringBuffer txt;
		txt << round(getLightSaber()) << "%";
		alm->insertAttribute("cat_armor_effectiveness.armor_eff_restraint", txt.toString());
	}

	if (getKinetic() == 0)
		alm->insertAttribute("cat_armor_vulnerability.armor_eff_kinetic", "-");

	if (getEnergy() == 0)
		alm->insertAttribute("cat_armor_vulnerability.armor_eff_energy", "-");

	if (getElectricity() == 0)
		alm->insertAttribute("cat_armor_vulnerability.armor_eff_elemental_electrical", "-");

	if (getStun() == 0)
		alm->insertAttribute("cat_armor_vulnerability.armor_eff_stun", "-");

	if (getBlast() == 0)
		alm->insertAttribute("cat_armor_vulnerability.armor_eff_blast", "-");

	if (getHeat() == 0)
		alm->insertAttribute("cat_armor_vulnerability.armor_eff_elemental_heat", "-");

	if (getCold() == 0)
		alm->insertAttribute("cat_armor_vulnerability.armor_eff_elemental_cold", "-");

	if (getAcid() == 0)
		alm->insertAttribute("cat_armor_vulnerability.armor_eff_elemental_acid", "-");

	if (getLightSaber() == 0)
		alm->insertAttribute("cat_armor_vulnerability.armor_eff_restraint", "-");
}


void AiAgentImplementation::sendConversationStartTo(SceneObject* player) {
	if (!player->isPlayerCreature())
		return;

	SortedVector<ManagedReference<Observer*> >* observers = observerEventMap.getObservers(ObserverEventType::CONVERSE);

	if (observers == NULL || (observers != NULL && observers->size() <= 0))
		sendDefaultConversationTo(player);
	else
		notifyConverseObservers((CreatureObject*)player);
}

void AiAgentImplementation::sendDefaultConversationTo(SceneObject* player) {
	if (!player->isPlayerCreature())
		return;

	PlayerCreature* playerCreature = (PlayerCreature*) player;

	//player->setLastNpcConvStr(("npc_" + getFu().toString()));
	playerCreature->setLastNpcConvMessStr("0,init");

	StartNpcConversation* conv = new StartNpcConversation(playerCreature, getObjectID(), "");
	player->sendMessage(conv);

	String responseFile, responseAttitude;

	if (responseFile == "") {
		if (isImperial()) {
			responseFile = "npc_reaction/stormtrooper";
		} else if (isRebel()) {
			responseFile = "npc_reaction/military";
		} else {
			short file = System::random(2);
			if (file == 0)
				responseFile = "npc_reaction/fancy";
			else if (file == 1)
				responseFile = "npc_reaction/slang";
			else
				responseFile = "npc_reaction/townperson";
		}
	}

	if (responseAttitude == "") {
		short type = System::random(2);
		if (type == 0)
			responseAttitude = "mean";
		else if (type == 1)
			responseAttitude = "mid";
		else
			responseAttitude = "nice";
	}

	StringBuffer convoChoice;
	convoChoice << "hi_" <<  responseAttitude << "_" << (System::random(15) + 1);

	//TODO: Revisit NPC Conversation
	//NpcConversationMessage* initial = new NpcConversationMessage(
	//		playerCreature, responseFile, convoChoice.toString());
	//player->sendMessage(initial);

	// Parse and send the options:
	//StringList* slist = new StringList(playerCreature);

	//String test = "I'm looking for work";
	//slist->insertOption(test);

	//player->sendMessage(slist);

	//playerCreature->setLastNpcConvMessStr("chitchat");
}

void AiAgentImplementation::selectConversationOption(int option, SceneObject* obj) {
	if (!obj->isPlayerCreature())
		return;

	PlayerCreature* player = (PlayerCreature*) obj;

	String chk = player->getLastNpcConvMessStr();

	if (chk != "chitchat") {
		return;
	}

	UnicodeString saying = "";
	switch(System::random(5)) {
	case 0:
		saying = "Why the heck would you want to work when welfare is free.";
		break;
	case 1:
		saying = "Pfft, work in this economy?  I'm waiting for the government to bail me out.";
		break;
	case 2:
		saying = "Check the missions terminals, they are overflowing with work.";
		break;
	case 3:
		saying = "Huh, work?  Whats that?";
		break;
	case 4:
		saying = "Did you check the mission terminals?";
		break;
	case 5:
		saying = "Me too.";
		break;
	}

	NpcConversationMessage* response = new NpcConversationMessage(
			player, saying);
	player->sendMessage(response);

	// Parse and send the options:
	StringList* slist = new StringList(player);
	player->sendMessage(slist);
}
