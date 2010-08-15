/*
 * CraftingAddIngredientCallback.h
 *
 *  Created on: 10/07/2010
 *      Author: Kyle
 */

#ifndef CRAFTINGCUSTOMIZATIONCALLBACK_H_
#define CRAFTINGCUSTOMIZATIONCALLBACK_H_


#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "ObjectControllerMessageCallback.h"
#include "server/zone/objects/tangible/tool/CraftingTool.h"


class CraftingCustomizationCallback : public MessageCallback {
	String name;
	String customizationString;
	int schematicCount;
	int counter;

	ObjectControllerMessageCallback* objectControllerMain;
public:
	CraftingCustomizationCallback(ObjectControllerMessageCallback* objectControllerCallback) :
		MessageCallback(objectControllerCallback->getClient(), objectControllerCallback->getServer()) {

		objectControllerMain = objectControllerCallback;
	}

	void parse(Message* message) {
		//System::out << message->toStringData() << endl;
		message->parseInt();

		UnicodeString n;
		message->parseUnicode(n);

		name = n.toString();

		message->shiftOffset(1);

		schematicCount = message->parseInt();

		counter = message->parseByte();

		int value, count;

		StringBuffer ss;

		for (int i = 0; i < counter; ++i) {

			count = message->parseInt();

			value = message->parseInt();

			ss << count << " " << value;

			if (i < counter - 1)
				ss << " ";
		}

		customizationString = ss.toString();
	}

	void run() {
		ManagedReference<PlayerCreature*> player = (PlayerCreature*) client->getPlayer();

		ManagedReference<CraftingTool* > craftingTool = player->getLastCraftingToolUsed();

		if(craftingTool == NULL) {
			player->sendSystemMessage("ui_craft", "err_no_crafting_tool");
			return;
		}

		Locker _locker(craftingTool);

		craftingTool->customization(player, name, schematicCount, customizationString);


	}
};


#endif /* CRAFTINGCUSTOMIZATIONCALLBACK_H_ */
