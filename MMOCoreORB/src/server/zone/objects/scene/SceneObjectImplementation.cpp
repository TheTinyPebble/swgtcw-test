/*
Copyright (C) 2007 <SWGEmu>

This File is part of Core3.

This program is free software; you can redistribute
it and/or modify it under the terms of the GNU Lesser
General Public License as published by the Free Software
Foundation; either version 2 of the License,
or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Lesser General Public License for
more details.

You should have received a copy of the GNU Lesser General
Public License along with this program; if not, write to
the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

Linking Engine3 statically or dynamically with other modules
is making a combined work based on Engine3.
Thus, the terms and conditions of the GNU Lesser General Public License
cover the whole combination.

In addition, as a special exception, the copyright holders of Engine3
give you permission to combine Engine3 program with free software
programs or libraries that are released under the GNU LGPL and with
code included in the standard release of Core3 under the GNU LGPL
license (or modified versions of such code, with unchanged license).
You may copy and distribute such a system following the terms of the
GNU LGPL for Engine3 and the licenses of the other code concerned,
provided that you include the source code of that other code when
and as the GNU LGPL requires distribution of source code.

Note that people who make modified versions of Engine3 are not obligated
to grant this special exception for their modified versions;
it is their choice whether to do so. The GNU Lesser General Public License
gives permission to release a modified version without this exception;
this exception also makes it possible to release a modified version
which carries forward this exception.
*/

#include "SceneObject.h"

#include "server/zone/managers/object/ObjectManager.h"
#include "server/zone/managers/objectcontroller/ObjectController.h"

#include "server/zone/packets/scene/SceneObjectCreateMessage.h"
#include "server/zone/packets/scene/SceneObjectDestroyMessage.h"
#include "server/zone/packets/scene/SceneObjectCloseMessage.h"
#include "server/zone/packets/scene/UpdateContainmentMessage.h"
#include "server/zone/packets/scene/UpdateTransformMessage.h"
#include "server/zone/packets/scene/UpdateTransformWithParentMessage.h"
#include "server/zone/packets/scene/LightUpdateTransformMessage.h"
#include "server/zone/packets/scene/LightUpdateTransformWithParentMessage.h"
#include "server/zone/packets/scene/AttributeListMessage.h"
#include "server/zone/packets/scene/ClientOpenContainerMessage.h"
#include "server/zone/packets/object/DataTransform.h"
#include "server/zone/packets/object/DataTransformWithParent.h"
#include "server/zone/managers/planet/PlanetManager.h"
#include "server/zone/managers/terrain/TerrainManager.h"
#include "server/zone/managers/templates/TemplateManager.h"
#include "server/zone/packets/object/ObjectMenuResponse.h"

#include "server/zone/ZoneClientSession.h"
#include "server/zone/Zone.h"
#include "server/zone/ZoneServer.h"
#include "server/zone/ZoneProcessServerImplementation.h"

#include "variables/StringId.h"
#include "events/ObjectUpdateToDatabaseTask.h"

#include "server/zone/objects/cell/CellObject.h"
#include "server/zone/objects/scene/Facade.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "server/zone/objects/building/BuildingObject.h"
#include "server/zone/templates/ChildObject.h"

void SceneObjectImplementation::initializeTransientMembers() {
	ManagedObjectImplementation::initializeTransientMembers();

	server = ZoneProcessServerImplementation::instance;

	templateObject = TemplateManager::instance()->getTemplate(serverObjectCRC);

	movementCounter = 0;

	//activeAreas.removeAll();

	setGlobalLogging(true);
	setLogging(false);

	setLoggingName("SceneObject");
}

void SceneObjectImplementation::initializePrivateData() {
	notifiedSentObjects.setNoDuplicateInsertPlan();
	slottedObjects.setNullValue(NULL);
	slottedObjects.setNoDuplicateInsertPlan();
	containerObjects.setNullValue(NULL);
	containerObjects.setNoDuplicateInsertPlan();
	pendingTasks.setNoDuplicateInsertPlan();
	pendingTasks.setNullValue(NULL);
	objectActiveSessions.setNullValue(NULL);
	objectActiveSessions.setNoDuplicateInsertPlan();
	activeAreas.setNoDuplicateInsertPlan();

	server = NULL;

	templateObject = NULL;

	parent = NULL;

	movementCounter = 0;

	serverObjectCRC = 0;
	clientObjectCRC = 0;

	containerType = 0;
	containerVolumeLimit = 0;
	gameObjectType = 0;
	containmentType = 0;

	zone = NULL;

	containmentType = 4;

	initializePosition(0.f, 0.f, 0.f);

	movementCounter = 0;

	staticObject = false;

	setGlobalLogging(true);
	setLogging(false);

	setLoggingName("SceneObject");
}

