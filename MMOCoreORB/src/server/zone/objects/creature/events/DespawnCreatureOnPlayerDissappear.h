/*
 * DespawnCreatureOnPlayerDissappear.h
 *
 *  Created on: 13/07/2010
 *      Author: victor
 */

#ifndef DESPAWNCREATUREONPLAYERDISSAPPEAR_H_
#define DESPAWNCREATUREONPLAYERDISSAPPEAR_H_

#include "../AiAgent.h"

namespace server {
 namespace zone {
  namespace objects {
   namespace creature {
    namespace events {


class DespawnCreatureOnPlayerDissappear : public Task {
	ManagedWeakReference<AiAgent*> creature;

public:
	DespawnCreatureOnPlayerDissappear(AiAgent* creo) {
		creature = creo;
	}

	void run() {
		ManagedReference<AiAgent*> strongRef = creature.get();

		if (strongRef == NULL)
			return;

		Locker locker(strongRef);

		creature->clearDespawnEvent();

		if (!creature->getDespawnOnNoPlayerInRange())
			return;

		if (strongRef->inRangeObjects(SceneObject::PLAYERCREATURE, 128) == 0 && strongRef->getNumberOfPlayersInRange() <= 0) {
			creature->removeFromZone();
		}
	}
};


    }
   }
  }
 }
}

using namespace server::zone::objects::creature::events;

#endif /* DESPAWNCREATUREONPLAYERDISSAPPEAR_H_ */
