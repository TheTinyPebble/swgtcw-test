/*
 * TrainerCreatureImplementation.cpp
 *
 *  Created on: 26/05/2010
 *      Author: victor
 */

#include "JunkdealerCreature.h"
#include "server/zone/ZoneServer.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/packets/object/StartNpcConversation.h"
#include "server/zone/packets/object/StringList.h"
#include "server/zone/packets/object/StopNpcConversation.h"
#include "server/zone/packets/object/NpcConversationMessage.h"
#include "server/zone/objects/player/sui/listbox/SuiListBox.h"
#include "server/zone/objects/player/sui/SuiWindowType.h"
#include "server/zone/objects/tangible/loot/LootkitObject.h"
#include "server/zone/objects/scene/variables/ParameterizedStringId.h"


void JunkdealerCreatureImplementation::sendConversationStartTo(SceneObject* obj) {
	if (!obj->isPlayerCreature())
		return;

	PlayerCreature* player = (PlayerCreature*) obj;

	String stffile = "conversation/junk_dealer_generic";

	StartNpcConversation* conv = new StartNpcConversation(player, getObjectID(), "");
	player->sendMessage(conv);
	player->setLastNpcConvStr(getObjectNameStringIdName());

	player->setLastNpcConvMessStr("");
	sendInitialMessage(player);

}


void JunkdealerCreatureImplementation::sendInitialMessage(PlayerCreature* player) {
	String stffile = "conversation/junk_dealer_generic";
	String stfname = "s_bef51e38";

	NpcConversationMessage* m1 = new NpcConversationMessage(player, stffile, stfname);
	player->sendMessage(m1);

	player->setLastNpcConvMessStr("junkdealer_initial");
	sendInitialChoices(player);
}


void JunkdealerCreatureImplementation::sendInitialChoices(PlayerCreature* player) {
	StringList* slist = new StringList(player);

	slist->insertOption("conversation/junk_dealer_generic", "s_54fab04f");
	slist->insertOption("conversation/junk_dealer_generic", "s_cd7a3f41");
	slist->insertOption("conversation/junk_dealer_generic", "s_3aa18b2d");

	player->setLastNpcConvMessStr("junkdealer_options");

	player->sendMessage(slist);
}

