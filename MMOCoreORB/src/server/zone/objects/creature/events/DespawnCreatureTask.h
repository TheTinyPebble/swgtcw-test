/*
 * DespawnCreatureTask.h
 *
 *  Created on: 12/07/2010
 *      Author: victor
 */

#ifndef DESPAWNCREATURETASK_H_
#define DESPAWNCREATURETASK_H_

#include "../AiAgent.h"

class DespawnCreatureTask : public Task {
	ManagedReference<AiAgent*> creature;

public:
	DespawnCreatureTask(AiAgent* cr) {
		creature = cr;
	}

	void run() {
		Locker locker(creature);

		Zone* zone = creature->getZone();

		if (zone == NULL)
			return;

		creature->removeFromZone();
		creature->notifyDespawn(zone);

		//creature->printReferenceHolders();

		/*PatrolPoint* homeLocation = creature->getHomeLocation();

		if (homeLocation->getPosit)*/
	}
};


#endif /* DESPAWNCREATURETASK_H_ */
