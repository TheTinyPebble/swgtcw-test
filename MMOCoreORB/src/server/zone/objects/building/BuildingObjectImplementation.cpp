/*
 * BuildingObjectImplementation.cpp
 *
 *  Created on: 23/07/2009
 *      Author: TheAnswer
 */

#include "BuildingObject.h"
#include "server/zone/Zone.h"
#include "server/zone/ZoneServer.h"
#include "server/zone/objects/cell/CellObject.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "server/zone/objects/structure/StructureObject.h"

#include "../../templates/tangible/SharedBuildingObjectTemplate.h"
#include "../tangible/terminal/structure/StructureTerminal.h"

#include "../player/sui/listbox/SuiListBox.h"
#include "../player/sui/inputbox/SuiInputBox.h"

#include "server/zone/objects/tangible/sign/SignObject.h"
#include "server/zone/packets/tangible/TangibleObjectMessage3.h"
#include "server/zone/packets/tangible/TangibleObjectMessage6.h"
#include "server/zone/packets/cell/UpdateCellPermissionsMessage.h"

void BuildingObjectImplementation::initializeTransientMembers() {
	TangibleObjectImplementation::initializeTransientMembers();

	setLoggingName("BuildingObject");
}

void BuildingObjectImplementation::loadTemplateData(SharedObjectTemplate* templateData) {
	StructureObjectImplementation::loadTemplateData(templateData);

	SharedBuildingObjectTemplate* buildingData = dynamic_cast<SharedBuildingObjectTemplate*>(templateData);

	totalCellNumber = buildingData->getTotalCellNumber();

	containerVolumeLimit = 0xFFFFFFFF;

	containerType = 2;

	optionsBitmask = 0x00000100;

	publicStructure = buildingData->isPublicStructure();
}

int BuildingObjectImplementation::getCurrentNumerOfPlayerItems() {
	int items = 0;

	for (int i = 0; i < cells.size(); ++i) {
		CellObject* cell = cells.get(i);

		items += cell->getCurrentNumerOfPlayerItems();
	}

	return items;
}

void BuildingObjectImplementation::sendContainerObjectsTo(SceneObject* player) {
	for (int i = 0; i < cells.size(); ++i) {
		CellObject* cell = cells.get(i);

		if (cell->getParent() == NULL)
			cell->setParent(_this);

		cell->setCellNumber(i + 1);
		cell->sendTo(player, true);
	}
}

void BuildingObjectImplementation::sendTo(SceneObject* player, bool doClose) {
	info("building sendto..");

	if (!isStaticBuilding()) { // send Baselines etc..
		info("sending building object create");

		SceneObjectImplementation::sendTo(player, doClose);
	} else { // just send the objects that are in the building, without the cells because they are static in the client
		for (int i = 0; i < cells.size(); ++i) {
			CellObject* cell = cells.get(i);

			for (int j = 0; j < cell->getContainerObjectsSize(); ++j) {
				SceneObject* childStub = cell->getContainerObject(j);

				if (!childStub->isInQuadTree())
					childStub->sendTo(player, true);
			}
		}
	}
}

Vector3 BuildingObjectImplementation::getEjectionPoint() {
	Vector3 ejectionPoint = getWorldPosition();

	float x = ejectionPoint.getX();
	float y = ejectionPoint.getY();

	float halfLength = ((float) (length) * 8.0f) / 2.0f; //Half the length of the structure in meters.
	float radians = getDirection()->getRadians() + Math::deg2rad(270); //Ejection point should be on south side of structure.

	ejectionPoint.setX(x + (Math::cos(radians) * halfLength));
	ejectionPoint.setY(y + (Math::sin(radians) * halfLength));

	return ejectionPoint;
}

void BuildingObjectImplementation::removeFromZone() {
	for (int i = 0; i < cells.size(); ++i) {
		CellObject* cell = cells.get(i);

		cell->resetCurrentNumerOfPlayerItems();

		while (cell->getContainerObjectsSize() > 0) {
			ManagedReference<SceneObject*> obj = cell->getContainerObject(0);

			obj->removeFromZone();

			cell->removeObject(obj);

			VectorMap<uint64, ManagedReference<SceneObject*> >* cont = cell->getContainerObjects();

			if (cont->size() > 0)
				cont->remove(0);
			//cont->drop(obj->getObjectID());
		}

		if (signObject != NULL) {
			signObject->removeFromZone();
		}
	}

	TangibleObjectImplementation::removeFromZone();
}

void BuildingObjectImplementation::sendDestroyTo(SceneObject* player) {
	if (!isStaticBuilding()) {
		info("sending building object destroy");

		SceneObjectImplementation::destroy(player->getClient());
	}
}

void BuildingObjectImplementation::sendBaselinesTo(SceneObject* player) {
	//send buios here
	info("sending building baselines");

	BaseMessage* buio3 = new TangibleObjectMessage3(_this);
	player->sendMessage(buio3);

	BaseMessage* buio6 = new TangibleObjectMessage6(_this);
	player->sendMessage(buio6);
}

