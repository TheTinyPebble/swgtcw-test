/*
 * TurretObserverImplementation.cpp
 *
 *  Created on: Nov 20, 2012
 *      Author: root
 */
#include "TurretObserver.h"
#include "server/zone/objects/building/BuildingObject.h"
#include "server/zone/managers/gcw/GCWManager.h"
#include "server/zone/managers/gcw/InstallationDestructionTask.h"
#include "server/zone/objects/installation/InstallationObject.h"


int TurretObserverImplementation::notifyObserverEvent(uint32 eventType, Observable* observable, ManagedObject* arg1, int64 arg2) {

	if(eventType == ObserverEventType::OBJECTDESTRUCTION){
		ManagedReference<InstallationObject*> installation = cast<InstallationObject*>(observable);

		if(installation != NULL){
			InstallationDestructionTask* task = new InstallationDestructionTask(installation);
			task->execute();
		}
	}

	return 0;
}






