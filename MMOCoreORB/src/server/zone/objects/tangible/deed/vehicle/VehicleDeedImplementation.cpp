/*
 * DeedImplementation.cpp
 *
 *  Created on: Apr 18, 2010
 *      Author: crush
 */

#include "VehicleDeed.h"
#include"server/zone/ZoneServer.h"
#include "server/zone/packets/object/ObjectMenuResponse.h"
#include "server/zone/objects/manufactureschematic/ManufactureSchematic.h"
#include "server/zone/templates/tangible/VehicleDeedTemplate.h"
#include "server/zone/objects/intangible/VehicleControlDevice.h"
#include "server/zone/objects/creature/VehicleObject.h"

void VehicleDeedImplementation::loadTemplateData(SharedObjectTemplate* templateData) {
	DeedImplementation::loadTemplateData(templateData);

	VehicleDeedTemplate* deedData = dynamic_cast<VehicleDeedTemplate*>(templateData);

	if (deedData == NULL)
		return;

	controlDeviceObjectTemplate = deedData->getControlDeviceObjectTemplate();
}

void VehicleDeedImplementation::fillAttributeList(AttributeListMessage* alm, PlayerCreature* object) {
	DeedImplementation::fillAttributeList(alm, object);

	alm->insertAttribute("hit_points", hitPoints);
}

void VehicleDeedImplementation::initializeTransientMembers() {
	DeedImplementation::initializeTransientMembers();

	setLoggingName("VehicleDeed");
}

void VehicleDeedImplementation::updateCraftingValues(ManufactureSchematic* schematic) {
	/*
	 * Values available:	Range:
	 *
	 * hitpoints			varies, integrity of vehicle
	 */

	CraftingValues* craftingValues = schematic->getCraftingValues();

	hitPoints = (int)craftingValues->getCurrentValue("hit_points");
}

void VehicleDeedImplementation::fillObjectMenuResponse(ObjectMenuResponse* menuResponse, PlayerCreature* player) {
	DeedImplementation::fillObjectMenuResponse(menuResponse, player);

	menuResponse->addRadialMenuItem(20, 3, "@pet/pet_menu:menu_generate");
}

int VehicleDeedImplementation::handleObjectMenuSelect(PlayerCreature* player, byte selectedID) {
	if (selectedID != 20) // not use object
		return 1;

	if (generated)
		return 1;

	if (player->isInCombat() || player->getParentRecursively(SceneObject::BUILDING) != NULL) {
		player->sendSystemMessage("@pet/pet_menu:cant_call_vehicle"); //You can only unpack vehicles while Outside and not in Combat.
		return 1;
	}

	ManagedReference<SceneObject*> datapad = player->getSlottedObject("datapad");

	if (datapad == NULL) {
		player->sendSystemMessage("Datapad doesn't exist when trying to create vehicle");
		return 1;
	}

	VehicleControlDevice* vehicleControlDevice = (VehicleControlDevice*) server->getZoneServer()->createObject(controlDeviceObjectTemplate.hashCode(), 1);
	VehicleObject* vehicle = (VehicleObject*) server->getZoneServer()->createObject(generatedObjectTemplate.hashCode(), 1);

	vehicle->setMaxCondition(hitPoints);
	vehicle->setConditionDamage(0);
	vehicleControlDevice->setControlledObject(vehicle);
	datapad->addObject(vehicleControlDevice, -1);

	datapad->broadcastObject(vehicleControlDevice, true);
	vehicleControlDevice->generateObject(player);

	//Remove the deed from it's container.
	ManagedReference<SceneObject*> deedContainer = getParent();

	if (deedContainer != NULL) {
		deedContainer->removeObject(_this, true);
		broadcastDestroy(_this, false);
	}

	generated = true;

	return 0;
}

