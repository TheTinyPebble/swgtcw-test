/*
 * LuaSceneObject.cpp
 *
 *  Created on: 27/05/2011
 *      Author: victor
 */

#include "LuaSceneObject.h"
#include "SceneObject.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/cell/CellObject.h"
#include "server/zone/packets/cell/UpdateCellPermissionsMessage.h"

const char LuaSceneObject::className[] = "LuaSceneObject";

Luna<LuaSceneObject>::RegType LuaSceneObject::Register[] = {
		{ "_setObject", &LuaSceneObject::_setObject },
		{ "getParent", &LuaSceneObject::getParent },
		{ "getObjectID", &LuaSceneObject::getObjectID },
		{ "getPositionX", &LuaSceneObject::getPositionX },
		{ "getPositionY", &LuaSceneObject::getPositionY },
		{ "getPositionZ", &LuaSceneObject::getPositionZ },
		{ "getParentID", &LuaSceneObject::getParentID },
		{ "isInRangeWithObject", &LuaSceneObject::isInRangeWithObject },
		{ "getDistanceTo", &LuaSceneObject::getDistanceTo },
		{ "updateDirection", &LuaSceneObject::updateDirection },
		{ "getServerObjectCRC", &LuaSceneObject::getServerObjectCRC },
		{ "showFlyText", &LuaSceneObject::showFlyText },
		{ "getContainerObject", &LuaSceneObject::getContainerObject },
		{ "getContainerObjectsSize", &LuaSceneObject::getContainerObjectsSize },
		{ "getSlottedObject", &LuaSceneObject::getSlottedObject },
		{ "transferObject", &LuaSceneObject::transferObject },
//		{ "removeObject", &LuaSceneObject::removeObject },
		{ "getGameObjectType", &LuaSceneObject::getGameObjectType },
		{ "faceObject", &LuaSceneObject::faceObject },
		{ "destroyObjectFromWorld", &LuaSceneObject::destroyObjectFromWorld },
		{ "isCreatureObject", &LuaSceneObject::isCreatureObject },
		{ "updateCellPermission", &LuaSceneObject::updateCellPermission },
		{ "sendTo", &LuaSceneObject::sendTo },
		{ "getCustomObjectName", &LuaSceneObject::getCustomObjectName },
		{ "getContainerObjectById", &LuaSceneObject::getContainerObjectById },
		{ "setDirectionalHeading", &LuaSceneObject::setDirectionalHeading },
		{ 0, 0 }
};

LuaSceneObject::LuaSceneObject(lua_State *L) {
	realObject = (SceneObject*)lua_touserdata(L, 1);
}

LuaSceneObject::~LuaSceneObject(){
}

int LuaSceneObject::_setObject(lua_State* L) {
	realObject = (SceneObject*)lua_touserdata(L, -1);

	return 0;
}

int LuaSceneObject::getPositionX(lua_State* L) {
	lua_pushnumber(L, realObject->getPositionX());

	return 1;
}

int LuaSceneObject::getPositionZ(lua_State* L) {
	lua_pushnumber(L, realObject->getPositionZ());

	return 1;
}

int LuaSceneObject::getPositionY(lua_State* L) {
	lua_pushnumber(L, realObject->getPositionY());

	return 1;
}

int LuaSceneObject::getObjectID(lua_State* L) {
	lua_pushinteger(L, realObject->getObjectID());

	return 1;
}

int LuaSceneObject::getParentID(lua_State* L) {
	lua_pushinteger(L, realObject->getParentID());

	return 1;
}

int LuaSceneObject::isInRange(lua_State* L) {
//public boolean isInRange(float x, float y, float range) {
	float range = lua_tonumber(L, -1);
	float y = lua_tonumber(L, -2);
	float x = lua_tonumber(L, -3);

	bool res = (static_cast<QuadTreeEntry*>(realObject))->isInRange(x, y, range);

	lua_pushnumber(L, res);

	return 1;
}

int LuaSceneObject::getGameObjectType(lua_State* L) {
	uint32 type = realObject->getGameObjectType();

	lua_pushnumber(L, type);

	return 1;
}

int LuaSceneObject::getDistanceTo(lua_State* L) {
	SceneObject* obj = (SceneObject*)lua_touserdata(L, -1);

	float res = realObject->getDistanceTo(obj);

	lua_pushnumber(L, res);

	return 1;
}

int LuaSceneObject::getServerObjectCRC(lua_State* L) {
	uint32 crc = realObject->getServerObjectCRC();

	lua_pushnumber(L, crc);

	return 1;
}

int LuaSceneObject::faceObject(lua_State* L) {
	SceneObject* obj = (SceneObject*)lua_touserdata(L, -1);

	realObject->faceObject(obj);

	return 0;
}

int LuaSceneObject::isInRangeWithObject(lua_State* L) {
	float range = lua_tonumber(L, -1);
	SceneObject* obj = (SceneObject*)lua_touserdata(L, -2);

	bool res = realObject->isInRange(obj, range);

	lua_pushnumber(L, res);

	return 1;
}