void BuildingObjectImplementation::notifyInsertToZone(SceneObject* object) {
	//info("BuildingObjectImplementation::notifyInsertToZone");
	SceneObjectImplementation* creoImpl = (SceneObjectImplementation*) object->_getImplementation();

	for (int i = 0; i < inRangeObjectCount(); ++i) {
		QuadTreeEntry* obj = getInRangeObject(i);
		SceneObjectImplementation* objImpl = (SceneObjectImplementation*) obj;

		creoImpl->addInRangeObject(obj, true);
		obj->addInRangeObject(creoImpl, true);
	}

	for (int i = 0; i < cells.size(); ++i) {
		CellObject* cell = cells.get(i);

		if (isStaticBuilding()) {
			for (int j = 0; j < cell->getContainerObjectsSize(); ++j) {
				SceneObject* childStub = cell->getContainerObject(j);
				SceneObjectImplementation* child = (SceneObjectImplementation*) childStub->_getImplementation();

				//if (childStub->isInRange(object, 128)) {
				child->addInRangeObject(creoImpl, false);

				if (childStub != object) {
					creoImpl->notifyInsert(child);
					//child->sendTo(object, true);
				}

				creoImpl->addInRangeObject(child, false);

				if (childStub != object) {
					//object->sendTo(childStub, true);
					child->notifyInsert(creoImpl);
				}

				//}
			}
		}
	}

	creoImpl->addInRangeObject(this, false);
	addInRangeObject(creoImpl, false);
	//this->sendTo(object, true);
}

void BuildingObjectImplementation::notifyInsert(QuadTreeEntry* obj) {
	//info("BuildingObjectImplementation::notifyInsert");
	SceneObjectImplementation* scno = (SceneObjectImplementation*) obj;

	for (int i = 0; i < cells.size(); ++i) {
		CellObject* cell = cells.get(i);

		for (int j = 0; j < cell->getContainerObjectsSize(); ++j) {
			SceneObject* childStub = cell->getContainerObject(j);

			/*if (childStub->isCreatureObject()
					|| (scno->getRootParent() == _this) && (scno->isInRange(childStub, 128))) {*/

				SceneObjectImplementation* child = (SceneObjectImplementation*) childStub->_getImplementation();

				if (isStaticBuilding()) {
					child->addInRangeObject(obj, false);
					obj->addInRangeObject(child, false);
				}
			//}
		}
	}
}

void BuildingObjectImplementation::notifyDissapear(QuadTreeEntry* obj) {
	SceneObjectImplementation* scno = (SceneObjectImplementation*) obj;

	SceneObject* scnoStub = (SceneObject*) scno->_getStub();

	removeNotifiedSentObject(scnoStub);

	for (int i = 0; i < cells.size(); ++i) {
		CellObject* cell = cells.get(i);

		for (int j = 0; j < cell->getContainerObjectsSize(); ++j) {
			SceneObject* childStub = cell->getContainerObject(j);
			SceneObjectImplementation* child = (SceneObjectImplementation*) childStub->_getImplementation();

			child->removeInRangeObject(obj);
			obj->removeInRangeObject(child);
		}
	}
}

void BuildingObjectImplementation::insert(QuadTreeEntry* entry) {
	QuadTree::insert(entry);
}

void BuildingObjectImplementation::remove(QuadTreeEntry* entry) {
	QuadTree::remove(entry);
}

void BuildingObjectImplementation::update(QuadTreeEntry* entry) {
	QuadTree::update(entry);
}

void BuildingObjectImplementation::inRange(QuadTreeEntry* entry, float range) {
	QuadTree::inRange(entry, range);
}

void BuildingObjectImplementation::addCell(CellObject* cell) {
	cells.add(cell);

	cell->setCellNumber(cells.size());

	if (!addObject(cell, -1))
		error("could not add cell");
}

void BuildingObjectImplementation::destroyObjectFromDatabase(bool destroyContainedObjects) {
	StructureObjectImplementation::destroyObjectFromDatabase(destroyContainedObjects);


	if (!destroyContainedObjects)
		return;

	ManagedReference<SceneObject*> deed = getZoneServer()->getObject(deedObjectID);

	if (deed != NULL)
		deed->destroyObjectFromDatabase(true);

	if (signObject != NULL)
		signObject->destroyObjectFromDatabase(true);

	//Loop through the cells and delete all objects from the database.
}

void BuildingObjectImplementation::updateCellPermissionsTo(SceneObject* player) {
/*	if (!player->isInRange(_this, 256))
		return;*/

	bool allowEntry = true;

	if (!isPublicStructure() && (!isOnEntryList(player) && !isOnAccessList(player)))
		allowEntry = false;

	if (isOnBanList(player))
		allowEntry = false;

	//If they don't have permission to be inside, kick them out.
	if (!allowEntry && player->getParentRecursively(SceneObject::BUILDING) == _this) {
		Vector3 ejectionPoint = getEjectionPoint();
		player->teleport(ejectionPoint.getX(), zone->getHeight(ejectionPoint.getX(), ejectionPoint.getY()), ejectionPoint.getY(), 0);
	}

	//Always allow privileged players to enter any structure.
	if (player->isPlayerCreature() && ((PlayerCreature*) player)->getPlayerObject()->isPrivileged())
		allowEntry = true;

	for (int i = 0; i < cells.size(); ++i) {
		ManagedReference<CellObject*> cell = getCell(i);

		if (cell == NULL)
			continue;

		BaseMessage* perm = new UpdateCellPermissionsMessage(cell->getObjectID(), allowEntry);
		player->sendMessage(perm);
	}
}

void BuildingObjectImplementation::onEnter(PlayerCreature* player) {
	if (zone == NULL)
		return;

	if (isStaticObject())
		return;

	Vector3 ejectionPoint = getEjectionPoint();
	float x = ejectionPoint.getX();
	float y = ejectionPoint.getY();
	float z = zone->getHeight(x, y);

	//Locker _locker(zone);

	if (isOnBanList(player)) {
		player->teleport(x, z, y, 0);
		return;
	}

	if (!isPublicStructure()) {
		if (!isOnEntryList(player))
			player->teleport(x, z, y, 0);
	} else {
		if (getAccessFee() > 0 && !isOnAccessList(player)) {
			//Send access fee popup menu.

			//Kick the player out.
			player->teleport(x, z, y, 0);
		}
	}
}
