/*
 * CityManagementMenuComponent.cpp
 *
 *  Created on: Feb 12, 2012
 *      Author: xyborn
 */

#include "CityManagementMenuComponent.h"
#include "../CityRegion.h"
#include "server/zone/packets/object/ObjectMenuResponse.h"
#include "server/zone/objects/creature/CreatureObject.h"

void CityManagementMenuComponent::fillObjectMenuResponse(SceneObject* sceneObject, ObjectMenuResponse* menuResponse, CreatureObject* player) {
	CityRegion* city = sceneObject->getCityRegion();

	if (city == NULL)
		return;

	menuResponse->addRadialMenuItem(211, 3, "@city/city:city_info"); //City Info
	menuResponse->addRadialMenuItemToRadialID(211, 212, 3, "@city/city:city_status"); //Status Report
	menuResponse->addRadialMenuItemToRadialID(211, 213, 3, "@city/city:city_citizens"); //Citizenship Report
	menuResponse->addRadialMenuItemToRadialID(211, 214, 3, "@city/city:city_structures"); //Structure Report
	menuResponse->addRadialMenuItemToRadialID(211, 223, 3, "@city/city:city_rank"); //City Advancement
	menuResponse->addRadialMenuItemToRadialID(211, 224, 3, "@city/city:city_maint"); //Maintenance Report
	menuResponse->addRadialMenuItemToRadialID(211, 215, 3, "@city/city:treasury_status"); //Treasury Report

	if (!city->isMayor(player->getObjectID()))
		return;

	menuResponse->addRadialMenuItem(216, 3, "@city/city:city_management"); //City Management
	menuResponse->addRadialMenuItemToRadialID(216, 217, 3, "@city/city:city_name"); //Change City Name

	//TODO: This should be a toggle.
	menuResponse->addRadialMenuItemToRadialID(216, 222, 3, "@city/city:city_unregister"); //Unregister City
	//menuResponse->addRadialMenuItemToRadialID(216, 222, 3, "@city/city:city_register"); //Register City

	if (city->isZoningEnabled()) {
		menuResponse->addRadialMenuItemToRadialID(216, 226, 3, "@city/city:unzone"); //Disable Zoning
	} else {
		menuResponse->addRadialMenuItemToRadialID(216, 226, 3, "@city/city:zone"); //Enable Zoning
	}

	menuResponse->addRadialMenuItemToRadialID(216, 218, 3, "@city/city:city_militia"); //Manage Militia

	menuResponse->addRadialMenuItemToRadialID(216, 219, 3, "@city/city:treasury_taxes"); //Adjust Taxes

	menuResponse->addRadialMenuItemToRadialID(216, 220, 3, "@city/city:treasury_deposit"); //Treasury Deposit
	menuResponse->addRadialMenuItemToRadialID(216, 221, 3, "@city/city:treasury_withdraw"); //Treasury Withdraw

	menuResponse->addRadialMenuItemToRadialID(216, 225, 3, "@city/city:city_specializations"); //City Specialization
}

int CityManagementMenuComponent::handleObjectMenuSelect(SceneObject* sceneObject, CreatureObject* player, byte selectID) {
	CityRegion* city = sceneObject->getCityRegion();

	if (city == NULL)
		return 1;

	switch (selectID) {
	case 226:
		if (city->isMayor(player->getObjectID())) {
			if (city->toggleZoningEnabled()) {
				player->sendSystemMessage("@city/city:zoning_enabled"); //Your city now has zoning enabled.
			} else {
				player->sendSystemMessage("@city/city:zoning_disabled"); //Your city now has zoning disabled.
			}
		}
		break;
	}
	return 0;
}
