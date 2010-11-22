/*
 * CellObjectImplementation.cpp
 *
 *  Created on: 23/07/2009
 *      Author: TheAnswer
 */

#include "CellObject.h"
#include "server/zone/objects/building/BuildingObject.h"
#include "server/zone/packets/cell/CellObjectMessage3.h"
#include "server/zone/packets/cell/CellObjectMessage6.h"
#include "server/zone/packets/cell/UpdateCellPermissionsMessage.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/zone/Zone.h"

void CellObjectImplementation::initializeTransientMembers() {
	SceneObjectImplementation::initializeTransientMembers();

	setLoggingName("CellObject");
}

void CellObjectImplementation::loadTemplateData(SharedObjectTemplate* templateData) {
	SceneObjectImplementation::loadTemplateData(templateData);

	containerVolumeLimit = 0xFFFFFFFF;

	containerType = 2;
}

void CellObjectImplementation::sendContainerObjectsTo(SceneObject* player) {
	//SceneObjectImplementation::sendContainerObjectsTo(player);
	//info("sending cell containers", true);

	for (int j = 0; j < containerObjects.size(); ++j) {
		SceneObject* containerObject = containerObjects.get(j);

		if (containerObject->getParent() == NULL)
			containerObject->setParent(_this);

		if (!containerObject->isInQuadTree() /*&& !containerObject->isPlayerCreature()*/)
			containerObject->sendTo(player, true);
	}
}

/*void CellObjectImplementation::sendTo(SceneObject* player, bool doClose) {
	SceneObjectImplementation::sendTo(player, true);
}*/

void CellObjectImplementation::sendBaselinesTo(SceneObject* player) {
	/*StringBuffer msg;
	msg << "sending cell number " << cellNumber << " baselines";
	info(msg.toString(), true);*/

	BaseMessage* cellMsg3 = new CellObjectMessage3(getObjectID(), cellNumber);
	player->sendMessage(cellMsg3);

	BaseMessage* cellMsg6 = new CellObjectMessage6(getObjectID());
	player->sendMessage(cellMsg6);

	//Check if the player has permission to enter the cell.
	bool allowEntry = true;

	if (parent != NULL && parent->isBuildingObject()) {
		ManagedReference<BuildingObject*> buildingObject = (BuildingObject*) parent.get();

		if (!buildingObject->isPublicStructure()) {
			if (!buildingObject->isOnEntryList(player) && !buildingObject->isOnAccessList(player))
				allowEntry = false;
		}
	}

	if (player->isPlayerCreature() && ((PlayerCreature*) player)->getPlayerObject()->isPrivileged())
		allowEntry = true;

	BaseMessage* perm = new UpdateCellPermissionsMessage(getObjectID(), allowEntry);
	player->sendMessage(perm);
}

int CellObjectImplementation::canAddObject(SceneObject* object, int containmentType, String& errorDescription) {
	if (parent != NULL && parent->isBuildingObject()) {
		ManagedReference<BuildingObject*> building = (BuildingObject*) parent.get();

		if (building->getCurrentNumerOfPlayerItems() >= BuildingObject::MAXPLAYERITEMS) {
			errorDescription = "@container_error_message:container13";

			return TransferErrorCode::TOOMANYITEMSINHOUSE;
		}
	}

	return SceneObjectImplementation::canAddObject(object, containmentType, errorDescription);
}

bool CellObjectImplementation::addObject(SceneObject* object, int containmentType, bool notifyClient) {
	Locker locker(_this);

	bool count = false;

	if (!object->isTerminal() && !object->isCreatureObject() && !containerObjects.contains(object->getObjectID()))
		count = true;

	bool ret = SceneObjectImplementation::addObject(object, containmentType, notifyClient);

	if (count && ret) {
		++currentNumberOfItems;
	}

	return ret;
}

bool CellObjectImplementation::removeObject(SceneObject* object, bool notifyClient) {
	Locker locker(_this);

	bool ret = SceneObjectImplementation::removeObject(object, notifyClient);

	if (ret && !object->isTerminal() && !object->isCreatureObject()) {
		if (currentNumberOfItems > 0)
			--currentNumberOfItems;
	}

	return ret;
}