void SceneObjectImplementation::loadTemplateData(SharedObjectTemplate* templateData) {
	slottedObjects.setNullValue(NULL);
	objectName.setStringId(templateData->getObjectName());

	detailedDescription.setStringId(templateData->getDetailedDescription());

	containerType = templateData->getContainerType();
	containerVolumeLimit = templateData->getContainerVolumeLimit();

	gameObjectType = templateData->getGameObjectType();

	clientObjectCRC = templateData->getClientObjectCRC();

	arrangementDescriptors = templateData->getArrangementDescriptors();

	slotDescriptors = templateData->getSlotDescriptors();

	templateObject = templateData;
}

void SceneObjectImplementation::create(ZoneClientSession* client) {
	BaseMessage* msg = new SceneObjectCreateMessage(_this);

	client->sendMessage(msg);
}

void SceneObjectImplementation::close(ZoneClientSession* client) {
	BaseMessage* msg = new SceneObjectCloseMessage(_this);

	client->sendMessage(msg);
}

void SceneObjectImplementation::link(ZoneClientSession* client, uint32 containmentType) {
	BaseMessage* msg = new UpdateContainmentMessage(_this, parent, containmentType);
	client->sendMessage(msg);
}

BaseMessage* SceneObjectImplementation::link(uint64 objectID, uint32 containmentType) {
	return new UpdateContainmentMessage(getObjectID(), objectID, containmentType);
}

void SceneObjectImplementation::updateToDatabase() {
	updateToDatabaseAllObjects(true);
}

void SceneObjectImplementation::updateToDatabaseWithoutChildren() {
	ZoneServer* server = getZoneServer();
	server->updateObjectToDatabase(_this);
}

void SceneObjectImplementation::updateToDatabaseAllObjects(bool startTask) {
	if (!isPersistent())
		return;

	Time start;

	ZoneServer* server = getZoneServer();
	server->updateObjectToDatabase(_this);

	SortedVector<SceneObject*> savedObjects(slottedObjects.size() + 1, 5);
	savedObjects.setNoDuplicateInsertPlan();

	for (int i = 0; i < slottedObjects.size(); ++i) {
		ManagedReference<SceneObject*> object = slottedObjects.get(i);

		if (savedObjects.put(object) != -1) {
			object->updateToDatabaseAllObjects(false);
		}
	}

	for (int j = 0; j < containerObjects.size(); ++j) {
		ManagedReference<SceneObject*> object = containerObjects.get(j);

		object->updateToDatabaseAllObjects(false);
	}

	if (startTask)
		queueUpdateToDatabaseTask();

	//info("saved in " + String::valueOf(start.miliDifference()) + " ms");
}

void SceneObjectImplementation::destroyObjectFromDatabase(bool destroyContainedObjects) {
	//info("deleting from database", true);

	ZoneServer* server = getZoneServer();

	server->destroyObjectFromDatabase(getObjectID());

	_this->setPersistent(0);

	if (!destroyContainedObjects)
		return;

	SortedVector<ManagedReference<SceneObject*> > destroyedObjects;
	destroyedObjects.setNoDuplicateInsertPlan();

	for (int i = 0; i < slottedObjects.size(); ++i) {
		ManagedReference<SceneObject*> object = slottedObjects.get(i);

		if (destroyedObjects.put(object) != -1)
			object->destroyObjectFromDatabase(true);
	}

	for (int j = 0; j < containerObjects.size(); ++j) {
		ManagedReference<SceneObject*> object = containerObjects.get(j);

		if (destroyedObjects.put(object) != -1)
			object->destroyObjectFromDatabase(true);
	}
}

uint64 SceneObjectImplementation::getObjectID() {
	return _this->_getObjectID();
}

void SceneObjectImplementation::sendWithoutParentTo(SceneObject* player) {
	ManagedReference<ZoneClientSession*> client = player->getClient();

	if (client == NULL)
		return;

	create(client);

	/*if (parent != NULL)
		link(client.get(), containmentType);*/

	sendBaselinesTo(player);

	//sendSlottedObjectsTo(player);
	//sendContainerObjectsTo(player);


	SceneObjectImplementation::close(client);
}

void SceneObjectImplementation::sendTo(SceneObject* player, bool doClose) {
	if (isStaticObject())
		return;

	/*if (getObjectID() == 0x1000001008d10) {
		StackTrace::printStackTrace();
	}*/

	ManagedReference<ZoneClientSession*> client = player->getClient();

	if (client == NULL)
		return;

	/*StringBuffer msg;
	if (parent != NULL)
		msg << "with parent " << parent->getLoggingName() << " ";
	msg << "sending 0x" << hex << getClientObjectCRC() << " to " << player->getLoggingName();
	info(msg.toString(), true);*/

	create(client);

	if (parent != NULL)
		link(client.get(), containmentType);

	sendBaselinesTo(player);

	sendContainerObjectsTo(player);

	sendSlottedObjectsTo(player);

	if (doClose) {
		SceneObjectImplementation::close(client);
		//info("sending close", true);
	}
}

