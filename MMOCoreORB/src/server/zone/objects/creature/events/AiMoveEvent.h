/*
 * AiMoveEvent.h
 *
 *  Created on: 10/07/2010
 *      Author: victor
 */

#ifndef AiMoveEvent_H_
#define AiMoveEvent_H_

#include "server/zone/objects/creature/AiAgent.h"
#include "server/zone/managers/creature/AiMap.h"
#include "../PatrolPoint.h"

namespace server {
namespace zone {
namespace objects {
namespace creature {
namespace events {

class AiMoveEvent : public Task {
	ManagedReference<AiAgent*> creature;

public:
	AiMoveEvent(AiAgent* pl) : Task(1000) {
		creature = pl;
		AiMap::instance()->activeMoveEvents.increment();
	}

	~AiMoveEvent() {
		AiMap::instance()->activeMoveEvents.decrement();
	}

	void run() {
		ManagedReference<AiAgent*> strongRef = creature.get();

		if (strongRef == NULL)
			return;

		Locker locker(strongRef);

		strongRef->doMovement();
	}

	void clearCreatureObject() {
		creature = NULL;
	}

};

}
}
}
}
}

using namespace server::zone::objects::creature::events;



#endif /* AiMoveEvent_H_ */
