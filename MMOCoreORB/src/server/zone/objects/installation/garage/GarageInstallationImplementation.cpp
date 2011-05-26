/*
 * GarageInstallationImplementation.cpp
 *
 *  Created on: Dec 6, 2010
 *      Author: crush
 */



#include "GarageInstallation.h"
#include "server/zone/objects/area/ActiveArea.h"
#include "server/zone/ZoneServer.h"

void GarageInstallationImplementation::createChildObjects() {
	float positionX = coordinates.getPositionX();
	float positionY = coordinates.getPositionY();
	float positionZ = coordinates.getPositionZ();

	uint32 garageAreaTemplateCRC = String("object/garage_area.iff").hashCode();
	ManagedReference<SceneObject*> obj = server->getZoneServer()->createObject(garageAreaTemplateCRC, 1);

	if (obj == NULL)
		return;

	ActiveArea* activeArea = (ActiveArea*) obj.get();

	activeArea->setRadius(64);
	activeArea->initializePosition(getPositionX(), getPositionZ(), getPositionY());
	activeArea->insertToZone(getZone());

	garageArea = activeArea;
}

void GarageInstallationImplementation::destroyObjectFromDatabase(bool destroyContainedObjects) {
	InstallationObjectImplementation::destroyObjectFromDatabase(destroyContainedObjects);

	if (!destroyContainedObjects)
		return;

	if (garageArea != NULL)
		garageArea->destroyObjectFromDatabase(true);
}