void SceneObjectImplementation::sendWithoutContainerObjectsTo(SceneObject* player) {
	if (isStaticObject())
		return;

	ManagedReference<ZoneClientSession*> client = player->getClient();

	if (client == NULL)
		return;

	create(client);

	if (parent != NULL)
		link(client.get(), containmentType);

	sendBaselinesTo(player);

	SceneObjectImplementation::close(client);
}

void SceneObjectImplementation::sendSlottedObjectsTo(SceneObject* player) {
	//sending all slotted objects by default
	SortedVector<SceneObject*> objects(slottedObjects.size(), slottedObjects.size());
	objects.setNoDuplicateInsertPlan();

	for (int i = 0; i < slottedObjects.size(); ++i) {
		SceneObject* object = slottedObjects.get(i);

		if (objects.put(object) != -1) {
			if (object->isInQuadTree()) {
				notifyInsert((QuadTreeEntry*) object->_getImplementation());
			} else {
				object->sendTo(player, true);
			}
		}
	}
}

void SceneObjectImplementation::sendContainerObjectsTo(SceneObject* player) {
	//sending all objects by default
	SortedVector<uint64> objects(containerObjects.size(), containerObjects.size());
	objects.setNoDuplicateInsertPlan();

	for (int j = 0; j < containerObjects.size(); ++j) {
		SceneObject* containerObject = containerObjects.get(j);

		if (objects.put(containerObject->getObjectID()) != -1) {
			if (containerObject->isInQuadTree()) {
				notifyInsert((QuadTreeEntry*) containerObject->_getImplementation());
			} else {
				containerObject->sendTo(player, true);
			}
		}
	}
}

void SceneObjectImplementation::sendDestroyTo(SceneObject* player) {
	if (staticObject)
		return;

	/*StringBuffer msg;
	msg << "sending destroy to " << player->getLoggingName();
	info(msg.toString(), true);*/

	destroy(player->getClient());
}

void SceneObjectImplementation::sendAttributeListTo(PlayerCreature* object) {
	info("sending attribute list");

	AttributeListMessage* alm = new AttributeListMessage(_this);

	fillAttributeList(alm, object);

	object->sendMessage(alm);
}

void SceneObjectImplementation::destroy(ZoneClientSession* client) {
	if (client == NULL)
		return;

	BaseMessage* msg = new SceneObjectDestroyMessage(_this);
	client->sendMessage(msg);
}

void SceneObjectImplementation::broadcastObject(SceneObject* object, bool sendSelf) {
	if (zone == NULL) {
		SceneObject* grandParent = getRootParent();

		if (grandParent != NULL) {
			grandParent->broadcastObject(object, sendSelf);

			return;
		} else {
			return;
		}
	}

	Locker zoneLocker(zone);

	for (int i = 0; i < inRangeObjectCount(); ++i) {
		SceneObjectImplementation* scno = (SceneObjectImplementation*) getInRangeObject(i);

		if (!sendSelf && scno == this)
			continue;

		if (scno->isPlayerCreature()) {
			object->sendTo((SceneObject*) scno->_getStub(), true);
		}
	}

}

void SceneObjectImplementation::broadcastDestroy(SceneObject* object, bool sendSelf) {
	if (zone == NULL) {
		SceneObject* grandParent = getRootParent();

		if (grandParent != NULL) {
			grandParent->broadcastObject(object, sendSelf);

			return;
		} else {
			return;
		}
	}

	Locker zoneLocker(zone);

	for (int i = 0; i < inRangeObjectCount(); ++i) {
		SceneObjectImplementation* scno = (SceneObjectImplementation*) getInRangeObject(i);

		if (!sendSelf && scno == this)
			continue;

		if (scno->isPlayerCreature()) {
			object->sendDestroyTo((SceneObject*) scno->_getStub());
		}
	}

}

void SceneObjectImplementation::broadcastMessage(BasePacket* message, bool sendSelf, bool lockZone) {
	if (zone == NULL) {
		SceneObject* grandParent = getRootParent();

		if (grandParent != NULL) {
			grandParent->broadcastMessage(message, sendSelf, lockZone);

			return;
		} else {
			delete message;

			return;
		}
	}

	//Locker zoneLocker(zone);

	zone->rlock(lockZone);

	try {
		for (int i = 0; i < inRangeObjectCount(); ++i) {
			SceneObjectImplementation* scno = (SceneObjectImplementation*) getInRangeObject(i);

			if (!sendSelf && scno == this)
				continue;

			if (scno->isPlayerCreature()) {
				scno->sendMessage(message->clone());
			}
		}
	} catch (...) {

	}

	zone->runlock(lockZone);

	delete message;
}

