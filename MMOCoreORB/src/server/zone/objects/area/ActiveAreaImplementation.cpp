/*
 * ActiveAreaImplementation.cpp
 *
 *  Created on: 02/06/2010
 *      Author: victor
 */

#include "ActiveArea.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "ActiveAreaEvent.h"
#include "server/zone/Zone.h"

bool ActiveAreaImplementation::containsPoint(float px, float py) {
	return (((px - positionX) * (px - positionX)) + ((py - positionY) * (py - positionY)) <= radius2 );
}

void ActiveAreaImplementation::insertToZone(Zone* newZone) {
	if (newZone == NULL)
		return;

	ManagedReference<SceneObject*> thisLocker = _this;

	Locker zoneLocker(newZone);

	if (isInQuadTree() && newZone != zone) {
		error("trying to insert to zone an object that is already in a different quadtree");

		removeFromZone();

		//StackTrace::printStackTrace();
	}

	SceneObjectImplementation::zone = newZone;

	QuadTree* regionTree = zone->getRegionTree();

	regionTree->insert(this);
	regionTree->inRange(this, 512);

	// lets update area to the in range players
	SortedVector<ManagedReference<SceneObject*> > objects;

	zone->getInRangeObjects(positionX, positionY, 512, &objects);

	for (int i = 0; i < objects.size(); ++i) {
		SceneObject* object = objects.get(i);

		if (!object->hasActiveArea(_this) && containsPoint(object->getPositionX(), object->getPositionY())) {
			object->addActiveArea(_this);
			enqueueEnterEvent(object);
		}
	}

	zone->addSceneObject(_this);
}

void ActiveAreaImplementation::removeFromZone() {
	if (zone == NULL)
		return;

	ManagedReference<SceneObject*> thisLocker = _this;

	Locker zoneLocker(zone);

	QuadTree* regionTree = zone->getRegionTree();

	regionTree->remove(this);

	while (inRangeObjectCount() > 0) {
		QuadTreeEntry* obj = getInRangeObject(0);

		if (obj != this)
			obj->removeInRangeObject(this);

		QuadTreeEntry::removeInRangeObject((int)0);
	}

	// lets remove the in range active areas of players
	SortedVector<ManagedReference<SceneObject*> > objects;

	zone->getInRangeObjects(positionX, positionY, 512, &objects);

	for (int i = 0; i < objects.size(); ++i) {
		SceneObject* object = objects.get(i);

		if (object->hasActiveArea(_this)) {
			object->dropActiveArea(_this);
			enqueueExitEvent(object);
		}
	}

	Zone* oldZone = zone;
	zone = NULL;

	oldZone->dropSceneObject(_this);
}



void ActiveAreaImplementation::enqueueEnterEvent(SceneObject* obj) {
	Reference<Task*> task = new ActiveAreaEvent(_this, obj, ActiveAreaEvent::ENTEREVENT);
	task->schedule(100);
}

void ActiveAreaImplementation::enqueueExitEvent(SceneObject* obj) {
	Reference<Task*> task = new ActiveAreaEvent(_this, obj, ActiveAreaEvent::EXITEVENT);
	task->schedule(100);
}

/*void ActiveAreaImplementation::notifyPositionUpdate(QuadTreeEntry* obj) {
	if (obj == NULL || obj == this)
		return;

	SceneObject* scno = (SceneObject*) (((SceneObjectImplementation*) obj)->_getStub());

	if (!scno->hasActiveArea(_this) && containsPoint(scno->getPositionX(), scno->getPositionY())) {
		scno->addActiveArea(_this);
		enqueueEnterEvent(scno);

	} else if (scno->hasActiveArea(_this) && !containsPoint(scno->getPositionX(), scno->getPositionY())) {
		scno->dropActiveArea(_this);
		enqueueExitEvent(scno);
	}
}

void ActiveAreaImplementation::notifyDissapear(QuadTreeEntry* obj) {
	if (obj == NULL || obj == this)
		return;

	SceneObject* scno = (SceneObject*) (((SceneObjectImplementation*) obj)->_getStub());

	if (scno->hasActiveArea(_this)) {
		scno->dropActiveArea(_this);
		enqueueExitEvent(scno);
	}
}*/
