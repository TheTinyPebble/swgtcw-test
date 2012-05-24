/*
 * AiStateComponent.h
 *
 *  Created on: May 6, 2012
 *      Author: da
 */

#ifndef AISTATECOMPONENT_H_
#define AISTATECOMPONENT_H_

#include "engine/engine.h"
#include "server/zone/objects/scene/components/SceneObjectComponent.h"

#include "server/zone/objects/scene/WorldCoordinates.h"
#include "server/zone/objects/creature/PatrolPointsVector.h"
#include "server/zone/objects/creature/PatrolPoint.h"

namespace server {
 namespace zone {
  namespace objects {
   namespace scene {
    class SceneObject;
   }

   namespace creature {
    namespace ai {
     class AiActor;
    }

    class CreatureObject;
   }
  }
 }
}

class AiStateComponent : public SceneObjectComponent {
public:
	/*
	 * we know everything we check for in AiActorImplemention::notifyPositionUpdate already, so we can assume things here
	 * TODO: does this need to be virtual? I can't see a case where we would need to override it, in which case this can
	 * 		be left in actor since all it does is add an awareness event
	 */
	virtual void notifyPositionUpdate(Observable* obs, QuadTreeEntry* entry) {}

	void notifyDespawn(AiActor* actor, Zone* zone);

	virtual void doAwarenessCheck(Observable* obs, Coordinate& start, uint64 time, CreatureObject* target) {}

	/*
	 * every action performed by a state will return a message so that it can be fed back into the FSM
	 * to update the state based on the outcome of the result
	 */

	// actions performed when entering a state
	virtual uint16 onEnter();

	// actions performed when exiting a state
	virtual uint16 onExit();

	virtual uint16 tryRetreat();

	virtual uint16 doRecovery();

	virtual uint16 doAttack();

	virtual uint16 doMovement();

	/*
	 * host = creature doing moving
	 * maxDistance = maxDistance to stay from target
	 * speed = speed to travel
	 * patrolPoints = queued points in path
	 * nextPosition = calculated next position
	 */
	bool findNextPosition(Observable* obs, float maxDistance, float speed, PatrolPointsVector* patrolPoints, WorldCoordinates* nextPosition);

	void setNextPosition(AiActor* actor, float x, float z, float y, SceneObject* cell = NULL);

	void updateCurrentPosition(CreatureObject* host, PatrolPoint* pos);

	void broadcastNextPositionUpdate(CreatureObject* host, PatrolPoint* point);

	void checkNewAngle(AiActor* actor);

	void sendConversationStartTo(CreatureObject* host, SceneObject* player);

	void selectWeapon(AiActor* actor);

	bool validateStateAttack(CreatureObject* target, String& args);
};

#endif /* AISTATECOMPONENT_H_ */