void SceneObjectImplementation::broadcastMessages(Vector<BasePacket*>* messages, bool sendSelf) {
	if (zone == NULL) {
		SceneObject* grandParent = getRootParent();

		if (grandParent != NULL) {
			grandParent->broadcastMessages(messages, sendSelf);

			return;
		} else {
			while (!messages->isEmpty()) {
				delete messages->remove(0);
			}

			return;
		}
	}

	zone->rlock();

	try {

		for (int i = 0; i < inRangeObjectCount(); ++i) {
			SceneObjectImplementation* scno = (SceneObjectImplementation*) getInRangeObject(i);

			if (!sendSelf && scno == this)
				continue;

			if (scno->isPlayerCreature()) {
				for (int j = 0; j < messages->size(); ++j) {
					BasePacket* msg = messages->get(j);
					scno->sendMessage(msg->clone());
				}
			}
		}

	} catch (...) {

	}

	zone->runlock();

	while (!messages->isEmpty()) {
		delete messages->remove(0);
	}
}

int SceneObjectImplementation::inRangeObjects(unsigned int gameObjectType, float range) {
	if (zone == NULL)
		return 0;

	int numberOfObjects = 0;

	Locker zoneLocker(zone);

	for (int i = 0; i < inRangeObjectCount(); ++i) {
		SceneObjectImplementation* scno = (SceneObjectImplementation*) getInRangeObject(i);

		if (scno->isInRange(_this, range) && scno->getGameObjectType() == gameObjectType)
			++numberOfObjects;
	}

	return numberOfObjects;
}

void SceneObjectImplementation::sendMessage(BasePacket* msg) {
	delete msg;
}

void SceneObjectImplementation::removeFromBuilding(BuildingObject* building) {
	if (/*!isInQuadTree() || */!parent->isCellObject())
		return;

	if (building != parent->getParent()) {
		error("removing from wrong building object");
		return;
	}

    broadcastMessage(link((uint64)0, (uint32)0xFFFFFFFF), true, false);

    parent->removeObject(_this);

    building->remove(this);

    building->removeNotifiedSentObject(_this);
}

void SceneObjectImplementation::updateVehiclePosition() {
	if (parent == NULL || !parent->isVehicleObject())
		return;

	try {
		Locker locker(parent);

		parent->setDirection(direction.getW(), direction.getX(), direction.getY(), direction.getZ());
		parent->setPosition(positionX, positionZ, positionY);

		parent->incrementMovementCounter();

		parent->updateZone(true);

	} catch (...) {
		error("Unreported exception in SceneObjectImplementation::updateVehiclePosition()");
	}
}

void SceneObjectImplementation::updateZone(bool lightUpdate, bool sendPackets) {
	if (zone == NULL)
		return;

	if (parent != NULL && parent->isVehicleObject())
		updateVehiclePosition();

	Locker zoneLocker(zone);

	if (parent != NULL && parent->isCellObject()) {
		CellObject* cell = (CellObject*)parent.get();

		removeFromBuilding((BuildingObject*)cell->getParent());

		setParent(NULL);

		zone->insert(this);
	} else
		zone->update(this);

	zone->inRange(this, 192);

	if (sendPackets && (parent == NULL || !parent->isVehicleObject())) {
		if (lightUpdate) {
			LightUpdateTransformMessage* message = new LightUpdateTransformMessage(_this);
			broadcastMessage(message, false, false);
		} else {
			UpdateTransformMessage* message = new UpdateTransformMessage(_this);
			broadcastMessage(message, false, false);
		}
	}

	zone->updateActiveAreas(_this);

	zoneLocker.release();

	notifySelfPositionUpdate();
}

void SceneObjectImplementation::notifySelfPositionUpdate() {
	notifyObservers(ObserverEventType::POSITIONCHANGED);
}

void SceneObjectImplementation::notifyCloseContainer(PlayerCreature* player) {
	notifyObservers(ObserverEventType::CLOSECONTAINER, player);
}

