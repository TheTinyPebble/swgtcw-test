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

#include "Zone.h"

#include "ZoneProcessServer.h"
#include "objects/scene/SceneObject.h"
#include "server/zone/managers/structure/StructureManager.h"
#include "server/zone/managers/city/CityManager.h"
#include "server/zone/managers/planet/PlanetManager.h"
#include "server/zone/managers/creature/CreatureManager.h"
#include "server/zone/managers/objectcontroller/ObjectController.h"
#include "server/zone/templates/SharedObjectTemplate.h"
#include "server/zone/packets/player/GetMapLocationsResponseMessage.h"

#include "server/zone/objects/building/cloning/CloningBuildingObject.h"
#include "server/zone/objects/cell/CellObject.h"
#include "server/zone/templates/SharedObjectTemplate.h"
#include "server/zone/templates/appearance/PortalLayout.h"
#include "server/zone/templates/appearance/FloorMesh.h"
#include "server/zone/templates/appearance/PathGraph.h"


ZoneImplementation::ZoneImplementation(ZoneProcessServer* serv, const String& name) : ManagedObjectImplementation() {
	processor = serv;
	server = processor->getZoneServer();

	zoneName = name;
	zoneCRC = name.hashCode();

	heightMap = new HeightMap();
	regionTree = new QuadTree(-8192, -8192, 8192, 8192);
	quadTree = new QuadTree(-8192, -8192, 8192, 8192);

	objectMap = new ObjectMap();

	mapLocations = new MapLocationTable();

	managersStarted = false;

	//galacticTime = new Time();

	planetManager = NULL;
	cityManager = NULL;
}

void ZoneImplementation::initializePrivateData() {
	planetManager = new PlanetManager(_this, processor);

	creatureManager = new CreatureManager(_this);
	creatureManager->deploy("CreatureManager " + zoneName);
	creatureManager->setZoneProcessor(processor);

	cityManager = new CityManager(_this);
}

void ZoneImplementation::finalize() {
	//System::out << "deleting height map\n";
	delete heightMap;
	heightMap = NULL;

	delete regionTree;
	regionTree = NULL;
}

void ZoneImplementation::initializeTransientMembers() {
	ManagedObjectImplementation::initializeTransientMembers();

	heightMap = new HeightMap();

	mapLocations = new MapLocationTable();

	//heightMap->load("planets/" + planetName + "/" + planetName + ".hmap");
}

void ZoneImplementation::startManagers() {
	//if (zoneID > 45) //TODO: Change back to 9 sometimes. We use Zone 10 (Space Corellia) as a "prison" for the CSRs sending bad players there
	//	return;

	//heightMap->load("planets/" + planetName + "/" + planetName + ".hmap");

	planetManager->initialize();

	//FIXME
#ifndef WITH_STM
	creatureManager->initialize();
#endif
	cityManager->loadLuaConfig();

	ObjectDatabaseManager::instance()->commitLocalTransaction();

	managersStarted = true;
}

void ZoneImplementation::stopManagers() {
	//if (zoneID > 45) //TODO: Change back to 9 sometimes. We use Zone 10 (Space Corellia) as a "prison" for the CSRs sending bad players there
	//	return;

	/*if (creatureManager != NULL) {
		creatureManager->stop();

		creatureManager->finalize();
		creatureManager = NULL;
	}

	if (planetManager != NULL) {
		planetManager->stop();

		planetManager->finalize();
		planetManager = NULL;
	}*/
}

/*void ZoneImplementation::registerObject(SceneObject* obj) {
	server->addObject(obj);
}

SceneObject* ZoneImplementation::lookupObject(uint64 oid) {
	return server->getObject(oid);
}

SceneObject* ZoneImplementation::deleteObject(uint64 oid) {
	return server->removeObject(oid);
}

SceneObject* ZoneImplementation::deleteObject(SceneObject* obj) {
	return server->removeObject(obj->getObjectID());
}

SceneObject* ZoneImplementation::deleteCachedObject(SceneObject* obj) {
	return server->removeCachedObject(obj->getObjectID());
}*/

float ZoneImplementation::getHeight(float x, float y) {
	if (heightMap->isLoaded())
		return heightMap->getHeight(x, y);
	else
		return planetManager->getTerrainManager()->getHeight(x, y);
}

void ZoneImplementation::insert(QuadTreeEntry* entry) {
	Locker locker(_this);

	quadTree->insert(entry);
}

void ZoneImplementation::remove(QuadTreeEntry* entry) {
	Locker locker(_this);

	if (entry->isInQuadTree())
		quadTree->remove(entry);
}

void ZoneImplementation::update(QuadTreeEntry* entry) {
	Locker locker(_this);

	quadTree->update(entry);
}

void ZoneImplementation::inRange(QuadTreeEntry* entry, float range) {
	Locker locker(_this);

	quadTree->inRange(entry, range);
}

int ZoneImplementation::getInRangeObjects(float x, float y, float range, SortedVector<ManagedReference<SceneObject*> >* objects) {
	Locker locker(_this);

	SortedVector<QuadTreeEntry*> entryObjects;

	quadTree->inRange(x, y, range, entryObjects);

	for (int i = 0; i < entryObjects.size(); ++i) {
		SceneObject* obj = dynamic_cast<SceneObject*>(entryObjects.get(i));
		objects->put(obj);
	}

	return objects->size();
}

int ZoneImplementation::getInRangeActiveAreas(float x, float y, float range, SortedVector<ManagedReference<ActiveArea*> >* objects) {
	Locker locker(_this);

	SortedVector<QuadTreeEntry*> entryObjects;

	regionTree->inRange(x, y, range, entryObjects);

	for (int i = 0; i < entryObjects.size(); ++i) {
		ActiveArea* obj = dynamic_cast<ActiveArea*>(entryObjects.get(i));
		objects->put(obj);
	}

	return objects->size();
}

