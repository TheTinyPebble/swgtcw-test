/*
 * DirectorManager.cpp
 *
 *  Created on: 26/05/2011
 *      Author: victor
 */

#include "DirectorManager.h"
#include "server/zone/objects/creature/LuaCreatureObject.h"
#include "server/zone/objects/scene/LuaSceneObject.h"
#include "server/zone/objects/building/LuaBuildingObject.h"
#include "server/zone/managers/object/ObjectManager.h"
#include "ScreenPlayTask.h"
#include "ScreenPlayObserver.h"
#include "server/zone/managers/creature/CreatureManager.h"
#include "server/ServerCore.h"
#include "server/chat/ChatManager.h"

DirectorManager::DirectorManager() : Logger("DirectorManager") {
	info("loading..", true);

	getLuaInstance();

	reload = true;
}

void DirectorManager::initializeLuaEngine(Lua* luaEngine) {
	info("initializeLuaEngine");

	luaEngine->init();
	luaEngine->setLoggingName("DirectorManagerLuaInstance");
	luaEngine->setGlobalLogging(true);
	luaEngine->setLogging(true);

	lua_register(luaEngine->getLuaState(), "includeFile", includeFile);
	lua_register(luaEngine->getLuaState(), "createEvent", createEvent);
	lua_register(luaEngine->getLuaState(), "createObserver", createObserver);
	lua_register(luaEngine->getLuaState(), "spawnMobile", spawnMobile);
	lua_register(luaEngine->getLuaState(), "spatialChat", spatialChat);
	lua_register(luaEngine->getLuaState(), "readSharedMemory", readSharedMemory);
	lua_register(luaEngine->getLuaState(), "writeSharedMemory", writeSharedMemory);
	lua_register(luaEngine->getLuaState(), "spawnSceneObject", spawnSceneObject);
	lua_register(luaEngine->getLuaState(), "getSceneObject", getSceneObject);

	Luna<LuaBuildingObject>::Register(luaEngine->getLuaState());
	Luna<LuaCreatureObject>::Register(luaEngine->getLuaState());
	Luna<LuaSceneObject>::Register(luaEngine->getLuaState());

	if (!luaEngine->runFile("scripts/screenplays/screenplay.lua"))
		error("could not run scripts/screenplays/screenplay.lua");
}

int DirectorManager::includeFile(lua_State* L) {
	String filename = Lua::getStringParameter(L);

	Lua::runFile("scripts/screenplays/" + filename, L);

	return 0;
}

int DirectorManager::readSharedMemory(lua_State* L) {
	String key = Lua::getStringParameter(L);

	DirectorManager::instance()->rlock();

	uint64 data = DirectorManager::instance()->sharedMemory.get(key);

	DirectorManager::instance()->runlock();

	lua_pushnumber(L, data);

	return 1;
}

int DirectorManager::writeSharedMemory(lua_State* L) {
	String key = lua_tostring(L, -2);
	uint64 data = lua_tonumber(L, -1);

	DirectorManager::instance()->wlock();

	DirectorManager::instance()->sharedMemory.put(key, data);

	DirectorManager::instance()->unlock();

	return 0;
}

int DirectorManager::createEvent(lua_State* L) {
	CreatureObject* creatureObject = (CreatureObject*)lua_touserdata(L, -1);
	String key = lua_tostring(L, -2);
	String play = lua_tostring(L, -3);
	uint32 mili = lua_tonumber(L, -4);

	//System::out << "scheduling task with mili:" << mili << endl;

	Reference<Task*> task = new ScreenPlayTask(creatureObject, key, play);
	task->schedule(mili);

	return 0;
}

int DirectorManager::spatialChat(lua_State* L) {
	ZoneServer* zoneServer = ServerCore::getZoneServer();
	ChatManager* chatManager = zoneServer->getChatManager();

	CreatureObject* creature = (CreatureObject*)lua_touserdata(L, -2);
	String message = lua_tostring(L, -1);

	chatManager->broadcastMessage(creature, message, 0, 0, 0);

	return 0;
}

int DirectorManager::getSceneObject(lua_State* L) {
	uint64 objectID = lua_tonumber(L, -1);
	ZoneServer* zoneServer = ServerCore::getZoneServer();
	SceneObject* object = zoneServer->getObject(objectID);

	lua_pushlightuserdata(L, object);

	return 1;
}

