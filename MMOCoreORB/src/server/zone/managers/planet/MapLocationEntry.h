/*
 * MapLocationEntry.h
 *
 *  Created on: 18/06/2010
 *      Author: victor
 */

#ifndef MAPLOCATIONENTRY_H_
#define MAPLOCATIONENTRY_H_

#include "engine/engine.h"

class PlanetMapCategory;

namespace server {
namespace zone {
namespace objects {
namespace scene {

class SceneObject;

} // namespace scene
} // namespace objects
} // namespace zone
} // namespace server

using namespace server::zone::objects::scene;

class MapLocationEntry : public Object {
	ManagedReference<SceneObject*> object;
	bool active;

public:
	MapLocationEntry() {
		active = false;
	}

	MapLocationEntry(SceneObject* obj) {
		object = obj;
		active = false;
	}

	MapLocationEntry(const MapLocationEntry& entry) : Object() {
		object = entry.object;
		active = entry.active;
	}

	int compareTo(const MapLocationEntry& entry) const;

	bool insertToMessage(BaseMessage* message) const;

	MapLocationEntry& operator=(const MapLocationEntry& entry);

	uint64 getObjectID() const;

	inline void setObject(SceneObject* obj) {
		object = obj;
	}

	inline SceneObject* getObject() {
		return object;
	}

	inline bool isActive() {
		return active;
	}

	/**
	 * Sets whether or not this map location entry is currently active.
	 * @param act This parameter should be true if you wish this location's status be marked as active.
	 */
	inline void setActive(bool act) {
		active = act;
	}
};


#endif /* MAPLOCATIONENTRY_H_ */
