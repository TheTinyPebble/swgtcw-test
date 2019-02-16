/*
 * VendorTokenMenucomponent
 * 
 * Author: TheTinyPebble
 * 
 */

#include "server/zone/objects/tangible/misc/VendorToken.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/zone/packets/scene/AttributeListMessage.h"
#include "server/zone/packets/object/ObjectMenuResponse.h"
#include "server/zone/Zone.h"
#include "server/zone/ZoneServer.h"
#include "server/zone/managers/director/DirectorManager.h"
#include "server/zone/objects/player/sui/callbacks/SplitTokenSuiCallback.h"
#include "server/zone/objects/player/sui/SuiWindowType.h"
#include "server/zone/objects/player/sui/inputbox/SuiInputBox.h"
#include "server/zone/objects/player/sui/transferbox/SuiTransferBox.h"

void VendorTokenImplementation::fillObjectMenuResponse(ObjectMenuResponse* menuResponse, CreatureObject* player) {
	SceneObject* sceno = cast <SceneObject*>(_this.getReferenceUnsafeStaticCast());
	String fullTemplate = getObjectTemplate()->getFullTemplateString();
	
	menuResponse->addRadialMenuItem(20,3,"Split Tokens");
}

int VendorTokenImplementation::handleObjectMenuSelect(CreatureObject* player, byte selectedID) {
	PlayerObject* ghost = player->getPlayerObject();
	if (ghost == NULL)
		return 0;
	
	SceneObject* inventory = player->getSlottedObject("inventory");
	if (inventory == NULL)
		return 0;
		
	if (!isASubChildOf(inventory)) {
		player->sendSystemMessage("You cannot split items if they are not in your inventory.");
		return 0;
	}
	
	SceneObject* sceno = cast <SceneObject*>(_this.getReferenceUnsafeStaticCast());
	String fullTemplate = sceno->getObjectTemplate()->getFullTemplateString();
	int itemCount = 0;

	if (selectedID == 20) {
		if (getUseCount() == 1) {
			player->sendSystemMessage("You can't split a single item.");
			return 0;
		}
		
		ManagedReference<SuiTransferBox*> transfer = new SuiTransferBox(player, SuiWindowType::OBJECT_NAME);
		transfer->setPromptTitle("Split Items");
		transfer->setPromptText("Select how many items go into each stack.");
		transfer->addFrom("Original Stack", "0", "0", "1");
		transfer->addTo("New Stack", String::valueOf(getUseCount()), String::valueOf(getUseCount()), "1");
		transfer->setUsingObject(_this.getReferenceUnsafeStaticCast());
		transfer->setForceCloseDistance(1024.f);
		transfer->setCallback(new SplitTokenSuiCallback(player->getZoneServer(), sceno));
		
		ghost->addSuiBox(transfer);
		player->sendMessage(transfer->generateMessage());
	}

	return 1;
}