void SceneObjectImplementation::updateZoneWithParent(SceneObject* newParent, bool lightUpdate, bool sendPackets) {
	if (zone == NULL)
		return;

	if (parent != NULL && parent->isVehicleObject())
		return;

	bool insert = false;

	/*StringBuffer msg;
	msg << "world posx: " << getWorldPositionX() << " wolrd posy: " << getWorldPositionY() << " posz: " << getWorldPositionZ();
	info(msg.toString(), true);

	StringBuffer msg2;
	msg2 << "cell x: " << positionX << " cell y: " << positionY;
	info(msg2.toString(), true);*/

	Locker zoneLocker(zone);

	if (newParent != parent) {
		if (parent == NULL) {
			zone->remove(this);
			insert = true;
		} else {
			if (parent->isCellObject()) {
				BuildingObject* building = (BuildingObject*) parent->getParent();
				SceneObject* newObj = newParent->getParent();

				BuildingObject* newBuilding = (BuildingObject*) newObj;

				if (building != newBuilding) {
					//System::out << "Does this actually ever happen when someone goes from one building to another?" << endl;

					removeFromBuilding(building);

					insert = true;
				}

				// remove from old cell
				if (parent != NULL)
					parent->removeObject(_this, false);
			} else
				insert = true;
		}

		//System::out << "Cell Transition.  Old: " << hex << parent <<  dec << " New: " << hex << newParent << dec << endl;
		// add to new cell
		//parent = newParent;
		if (!newParent->addObject(_this, -1, false)) {
			error("could not add to parent " + newParent->getLoggingName());
		}

		broadcastMessage(link(parent->getObjectID(), 0xFFFFFFFF), true, false);
	}

	BuildingObject* building = (BuildingObject*) parent->getParent();

	if (insert) {
		info("insertToBuilding from updateZoneWithParent");
		insertToBuilding(building);
	} else {
		building->update(this);
		building->inRange(this, 192);
	}

	if (sendPackets) {
		if (lightUpdate) {
			LightUpdateTransformWithParentMessage* message = new LightUpdateTransformWithParentMessage(_this);
			broadcastMessage(message, false, false);
		} else {
			UpdateTransformWithParentMessage* message = new UpdateTransformWithParentMessage(_this);
			broadcastMessage(message, false, false);
		}
	}

	zone->updateActiveAreas(_this);

	zoneLocker.release();

	notifySelfPositionUpdate();
}

void SceneObjectImplementation::teleport(float newPositionX, float newPositionZ, float newPositionY, uint64 parentID) {

	ZoneServer* zoneServer = getZoneServer();

	if (zone == NULL)
		return;

	Locker locker(zone);

	if (parentID != 0) {
		ManagedReference<SceneObject*> newParent = zoneServer->getObject(parentID);

		if (newParent == NULL)
			return;

		setPosition(newPositionX, newPositionZ, newPositionY);
		updateZoneWithParent(newParent, false);

		DataTransformWithParent* pack = new DataTransformWithParent(_this);
		broadcastMessage(pack, true, false);
	} else {
		setPosition(newPositionX, newPositionZ, newPositionY);
		updateZone(false);

		DataTransform* pack = new DataTransform(_this);
		broadcastMessage(pack, true, false);
	}
}

void SceneObjectImplementation::insertToZone(Zone* newZone) {
	info("inserting to zone");

	if (newZone == NULL)
		return;

	activeAreas.removeAll();

	Locker zoneLocker(newZone);

	if (isInQuadTree() && newZone != zone) {
		error("trying to insert to zone an object that is already in a different quadtree");

		removeFromZone();

		//StackTrace::printStackTrace();
	}

	SceneObjectImplementation::zone = newZone;

	zone->addSceneObject(_this);

	if (parent != NULL && parent->isCellObject())
		parent->addObject(_this, -1, false);

	notifiedSentObjects.removeAll();

	sendToOwner(true);

	if (isInQuadTree()) {
		for (int i = 0; i < inRangeObjectCount(); ++i) {
			SceneObjectImplementation* object = (SceneObjectImplementation*) getInRangeObject(i);

			//if (object->getParent() == NULL)
				notifyInsert(object);

			//teleport(positionX, positionZ, positionY, getParentID());

			if (object != this) {
				object->notifyDissapear(this);
				object->notifyInsert(this);
				//sendDestroyTo((SceneObject*) object->_getStub());
				//sendTo((SceneObject*) object->_getStub(), true);
			}
		}
	} else {
		initializePosition(positionX, positionZ, positionY);

		movementCounter = 0;

		if (parent == NULL || !parent->isCellObject() || parent->getParent() == NULL) {
			zone->insert(this);
			zone->inRange(this, 192);
		} else if (parent->isCellObject()) {
			BuildingObject* building = (BuildingObject*) parent->getParent();
			insertToBuilding(building);

			building->notifyInsertToZone(_this);
		}
	}

	zone->updateActiveAreas(_this);
}

void SceneObjectImplementation::switchZone(int newZoneID, float newPostionX, float newPositionZ, float newPositionY, uint64 parentID) {
	ManagedReference<SceneObject*> thisLocker = _this;

	if (zone == NULL)
		return;

	Zone* newZone = getZoneServer()->getZone(newZoneID);

	if (newZone == NULL)
		return;

	removeFromZone();

	SceneObject* newParent = getZoneServer()->getObject(parentID);

	Locker locker(newZone);

	if (newParent != NULL && newParent->isCellObject())
		newParent->addObject(_this, -1, false);

	initializePosition(newPostionX, newPositionZ, newPositionY);

	insertToZone(newZone);
}

