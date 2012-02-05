/*
 * InstallationDeedImplementation.cpp
 *
 *  Created on: Jun 4, 2010
 *      Author: crush
 */


#include "InstallationDeed.h"
#include "server/zone/templates/tangible/SharedInstallationObjectTemplate.h"
#include "server/zone/managers/templates/TemplateManager.h"
#include "server/zone/packets/scene/AttributeListMessage.h"
#include "server/zone/templates/tangible/StructureDeedTemplate.h"

#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/packets/player/EnterStructurePlacementModeMessage.h"

void InstallationDeedImplementation::initializeTransientMembers() {
	DeedImplementation::initializeTransientMembers();

	StructureDeedTemplate* templ = dynamic_cast<StructureDeedTemplate*>(templateObject.get());

	if (templ != NULL)
		placeStructureComponent = templ->getStructurePlacementComponent();

	setLoggingName("BuildingDeed");
}

int InstallationDeedImplementation::handleObjectMenuSelect(CreatureObject* player, byte selectedID) {
	if (selectedID != 20) // not use object
		return 1;

	String actionName = "placestructuremode";
	player->executeObjectControllerAction(actionName.hashCode(), getObjectID(), "");
	return 0;
}

void InstallationDeedImplementation::fillAttributeList(AttributeListMessage* alm, CreatureObject* object) {
	DeedImplementation::fillAttributeList(alm, object);

	TemplateManager* templateManager = TemplateManager::instance();

	uint32 installationCRC = generatedObjectTemplate.hashCode();

	SharedInstallationObjectTemplate* installationTemplate = dynamic_cast<SharedInstallationObjectTemplate*>(templateManager->getTemplate(installationCRC));

	if (installationTemplate == NULL)
		return;

	//Base Maintenance Rate
	int baseMaintenanceRate = installationTemplate->getBaseMaintenanceRate();
	int basePowerRate = installationTemplate->getBasePowerRate();

	if (baseMaintenanceRate > 0)
		alm->insertAttribute("examine_maintenance_rate", String::valueOf(baseMaintenanceRate) + " / hour"); //Base Maintenance Rate

	if (surplusMaintenance > 0)
		alm->insertAttribute("examine_maintenance", String::valueOf(surplusMaintenance)); //Surplus Maintenance

	if (surplusPower > 0)
		alm->insertAttribute("examine_power", String::valueOf(surplusPower)); //Surplus Power

	if (hopperSizeMax > 0)
		alm->insertAttribute("examine_hoppersize", String::valueOf((int)hopperSizeMax));

	if (extractionRate > 0)
			alm->insertAttribute("examine_extractionrate", String::valueOf((int) extractionRate));
}

void InstallationDeedImplementation::updateCraftingValues(CraftingValues* values, bool firstUpdate){

	/*
		 * Incoming Values:					Ranges:
		 * extractrate						Differs between installations
		 * hoppersize
		 */
		setExtractionRate(values->getCurrentValue("extractrate"));
		setHopperSizeMax(values->getCurrentValue("hoppersize"));
}

void InstallationDeedImplementation::setExtractionRate(float rate){
	extractionRate = rate;
}

void InstallationDeedImplementation::setHopperSizeMax(float size){
	hopperSizeMax = size;
}

float InstallationDeedImplementation::getExtractionRate(){
	return extractionRate;
}

float InstallationDeedImplementation::getHopperSizeMax(){
	return hopperSizeMax;
}