void JunkdealerCreatureImplementation::selectConversationOption(int option, SceneObject* obj) {
	if (!obj->isPlayerCreature())
		return;

	PlayerCreature* player = (PlayerCreature*) obj;

	if (player->getLastNpcConvStr() != getObjectNameStringIdName())
		return;

	PlayerObject* ghost = (PlayerObject*) player->getSlottedObject("ghost");

	String stffile = "conversation/junk_dealer_generic";

	String choice;

	if (player->countLastNpcConvOptions() > 0) {
		if (player->getLastNpcConvMessStr() == "junkdealer_kit5")
			choice = player->getLastNpcConvOption(0);
		else if (player->countLastNpcConvOptions() > (uint32)option)
			choice = player->getLastNpcConvOption(option);
	}

	player->clearLastNpcConvOptions();


	if (player->getLastNpcConvMessStr() == "junkdealer_options") {
		switch (option) {
			case 0: {
				NpcConversationMessage* skillmsg = new NpcConversationMessage(player, stffile, "s_84a67771");
				player->setLastNpcConvMessStr("junkdealer_sell");
				player->addLastNpcConvOptions(choice);
				player->sendMessage(skillmsg);

				createSellJunkLootSelection(player);

				break;
			}
			case 1: {
				NpcConversationMessage* skillmsg = new NpcConversationMessage(player, stffile, "s_4bd9d15e");
				player->setLastNpcConvMessStr("junkdealer_nosell");
				player->addLastNpcConvOptions(choice);
				player->sendMessage(skillmsg);

				break;
			}
			case 2: {
				NpcConversationMessage* skillmsg = new NpcConversationMessage(player, stffile, "s_d9e6b751");
				player->setLastNpcConvMessStr("junkdealer_kit1");
				player->addLastNpcConvOptions(choice);
				player->sendMessage(skillmsg);

				StringList* slist = new StringList(player);

				slist->insertOption(stffile, "s_6d53d062");

				player->sendMessage(slist);

				break;
			}
		}
	} else if (player->getLastNpcConvMessStr() == "junkdealer_kit1") {
		if (option == 0) {
			NpcConversationMessage* skillmsg = new NpcConversationMessage(player, stffile, "s_e29f48dc");
			player->setLastNpcConvMessStr("junkdealer_kit2");
			player->addLastNpcConvOptions(choice);
			player->sendMessage(skillmsg);

			StringList* slist = new StringList(player);

			slist->insertOption(stffile, "s_324b9b0f");

			player->sendMessage(slist);

		}
	} else if (player->getLastNpcConvMessStr() == "junkdealer_kit2") {
		if (option == 0) {
			NpcConversationMessage* skillmsg = new NpcConversationMessage(player, stffile, "s_12fe83a6");
			player->setLastNpcConvMessStr("junkdealer_kit3");
			player->addLastNpcConvOptions(choice);
			player->sendMessage(skillmsg);

			StringList* slist = new StringList(player);

			slist->insertOption(stffile, "s_e1a103e5");

			player->sendMessage(slist);

		}
	} else if (player->getLastNpcConvMessStr() == "junkdealer_kit3") {
		if (option == 0) {
			NpcConversationMessage* skillmsg = new NpcConversationMessage(player, stffile, "s_4d65752");
			player->setLastNpcConvMessStr("junkdealer_kit4");
			player->addLastNpcConvOptions(choice);
			player->sendMessage(skillmsg);

			StringList* slist = new StringList(player);

			slist->insertOption(stffile, "s_d347bee3");
			slist->insertOption(stffile, "s_b60b73f8");

			player->sendMessage(slist);

		}
	} else if (player->getLastNpcConvMessStr() == "junkdealer_kit4") {
		if (option == 0) {
			NpcConversationMessage* skillmsg = new NpcConversationMessage(player, stffile, "s_3fc7eb45");
			player->setLastNpcConvMessStr("junkdealer_kit5");
			player->addLastNpcConvOptions(choice);
			player->sendMessage(skillmsg);

			StringList* slist = new StringList(player);

			slist->insertOption(stffile, "s_ee977dee");
			slist->insertOption(stffile, "s_8f39769");
			slist->insertOption(stffile, "s_fe657cdd");
			slist->insertOption(stffile, "s_9ede4b84");
			slist->insertOption(stffile, "s_87c5851b");

			player->sendMessage(slist);

		} else {
			NpcConversationMessage* skillmsg = new NpcConversationMessage(player, stffile, "s_3633b5a5");
			player->setLastNpcConvMessStr("junkdealer_nokit");
			player->addLastNpcConvOptions(choice);
			player->sendMessage(skillmsg);
		}

	} else if (player->getLastNpcConvMessStr() == "junkdealer_kit5") {
		ManagedReference<SceneObject*> inventory = player->getSlottedObject("inventory");

		bool found = false;

		uint32 CRC = 0;

		switch (option) {
			case 0: {
				CRC = ORANGERUG;
				break;
			}
			case 1: {
				CRC = BLUERUG;
				break;
			}
			case 2: {
				CRC = GONG;
				break;
			}
			case 3: {
				CRC = TABLE;
				break;
			}
			default: {
				CRC = SCULPTURE;
			}
		}

		Locker locker(inventory);

		for (int i = 0; i < inventory->getContainerObjectsSize(); i++) {
			uint32 objectCRC = inventory->getContainerObject(i)->getServerObjectCRC();
			if (objectCRC == BLUERUG || objectCRC == ORANGERUG || objectCRC == GONG || objectCRC == TABLE || objectCRC == SCULPTURE) {
				found = true;
			}
		}

		ManagedReference<SceneObject*> bank = player->getSlottedObject("bank");

		Locker blocker(bank);

		for (int j = 0; j < bank->getContainerObjectsSize(); j++) {
			uint32 objectCRC = bank->getContainerObject(j)->getServerObjectCRC();
			if (objectCRC == BLUERUG || objectCRC == ORANGERUG || objectCRC == GONG || objectCRC == TABLE || objectCRC == SCULPTURE) {
				found = true;
			}
		}

		if (found) {
			NpcConversationMessage* skillmsg = new NpcConversationMessage(player, stffile, "s_3df21ea0");
			player->setLastNpcConvMessStr("junkdealer_alreadyhavekit");
			player->addLastNpcConvOptions(choice);
			player->sendMessage(skillmsg);

		} else if (inventory->hasFullContainerObjects()) {
			NpcConversationMessage* skillmsg = new NpcConversationMessage(player, stffile, "s_5b10c0b9");
			player->setLastNpcConvMessStr("junkdealer_inventoryfull");
			player->addLastNpcConvOptions(choice);
			player->sendMessage(skillmsg);

		} else {
			NpcConversationMessage* skillmsg = new NpcConversationMessage(player, stffile, "s_14efaaa2");
			player->setLastNpcConvMessStr("junkdealer_givekit");
			player->addLastNpcConvOptions(choice);
			player->sendMessage(skillmsg);

			ManagedReference<LootkitObject*> lootkit = (LootkitObject*)server->getZoneServer()->createObject(CRC, 2);

			lootkit->sendTo(player, true);
			if (!inventory->addObject(lootkit, -1, true))
				info("Could not add object.", true);
		}
	} else
		player->sendMessage(new StopNpcConversation(player, getObjectID()));
}

void JunkdealerCreatureImplementation::createSellJunkLootSelection(PlayerCreature* player) {
	if (player == NULL)
		return;

	// create new window
	ManagedReference<SuiListBox*> box = new SuiListBox(player, SuiWindowType::JUNK_DEALER_SELL_LIST, SuiListBox::HANDLETHREEBUTTON);

	box->setPromptText("@loot_dealer:sell_prompt");
	box->setOtherButton(true, "@loot_dealer:btn_sell_all");
	box->setPromptTitle("@loot_dealer:sell_title");

	box->setHandlerText("handleUpdateSchematic");
	box->setOkButton(true, "@loot_dealer:btn_sell");
	box->setCancelButton(true, "@cancel");

	//box->addMenuItem("[1337] Medal of Elvaron", 0);

	box->setUsingObjectID(getObjectID());
	player->addSuiBox(box);
	player->sendMessage(box->generateMessage());
}
