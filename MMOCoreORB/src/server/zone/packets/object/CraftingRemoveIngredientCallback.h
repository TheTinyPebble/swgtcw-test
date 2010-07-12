/*
 * CraftingRemoveIngredientCallback.h
 *
 *  Created on: 10/07/2010
 *      Author: Kyle
 */

#ifndef CRAFTINGREMOVEINGREDIENTCALLBACK_H_
#define CRAFTINGREMOVEINGREDIENTCALLBACK_H_


#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "ObjectControllerMessageCallback.h"
#include "server/zone/objects/tangible/tool/CraftingTool.h"

class CraftingRemoveIngredientCallback : public MessageCallback {
	uint64 objectID;
	int slot;
	int counter;

	ObjectControllerMessageCallback* objectControllerMain;
public:
	CraftingRemoveIngredientCallback(ObjectControllerMessageCallback* objectControllerCallback) :
		MessageCallback(objectControllerCallback->getClient(), objectControllerCallback->getServer()) {

		objectControllerMain = objectControllerCallback;
	}

	void parse(Message* message) {
		//System::out << message->toStringData() << endl;
		message->parseInt();

		slot = message->parseInt();

		objectID = message->parseLong();

		counter = message->parseByte();

	}

	void run() {
		PlayerCreature* player = (PlayerCreature*) client->getPlayer();

		ManagedReference<CraftingTool* > craftingTool = player->getLastCraftingToolUsed();

		if(craftingTool == NULL) {
			player->sendSystemMessage("ui_craft", "err_no_crafting_tool");
			return;
		}

		ManagedReference<SceneObject* > object = player->getZoneServer()->getObject(objectID);

		if(object != NULL && object->isTangibleObject()) {

			TangibleObject* tano = (TangibleObject*) object.get();
			craftingTool->removeIngredient(player, tano, slot, counter);

		} else {
			player->sendSystemMessage("ui_craft","err_invalid_ingredient");
		}
	}
};


#endif /* CRAFTINGREMOVEINGREDIENTCALLBACK_H_ */
