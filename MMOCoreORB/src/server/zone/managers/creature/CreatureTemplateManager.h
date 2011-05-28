/*
 * CreatureTemplateMap.h
 *
 *  Created on: Oct 8, 2010
 *      Author: dannuic
 */

#ifndef CREATURETEMPLATEMANAGER_H_
#define CREATURETEMPLATEMANAGER_H_

#include "engine/engine.h"
#include "CreatureTemplate.h"
#include "ConversationTemplate.h"
#include "SpawnGroup.h"
#include "StaticSpawnGroup.h"
#include "DynamicSpawnGroup.h"

namespace server {
namespace zone {
namespace managers {
namespace creature {

class CreatureTemplateManager : public Singleton<CreatureTemplateManager>, public Object, public Logger {
protected:
	VectorMap<uint32, Vector<String> > weaponMap;
	VectorMap<uint32, DynamicSpawnGroup*> dynamicGroupMap;
	VectorMap<uint32, StaticSpawnGroup*> staticGroupMap;
	Lua* lua;
	HashTable<uint32, Reference<CreatureTemplate*> > hashTable;

	HashTable<uint32, Reference<ConversationTemplate*> > conversations;

public:
	CreatureTemplateManager();
	virtual ~CreatureTemplateManager();

	void loadTemplates();
	static int includeFile(lua_State* L);
	static int addTemplate(lua_State* L);
	static int addWeapon(lua_State* L);
	static int addDynamicGroup(lua_State* L);
	static int addStaticGroup(lua_State* L);
	static int addConversationTemplate(lua_State* L);

	int size() {
		return hashTable.size();
	}

	HashTableIterator<uint32, Reference<CreatureTemplate*> > iterator() {
		return hashTable.iterator();
	}

	CreatureTemplate* getTemplate(uint32 crc) {
		return hashTable.get(crc);
	}

	CreatureTemplate* getTemplate(const String& ascii) {
		return hashTable.get(ascii.hashCode());
	}

	ConversationTemplate* getConversationTemplate(const String& name) {
		return conversations.get(name.hashCode()).get();
	}

	ConversationTemplate* getConversationTemplate(uint32 crc) {
		return conversations.get(crc).get();
	}

	Vector<String> getWeapons(uint32 crc) {
		return weaponMap.get(crc);
	}

	Vector<String> getWeapons(String ascii) {
		return weaponMap.get(ascii.hashCode());
	}

	DynamicSpawnGroup* getDynamicGroup(uint32 crc) {
		return dynamicGroupMap.get(crc);
	}

	DynamicSpawnGroup* getDynamicGroup(String ascii) {
		return dynamicGroupMap.get(ascii.hashCode());
	}

	StaticSpawnGroup* getStaticGroup(uint32 crc) {
		return staticGroupMap.get(crc);
	}

	StaticSpawnGroup* getStaticGroup(String ascii) {
		return staticGroupMap.get(ascii.hashCode());
	}

};

}
}
}
}

using namespace server::zone::managers::creature;

#endif /* CREATURETEMPLATEMANAGER_H_ */