void SceneObjectImplementation::insertToBuilding(BuildingObject* building) {
	if (isInQuadTree() || !parent->isCellObject())
		return;

	try {
		//info("SceneObjectImplementation::insertToBuilding");

		//parent->addObject(_this, 0xFFFFFFFF);

		building->insert(this);
		building->inRange(this, 192);

		broadcastMessage(link(parent->getObjectID(), 0xFFFFFFFF), true, false);

		//info("sent cell link to everyone else");
	} catch (Exception& e) {
		error(e.getMessage());
		e.printStackTrace();
	} catch (...) {
		error("exception SceneObjectImplementation::insertToBuilding(BuildingObject* building)");
	}
}

void SceneObjectImplementation::removeFromZone() {
	ManagedReference<SceneObject*> thisLocker = _this;

	try {
		Locker locker(_this);

		if (zone == NULL)
			return;

		info("removing from zone");

		Locker zoneLocker(zone);

		//ManagedReference<SceneObject*> par = parent.get();

		if (parent != NULL && parent->isCellObject()) {
			BuildingObject* building = (BuildingObject*)parent->getParent();

			//par = parent;
			if (building != NULL)
				removeFromBuilding(building);
			else
				zone->remove(this);
		} else
			zone->remove(this);

		while (inRangeObjectCount() > 0) {
			QuadTreeEntry* obj = getInRangeObject(0);

			if (obj != this)
				obj->removeInRangeObject(this);

			QuadTreeEntry::removeInRangeObject((int)0);
		}

		while (activeAreas.size() > 0) {
			ManagedReference<ActiveArea*> area = activeAreas.get(0);
			area->enqueueExitEvent(_this);

			activeAreas.remove(0);
		}

		//removeInRangeObjects();

		notifiedSentObjects.removeAll();

		Zone* oldZone = zone;
		zone = NULL;

		oldZone->dropSceneObject(_this);
	} catch (...) {

	}


	//activeAreas.removeAll();


	info("removed from zone");
}

void SceneObjectImplementation::notifyAddedToCloseObjects() {
	_this->acquire();
}

void SceneObjectImplementation::notifyRemovedFromCloseObjects() {
	_this->release();
}

int SceneObjectImplementation::canAddObject(SceneObject* object, String& errorDescription) {
	if (containerType == 1 || containerType == 5) {
		int arrangementSize = object->getArrangementDescriptorSize();

		for (int i = 0; i < arrangementSize; ++i) {
			String childArrangement = object->getArrangementDescriptor(i);

			if (slottedObjects.contains(childArrangement))
				return TransferErrorCode::SLOTOCCUPIED;
		}
	} else if (containerType == 2 || containerType == 3) {
		if (containerObjects.size() >= containerVolumeLimit)
			return 1;
	} else {
		error("unkown container type");
		return 1;
	}

	return 0;
}

bool SceneObjectImplementation::addObject(SceneObject* object, int containmentType, bool notifyClient) {
	if (object->getParent() != NULL && object->getParent() != _this) {
		error("trying to add an object with a parent already");
		return false;
	}

	bool update = true;

	//if (containerType == 1 || containerType == 5) {
	if (containmentType == 4) {
		int arrangementSize = object->getArrangementDescriptorSize();

		for (int i = 0; i < arrangementSize; ++i) {
			String childArrangement = object->getArrangementDescriptor(i);

			if (slottedObjects.contains(childArrangement)) {
				return false;
			}
		}

		for (int i = 0; i < arrangementSize; ++i) {
			slottedObjects.put(object->getArrangementDescriptor(i), object);
		}
	} else if (containmentType == -1) { /* else if (containerType == 2 || containerType == 3) {*/
		if (containerObjects.size() >= containerVolumeLimit)
			return false;

		/*if (containerObjects.contains(object->getObjectID()))
			return false*/

		if (containerObjects.put(object->getObjectID(), object) == -1)
			update = false;

	} else {
		error("unkown container type");
		return false;
	}

	object->setParent(_this);
	object->setContainmentType(containmentType);

	if (notifyClient)
		broadcastMessage(object->link(getObjectID(), containmentType), true);

	notifyObjectInserted(object);

	if (update)
		updateToDatabase();
	//object->updateToDatabase();

	return true;
}