int LuaSceneObject::getParent(lua_State* L) {
	SceneObject* obj = realObject->getParent();

	lua_pushlightuserdata(L, obj);

	return 1;
}

int LuaSceneObject::getContainerObject(lua_State* L) {
	int idx = lua_tonumber(L, -1);

	SceneObject* obj = realObject->getContainerObject(idx);

	lua_pushlightuserdata(L, obj);

	return 1;
}

int LuaSceneObject::getContainerObjectById(lua_State* L) {
	uint64 objectID = lua_tointeger(L, -1);

	SceneObject* obj = realObject->getContainerObject(objectID);

	if (obj != NULL) {
		lua_pushlightuserdata(L, obj);
	} else {
		lua_pushnil(L);
	}

	return 1;
}

int LuaSceneObject::getSlottedObject(lua_State* L) {
	String slot = lua_tostring(L, -1);

	SceneObject* obj = realObject->getSlottedObject(slot);

	lua_pushlightuserdata(L, obj);

	return 1;
}

int LuaSceneObject::transferObject(lua_State* L) {
	//transferObject(SceneObject object, int containmentType, boolean notifyClient = false);

	bool notifyClient = lua_tonumber(L, -1);
	int containmentType = lua_tonumber(L, -2);
	SceneObject* obj = (SceneObject*) lua_touserdata(L, -3);

	realObject->transferObject(obj, containmentType, notifyClient);

	return 0;
}

/*int LuaSceneObject::removeObject(lua_State* L) {

	//removeObject(SceneObject object, boolean notifyClient = false);

	bool notifyClient = lua_tonumber(L, -1);
	SceneObject* obj = (SceneObject*) lua_touserdata(L, -2);

	realObject->removeObject(obj, notifyClient);

	return 0;
}*/

int LuaSceneObject::getContainerObjectsSize(lua_State* L) {
	int num = realObject->getContainerObjectsSize();

	lua_pushnumber(L, num);

	return 1;
}

int LuaSceneObject::showFlyText(lua_State* L) {
	//final string file, final string uax, byte red, byte green, byte blue

	byte blue = lua_tonumber(L, -1);
	byte green = lua_tonumber(L, -2);
	byte red = lua_tonumber(L, -3);

	String aux = lua_tostring(L, -4);
	String file = lua_tostring(L, -5);

	realObject->showFlyText(file, aux, red, green, blue);

	return 0;
}

int LuaSceneObject::updateDirection(lua_State* L) {
	//void updateDirection(float fw, float fx, float fy, float fz);

	float fz = lua_tonumber(L, -1);
	float fy = lua_tonumber(L, -2);
	float fx = lua_tonumber(L, -3);
	float fw = lua_tonumber(L, -4);

	realObject->updateDirection(fw, fx, fy, fz);

	return 0;
}

int LuaSceneObject::destroyObjectFromWorld(lua_State* L) {
	realObject->destroyObjectFromWorld(true);

	return 0;
}

int LuaSceneObject::isCreatureObject(lua_State* L) {
	bool val = realObject->isCreatureObject();

	lua_pushboolean(L, val);

	return 1;
}

int LuaSceneObject::updateCellPermission(lua_State* L) {
	//realObject->info("getting values",true);
	int allowEntry = lua_tonumber(L, -2);
	CreatureObject* obj = (CreatureObject*)lua_touserdata(L, -1);
	//realObject->info("allowentry:" + String::valueOf(allowEntry), true);
	if (obj == NULL)
		return 0;

	//realObject->info("values not NULL", true);

	if (!realObject->isCellObject()) {
		realObject->info("Unknown entity error: Cell", true);
		return 0;
	}

	if (!obj->isCreatureObject()) {
		//realObject->info("Unknown entity error: Creature", true);
		obj->info("Unknown entity error: Creature", true);
		return 0;
	}

	//realObject->info("checks are fine", true);

	BaseMessage* perm = new UpdateCellPermissionsMessage(realObject->getObjectID(), allowEntry);
	obj->sendMessage(perm);

	return 0;
}

int LuaSceneObject::wlock(lua_State* L) {
	return 0;
}

int LuaSceneObject::unlock(lua_State* L) {
	return 0;
}

int LuaSceneObject::sendTo(lua_State* L) {
	SceneObject* obj = (SceneObject*) lua_touserdata(L, -1);

	realObject->sendTo(obj, true);

	return 0;
}

int LuaSceneObject::getCustomObjectName(lua_State* L) {
	String objname = realObject->getCustomObjectName().toString();

	lua_pushstring(L, objname);

	return 1;
}

int LuaSceneObject::setDirectionalHeading(lua_State* L) {
	int heading = lua_tointeger(L, -1);
	SceneObject* obj = (SceneObject*) lua_touserdata(L, -2);

	realObject->setDirection(heading);

	return 0;
}