int DirectorManager::spawnMobile(lua_State* L) {
	//int zoneid = lua_tonumber(L, -4);
	uint64 parentID = lua_tonumber(L, -1);
	float y = lua_tonumber(L, -2);
	float z = lua_tonumber(L, -3);
	float x = lua_tonumber(L, -4);
	String mobile = lua_tostring(L, -5);
	String zoneid = lua_tostring(L, -6);

	ZoneServer* zoneServer = ServerCore::getZoneServer();

	Zone* zone = zoneServer->getZone(zoneid);
	CreatureManager* creatureManager = zone->getCreatureManager();

	/*StringBuffer msg;
	msg << "trying to spawn with mobile: " << mobile << " x:" << x;
	DirectorManager::instance()->info(msg.toString(), true);*/

	CreatureObject* creature = creatureManager->spawnCreature(mobile.hashCode(), 0, x, z, y, parentID);

	lua_pushlightuserdata(L, creature);

	return 1;
	//public native CreatureObject spawnCreature(unsigned int templateCRC, float x, float z, float y, unsigned long parentID = 0);
}

int DirectorManager::spawnSceneObject(lua_State* L) {
	float dz = lua_tonumber(L, -1);
	float dy = lua_tonumber(L, -2);
	float dx = lua_tonumber(L, -3);
	float dw = lua_tonumber(L, -4);
	uint64 parentID = lua_tonumber(L, -5);
	float y = lua_tonumber(L, -6);
	float z = lua_tonumber(L, -7);
	float x = lua_tonumber(L, -8);
	String script = lua_tostring(L, -9);
	String zoneid = lua_tostring(L, -10);

	ZoneServer* zoneServer = ServerCore::getZoneServer();
	Zone* zone = zoneServer->getZone(zoneid);

	ManagedReference<SceneObject*> object = zoneServer->createObject(script.hashCode(), 0);

	if (object != NULL) {
		object->initializePosition(x, z, y);
		object->setDirection(dw, dx, dy, dz);

		SceneObject* cellParent = NULL;

		if (parentID != 0) {
			cellParent = zoneServer->getObject(parentID);

			if (cellParent != NULL && !cellParent->isCellObject()) {
				//error("trying to set a parent that is not a cell to creature");
				cellParent = NULL;
			}
		}

		if (cellParent != NULL) {
			cellParent->addObject(object, -1);
		}

		object->insertToZone(zone);
	}

	lua_pushlightuserdata(L, object.get());

	return 1;
}

int DirectorManager::createObserver(lua_State* L) {
	CreatureObject* creatureObject = (CreatureObject*)lua_touserdata(L, -1);
	String key = lua_tostring(L, -2);
	String play = lua_tostring(L, -3);
	uint32 eventType = lua_tonumber(L, -4);

	ManagedReference<ScreenPlayObserver*> observer = dynamic_cast<ScreenPlayObserver*>(ObjectManager::instance()->createObject("ScreenPlayObserver", 0, ""));
	observer->setScreenPlay(play);
	observer->setScreenKey(key);

	creatureObject->registerObserver(eventType, observer);

	return 0;
}

Lua* DirectorManager::getLuaInstance() {
	Lua* lua = localLua.get();

	if (lua == NULL) {
		lua = new Lua();
		initializeLuaEngine(lua);

		localLua.set(lua);
	}

	//lua->runFile("scripts/screenplays/screenplay.lua");

	return lua;
}

void DirectorManager::startScreenPlay(CreatureObject* creatureObject, const String& screenPlayName) {
	Lua* lua = getLuaInstance();

	LuaFunction startScreenPlay(lua->getLuaState(), screenPlayName, "start", 0);
	startScreenPlay << creatureObject;

	lua->callFunction(&startScreenPlay);
}

void DirectorManager::activateEvent(ScreenPlayTask* task) {
	CreatureObject* creo = task->getCreatureObject();
	String play = task->getScreenPlay();
	String key = task->getTaskKey();

	Lua* lua = getLuaInstance();

	LuaFunction startScreenPlay(lua->getLuaState(), play, key, 0);
	startScreenPlay << creo;

	lua->callFunction(&startScreenPlay);
}
