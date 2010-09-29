/*
 * ResourceDeedImplementation.cpp
 *
 *  Created on: Sep 8, 2010
 *      Author: elvaron
 */

#include "ResourceDeed.h"
#include "server/zone/managers/resource/ResourceManager.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "server/zone/objects/player/sui/listbox/resourcedeedlistbox/ResourceDeedListBox.h"

#include "server/zone/packets/object/ObjectMenuResponse.h"

void ResourceDeedImplementation::initializeTransientMembers() {
	DeedImplementation::initializeTransientMembers();

	setLoggingName("ResourceDeed");
}

void ResourceDeedImplementation::fillObjectMenuResponse(ObjectMenuResponse* menuResponse, PlayerCreature* player) {
	DeedImplementation::fillObjectMenuResponse(menuResponse, player);

	menuResponse->addRadialMenuItem(20, 3, "@ui_radial:item_use"); //use
}

int ResourceDeedImplementation::handleObjectMenuSelect(PlayerCreature* player, byte selectedID) {
	if (selectedID != 20) // not use object
		return 1;

	if (player != NULL)
		useObject(player);

	return 0;
}

int ResourceDeedImplementation::useObject(PlayerCreature* player) {
	if (player == NULL)
		return 0;

	ManagedReference<ResourceManager*> resourceManager = server->getZoneServer()->getResourceManager();

	ResourceDeedListBox* sui1 = new ResourceDeedListBox(player, SuiWindowType::FREE_RESOURCE, SuiListBox::HANDLETHREEBUTTON);//beginning of sui chain

	sui1->setPromptTitle("Resources");
	sui1->setPromptText("Choose resource.");
	sui1->setCancelButton(true, "@cancel");
	sui1->setOtherButton(true, "@back");

	player->addSuiBox(sui1);
	String base = "resource";

	sui1->addBox(base);

	resourceManager->addChildrenToDeedListBox(base, sui1);

	sui1->setUsingObject(_this);

	player->sendMessage(sui1->generateMessage());

	return 1;
}

void ResourceDeedImplementation::destroyDeed() {
	if (parent != NULL)
		parent->removeObject(_this, true);

	if (isPersistent())
		destroyObjectFromDatabase(true);
}
