/*
 * CharacterNameMap.h
 *
 *  Created on: 03/02/2010
 *      Author: victor
 */

#ifndef CHARACTERNAMEMAP_H_
#define CHARACTERNAMEMAP_H_

#include "engine/engine.h"
#include "server/zone/objects/player/PlayerCreature.h"

class CharacterNameMap : public Object {
	HashTable<String, uint64> names;

public:
	CharacterNameMap() : names(3000) {
	}

	void put(PlayerCreature* player) {
		names.put(player->getFirstName().toLowerCase(), player->getObjectID());
	}

	void put(const String& name, uint64 oid) {
		names.put(name, oid);
	}

	uint64& get(const String& name) {
		return names.get(name);
	}

	bool containsKey(const String& name) {
		return names.containsKey(name);
	}

	int size() {
		return names.size();
	}
};

#endif /* CHARACTERNAMEMAP_H_ */