void ZoneImplementation::updateActiveAreas(SceneObject* object) {
	SortedVector<ManagedReference<ActiveArea* > > areas = *dynamic_cast<SortedVector<ManagedReference<ActiveArea* > >* >(object->getActiveAreas());

	Vector3 worldPos = object->getWorldPosition();

	SortedVector<QuadTreeEntry*> entryObjects;

	regionTree->inRange(worldPos.getX(), worldPos.getY(), 512, entryObjects);

	// update old ones
	for (int i = 0; i < areas.size(); ++i) {
		ManagedReference<ActiveArea*> area = areas.get(i);

		if (!area->containsPoint(worldPos.getX(), worldPos.getY())) {
			object->dropActiveArea(area);
			area->enqueueExitEvent(object);
		}
	}

	// we update the ones in quadtree.
	for (int i = 0; i < entryObjects.size(); ++i) {
		//update in new ones
		ActiveArea* activeArea = dynamic_cast<ActiveArea*>(entryObjects.get(i));

		if (!object->hasActiveArea(activeArea) && activeArea->containsPoint(worldPos.getX(), worldPos.getY())) {
			object->addActiveArea(activeArea);
			activeArea->enqueueEnterEvent(object);
		}
	}

}

void ZoneImplementation::addSceneObject(SceneObject* object) {
	objectMap->put(object->getObjectID(), object);
	registerObjectWithPlanetaryMap(object);
}

//TODO: Do we need to send out some type of update when this happens?
void ZoneImplementation::registerObjectWithPlanetaryMap(SceneObject* object) {
#ifndef WITH_STM
	Locker locker(mapLocations);
#endif
	mapLocations->addObject(object);
}

void ZoneImplementation::unregisterObjectWithPlanetaryMap(SceneObject* object) {
#ifndef WITH_STM
	Locker locker(mapLocations);
#endif
	mapLocations->dropObject(object);
}

void ZoneImplementation::dropSceneObject(SceneObject* object)  {
	objectMap->remove(object->getObjectID());
	unregisterObjectWithPlanetaryMap(object);
}

void ZoneImplementation::sendMapLocationsTo(SceneObject* player) {
	GetMapLocationsResponseMessage* gmlr = new GetMapLocationsResponseMessage(zoneName, mapLocations);
	player->sendMessage(gmlr);
}

CloningBuildingObject* ZoneImplementation::getNearestCloningBuilding(CreatureObject* creature) {
	ManagedReference<CloningBuildingObject*> cloning = NULL;

#ifndef WITH_STM
	mapLocations->rlock();
#endif
	try {
		//cloning type 5

		int index = mapLocations->findLocation("cloningfacility");

		float distance = 16000.f;

		if (index != -1) {
			SortedVector<MapLocationEntry>& sortedVector = mapLocations->get(index);

			for (int i = 0; i < sortedVector.size(); ++i) {
				SceneObject* object = sortedVector.get(i).getObject();

				if (object->isCloningBuildingObject()) {
					float objDistance = object->getDistanceTo(creature);

					if (objDistance < distance) {
						cloning = (CloningBuildingObject*) object;
						distance = objDistance;
					}
				}
			}

		}
	} catch (...) {
#ifndef WITH_STM
		mapLocations->runlock();
#endif

		throw;
	}

#ifndef WITH_STM
	mapLocations->runlock();
#endif

	return cloning.get();
}

SceneObject* ZoneImplementation::getNearestPlanetaryObject(SceneObject* object, const String& mapObjectLocationType) {
	ManagedReference<SceneObject*> planetaryObject = NULL;

#ifndef WITH_STM
	mapLocations->rlock();
#endif

	try {
		//cloning type 5

		int index = mapLocations->findLocation(mapObjectLocationType);

		float distance = 16000.f;

		if (index != -1) {
			SortedVector<MapLocationEntry>& sortedVector = mapLocations->get(index);

			for (int i = 0; i < sortedVector.size(); ++i) {
				SceneObject* vectorObject = sortedVector.get(i).getObject();

				float objDistance = vectorObject->getDistanceTo(object);

				if (objDistance < distance) {
					planetaryObject = vectorObject;
					distance = objDistance;
				}
			}

		}
	} catch (...) {
#ifndef WITH_STM
		mapLocations->runlock();
#endif

		throw;
	}

#ifndef WITH_STM
	mapLocations->runlock();
#endif
	return planetaryObject.get();
}

SortedVector<ManagedReference<SceneObject*> > ZoneImplementation::getPlanetaryObjectList(const String& mapObjectLocationType) {
	SortedVector<ManagedReference<SceneObject*> > retVector;
	retVector.setNoDuplicateInsertPlan();

#ifndef WITH_STM
	mapLocations->rlock();
#endif

	try {
		SortedVector<MapLocationEntry>& entryVector = mapLocations->getLocation(mapObjectLocationType);

		for (int i = 0; i < entryVector.size(); ++i) {
			MapLocationEntry entry = entryVector.get(i);
			retVector.put(entry.getObject());
		}
	} catch (...) {

	}

#ifndef WITH_STM
	mapLocations->runlock();
#endif

	return retVector;
}

float ZoneImplementation::getMinX() {
	return planetManager->getTerrainManager()->getMin();
}

float ZoneImplementation::getMaxX() {
	return planetManager->getTerrainManager()->getMax();
}

float ZoneImplementation::getMinY() {
	return planetManager->getTerrainManager()->getMin();
}

float ZoneImplementation::getMaxY() {
	return planetManager->getTerrainManager()->getMax();
}
