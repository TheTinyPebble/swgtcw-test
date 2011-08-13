/*
 * SpawnAreaMap.cpp
 *
 *  Created on: 12/08/2011
 *      Author: TheAnswer
 */

#include "SpawnAreaMap.h"
#include "server/zone/Zone.h"
#include "server/zone/managers/creature/CreatureManager.h"

void SpawnAreaMap::loadMap(Zone* z) {
	zone = z;
	String planetName = zone->getZoneName();

	setLoggingName("SpawnAreaMap " + planetName);

	lua->init();

	try {
		lua->runFile("scripts/managers/spawn_manager/" + planetName + ".lua");

		LuaObject obj = lua->getGlobalObject(planetName + "_regions");

		if (obj.isValidTable()) {
			lua_State* s = obj.getLuaState();

			for (int i = 1; i <= obj.getTableSize(); ++i) {
				lua_rawgeti(s, -1, i);
				LuaObject areaObj(s);

				if (areaObj.isValidTable()) {
					readAreaObject(areaObj);
				}

				areaObj.pop();
			}
		}

		obj.pop();

		for (int i = 0; i < size(); ++i) {
			SpawnArea* area = get(i);
			if (area->isDynamicArea()) {
				DynamicSpawnArea* dynamicArea = (DynamicSpawnArea*)area;

				Vector3 d(dynamicArea->getPositionX(), dynamicArea->getPositionY(), 0);

				for (int j = 0; j < noSpawnAreas.size(); ++j) {
					SpawnArea* notHere = noSpawnAreas.get(j);
					Vector3 offset(notHere->getPosition());

					if (d.distanceTo(offset) < dynamicArea->getRadius() + notHere->getRadius())
						dynamicArea->addNoSpawnArea(notHere);
				}
			}
		}

		loadStaticSpawns();
	} catch (Exception& e) {
		error(e.getMessage());
	}

	lua->deinit();
}

void SpawnAreaMap::loadStaticSpawns() {
	String planetName = zone->getZoneName();

	LuaObject obj = lua->getGlobalObject(planetName + "_static_spawns");

	if (!obj.isValidTable()) {
		obj.pop();
		return;
	}

	for (int i = 1; i <= obj.getTableSize(); ++i) {
		lua_rawgeti(obj.getLuaState(), -1, i);
		LuaObject spawn(obj.getLuaState());

		if (spawn.isValidTable()) {
			CreatureManager* creatureManager = zone->getCreatureManager();

			String name = obj.getStringAt(1);
			float x = obj.getFloatAt(2);
			float y = obj.getFloatAt(3);
			float heading = obj.getFloatAt(4);
			lua_rawgeti(obj.getLuaState(), -1, 5);
			uint64 parentID = (uint64)lua_tonumber(obj.getLuaState(), -1);
			lua_pop(obj.getLuaState(), 1);


			ManagedReference<CreatureObject*> creatureObject = creatureManager->spawnCreature(name.hashCode(), 0, x, zone->getHeight(x, y), y, parentID);

			if (creatureObject != NULL) {
				creatureObject->setDirection(Math::deg2rad(heading));
			} else {
				StringBuffer msg;
				msg << "could not spawn mobile: " + name;
				error(msg.toString());
			}
		}

		spawn.pop();
	}

	obj.pop();


	//--{"mobile", x, z, y, degrees heading, parentID}



	//spawnCreature(uint32 templateCRC, uint32 objectCRC, float x, float z, float y, uint64 parentID)
}

void SpawnAreaMap::readAreaObject(LuaObject& areaObj) {
	String name = areaObj.getStringAt(1);
	float x = areaObj.getFloatAt(2);
	float y = areaObj.getFloatAt(3);
	float radius = areaObj.getFloatAt(4);
	int tier = areaObj.getIntAt(5);
	int constant = areaObj.getIntAt(6);

	uint32 crc;
	if (tier < 2)
		crc = String("object/static_spawn_area.iff").hashCode();
	else
		crc = String("object/dynamic_spawn_area.iff").hashCode();

	ManagedReference<SpawnArea*> area = dynamic_cast<SpawnArea*>(ObjectManager::instance()->createObject(crc, 2, "spawnareas"));
	if (area == NULL)
		return;

	StringId nameID(zone->getZoneName() + "_region_names", name);

	area->setObjectName(nameID);

	area->setPosition(x, 0, y);

	area->setRadius(radius);

	area->setTier(tier);

	area->setSpawnConstant(constant);

	for (int j = 7; j <= areaObj.getTableSize(); ++j)
		area->addTemplate(areaObj.getStringAt(j).hashCode());

	area->insertToZone(zone);

	area->updateToDatabase();

	put(nameID.getStringID().hashCode(), area);

	if (area->isStaticArea()) {
		noSpawnAreas.add(area);
		if (tier == 1) {
			StaticSpawnArea* staticArea = (StaticSpawnArea*)area.get();
			staticArea->spawnCreatures();
		}
	}
}
