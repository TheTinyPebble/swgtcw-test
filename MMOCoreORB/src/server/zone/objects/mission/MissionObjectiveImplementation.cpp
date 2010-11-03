/*
 * MissionObjectiveImplementation.cpp
 *
 *  Created on: 22/06/2010
 *      Author: victor
 */

#include "server/zone/ZoneProcessServer.h"
#include "MissionObjective.h"
#include "MissionObserver.h"
#include "MissionObject.h"
#include "server/zone/managers/object/ObjectManager.h"

void MissionObjectiveImplementation::destroyObjectFromDatabase() {
	for (int i = 0; i < observers.size(); ++i) {
		MissionObserver* observer = observers.get(i);

		observer->destroyObjectFromDatabase();
	}

	ObjectManager::instance()->destroyObjectFromDatabase(_this->_getObjectID());
}

PlayerCreature* MissionObjectiveImplementation::getPlayerOwner() {
	PlayerCreature* player = (PlayerCreature*) mission->getParentRecursively(SceneObject::PLAYERCREATURE);

	return player;
}