bool SceneObjectImplementation::removeObject(SceneObject* object, bool notifyClient) {
	ManagedReference<SceneObject*> objectKeeper = object;

	if (object->getParent() != _this && object->getParent() != NULL) {
		error("trying to remove an object but i am not the parent");
		object->getParent()->info("i am the parent", true);
		return false;
	}

	int containedType = object->getContainmentType();

	//info("trying to remove object with containedType " + String::valueOf(containedType), true);

	if (containedType == 4/*containerType == 1 || containerType == 5*/) {
		int arrangementSize = object->getArrangementDescriptorSize();

		for (int i = 0; i < arrangementSize; ++i) {
			String childArrangement = object->getArrangementDescriptor(i);

			if (slottedObjects.get(childArrangement) != object) {
				//info("sloted objects contains a different object", true);
				return false;
			}
		}

		for (int i = 0; i < arrangementSize; ++i)
			slottedObjects.drop(object->getArrangementDescriptor(i));
	} else if (containedType == -1/*containerType == 2 || containerType == 3*/) {
		if (!containerObjects.contains(object->getObjectID())) {
			//info("containerObjects doesnt contain specified object", true);
			return false;
		}

		containerObjects.drop(object->getObjectID());
	} else {
		error("unkown container type");
		return false;
	}

	object->setParent(NULL);

	if (notifyClient)
		broadcastMessage(object->link((uint64) 0, 0xFFFFFFFF), true);

	notifyObjectRemoved(object);

	updateToDatabase();
	object->updateToDatabase();

	return true;
}

void SceneObjectImplementation::openContainerTo(PlayerCreature* player) {
	ClientOpenContainerMessage* cont = new ClientOpenContainerMessage(_this);
	player->sendMessage(cont);

	sendContainerObjectsTo(player);
}

void SceneObjectImplementation::closeContainerTo(PlayerCreature* player, bool notify) {

	if(notify) {
		ClientOpenContainerMessage* cont = new ClientOpenContainerMessage(_this, true);
		player->sendMessage(cont);
	}
}

void SceneObjectImplementation::getContainmentObjects(VectorMap<String, ManagedReference<SceneObject*> >& objects) {
	objects = slottedObjects;
}

SceneObject* SceneObjectImplementation::getRootParent() {
	if (parent == NULL)
		return NULL;

	SceneObject* grandParent = parent;

	while (grandParent->getParent() != NULL)
		grandParent = grandParent->getParent();

	return grandParent;
}

SceneObject* SceneObjectImplementation::getParentRecursively(uint32 gameObjectType) {
	if (parent == NULL)
		return NULL;

	SceneObject* temp = parent;

	if (temp->getGameObjectType() == gameObjectType)
		return temp;

	while (temp->getParent() != NULL) {
		temp = temp->getParent();

		if (temp->getGameObjectType() == gameObjectType)
			return temp;
	}

	return NULL;
}

bool SceneObjectImplementation::isASubChildOf(SceneObject* object) {
	if (parent == NULL)
		return false;

	if (parent == object)
		return true;

	SceneObject* grandParent = parent;

	while (grandParent->getParent() != NULL) {
		grandParent = grandParent->getParent();

		if (grandParent == object)
			return true;
	}

	return false;
}

bool SceneObjectImplementation::isInRange(SceneObject* object, float range) {
	Vector3 worldPos = object->getWorldPosition();
	worldPos.setZ(0);
	Vector3 thisPos = getWorldPosition();
	thisPos.setZ(0);

	if (thisPos.squaredDistanceTo(worldPos) <= range * range)
		return true;

	return false;
}

float SceneObjectImplementation::getDistanceTo(SceneObject* targetCreature) {
	// TEMP till
	float x = targetCreature->getWorldPositionX();
	float y = targetCreature->getWorldPositionY();

	float deltaX = x - getWorldPositionX();
	float deltaY = y - getWorldPositionY();

	return Math::sqrt(deltaX * deltaX + deltaY * deltaY);
}

float SceneObjectImplementation::getDistanceTo(Coordinate* coordinate) {
	// TEMP till
	float x = coordinate->getPositionX();
	float y = coordinate->getPositionY();

	float deltaX = x - getWorldPositionX();
	float deltaY = y - getWorldPositionY();

	return Math::sqrt(deltaX * deltaX + deltaY * deltaY);
}

Quaternion* SceneObjectImplementation::getDirection() {
	return &direction;
}

void SceneObjectImplementation::setDirection(const Quaternion& dir) {
	direction = dir;
}

void SceneObjectImplementation::rotate(int degrees) {
	Vector3 unity(0, 1, 0);
	direction.rotate(unity, degrees);
}

void SceneObjectImplementation::fillObjectMenuResponse(ObjectMenuResponse* menuResponse, PlayerCreature* player) {
	//All objects in a cell can be picked up, if the player is on the structures permission list.
	//This opens the door to allow admins to be able to drop/pickup items in public structures
	if (parent == NULL || !parent->isCellObject())
		return;

	ManagedReference<SceneObject*> obj = parent->getParent();

	if (!obj->isBuildingObject())
		return;

	ManagedReference<BuildingObject*> buio = (BuildingObject*) obj.get();

	//Is this player on the permission list?
	if (!buio->isOnAdminList(player))
		return;

	if (isPlayerCreature())
		return;

	menuResponse->addRadialMenuItem(10, 3, "@ui_radial:item_pickup"); //Pick up

	menuResponse->addRadialMenuItem(54, 1, "@ui_radial:item_move"); //Move
	menuResponse->addRadialMenuItem(51, 1, "@ui_radial:item_rotate"); //Rotate

	menuResponse->addRadialMenuItemToRadialID(54, 55, 3, "@ui_radial:item_move_forward"); //Move Forward
	menuResponse->addRadialMenuItemToRadialID(54, 56, 3, "@ui_radial:item_move_back"); //Move Back
	menuResponse->addRadialMenuItemToRadialID(54, 57, 3, "@ui_radial:item_move_up"); //Move Up
	menuResponse->addRadialMenuItemToRadialID(54, 58, 3, "@ui_radial:item_move_down"); //Move Down

	menuResponse->addRadialMenuItemToRadialID(51, 52, 3, "@ui_radial:item_rotate_left"); //Rotate Left
	menuResponse->addRadialMenuItemToRadialID(51, 53, 3, "@ui_radial:item_rotate_right"); //Rotate Right
}

int SceneObjectImplementation::handleObjectMenuSelect(PlayerCreature* player, byte selectedID) {
	switch (selectedID) {
	case 10: //Pick Up
	{
		//String actionName = "transferitemmisc";
		//player->executeObjectControllerAction(actionName.hashCode(), getObjectID(), "");
		//transferitem
		break;
	}
	}

	return 0;
}

void SceneObjectImplementation::setObjectName(StringId& stringID) {
	objectName = stringID;
}

Vector3 SceneObjectImplementation::getWorldPosition() {
	if (parent == NULL)
		return getPosition();

	SceneObject* root = getRootParent();

	if (!root->isBuildingObject())
		return getPosition();

	float length = Math::sqrt(positionX * positionX + positionY * positionY + positionZ * positionZ);
	float angle = root->getDirection()->getRadians() + atan2(positionX, positionY);

	float posX = root->getPositionX() + (sin(angle) * length);
	float posY = root->getPositionY() + (cos(angle) * length);
	float posZ = root->getPositionZ() + positionZ;

	Vector3 position(posX, posY, posZ);

	return position;
}

Vector3 SceneObjectImplementation::getCoordinate(float distance, float angleDegrees) {
	float angleRads = angleDegrees * (M_PI / 180.0f);
	float newAngle = angleRads + direction.getRadians();

	float newX = positionX + (cos(newAngle) * distance); // client has x/y inverted
	float newY = positionY + (sin(newAngle) * distance);
	float newZ = zone->getHeight(newX, newY);

	return Vector3(newX, newY, newZ);
}

float SceneObjectImplementation::getWorldPositionX() {
	if (parent == NULL)
		return positionX;

	SceneObject* root = getRootParent();

	float length = Math::sqrt(positionX * positionX + positionY * positionY + positionZ * positionZ);
	float angle = root->getDirection()->getRadians() + atan2(positionX, positionY);

	return root->getPositionX() + (sin(angle) * length);
}

float SceneObjectImplementation::getWorldPositionY() {
	if (parent == NULL)
		return positionY;

	SceneObject* root = getRootParent();

	float length = Math::sqrt(positionX * positionX + positionY * positionY + positionZ * positionZ);
	float angle = root->getDirection()->getRadians() + atan2(positionX, positionY);

	return root->getPositionY() + (cos(angle) * length);
}

float SceneObjectImplementation::getWorldPositionZ() {
	if (parent == NULL)
		return positionZ;

	SceneObject* root = getRootParent();

	return root->getPositionZ() + positionZ;
}

uint32 SceneObjectImplementation::getPlanetCRC() {
	if (zone == NULL)
		return 0;

	return zone->getPlanetName().hashCode();
}

void SceneObjectImplementation::createChildObjects() {
	if (zone == NULL)
		return;

	ZoneServer* zoneServer = zone->getZoneServer();

	for (int i = 0; i < templateObject->getChildObjectsSize(); ++i) {
		ChildObject* child = templateObject->getChildObject(i);

		if (child == NULL)
			continue;

		ManagedReference<SceneObject*> obj = zoneServer->createObject(child->getTemplateFile().hashCode(), 1);

		if (obj == NULL)
			continue;

		obj->initializePosition(child->getPosition().getX(), child->getPosition().getZ(), child->getPosition().getY());
		obj->setDirection(child->getDirection());

		if (isBuildingObject() && child->getCellId() >= 0) {
			BuildingObject* buildingObject = (BuildingObject*) _this;

			int totalCells = buildingObject->getTotalCellNumber();

			if (totalCells > child->getCellId()) {
				ManagedReference<CellObject*> cellObject = buildingObject->getCell(child->getCellId());

				if (cellObject != NULL) {
					cellObject->addObject(obj, child->getContainmentType(), true);
					cellObject->broadcastObject(obj, false);
				}
			}
		}

		obj->insertToZone(zone);
		obj->updateToDatabase();
	}
}
