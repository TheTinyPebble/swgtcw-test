/*
 * TrainerCreatureImplementation.cpp
 *
 *  Created on: 26/05/2010
 *      Author: victor
 */

#include "TrainerCreature.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/packets/object/StartNpcConversation.h"
#include "server/zone/packets/object/StringList.h"
#include "server/zone/packets/object/StopNpcConversation.h"
#include "server/zone/packets/object/NpcConversationMessage.h"
#include "server/zone/objects/player/sui/listbox/SuiListBox.h"
#include "server/zone/objects/player/sui/SuiWindowType.h"
#include "server/zone/objects/creature/professions/SkillBox.h"
#include "server/zone/objects/scene/variables/ParameterizedStringId.h"


void TrainerCreatureImplementation::sendConversationStartTo(SceneObject* obj) {
	if (!obj->isPlayerCreature())
		return;

	PlayerCreature* player = (PlayerCreature*) obj;

	String stffile = "skill_teacher";

	StartNpcConversation* conv = new StartNpcConversation(player, getObjectID(), "");
	player->sendMessage(conv);
	player->setLastNpcConvStr(getObjectNameStringIdName());

	bool qual = true;

	SkillBox* sBox = profession->getNoviceBox();

	player->setLastNpcConvMessStr("");

	for (int i = 0; (qual == true) && (i < sBox->getRequiredSkillsSize()); i++) {
		String skillname;
		sBox->getRequiredSkill(skillname, i);

		if (!player->hasSkillBox(skillname)) {
			qual = false;
		}
	}

	if (!qual) {
		NpcConversationMessage *fail = new NpcConversationMessage(player,
				stffile, "no_qualify");
		player->sendMessage(fail);

		ManagedReference<SuiListBox*> suiBox = new SuiListBox(player,
				SuiWindowType::DENY_TRAINING_LIST);

		suiBox->setPromptTitle("@skill_teacher:no_qualify_title");
		suiBox->setPromptText("@skill_teacher:no_qualify_prompt");

		for (int j = 0; j < sBox->getRequiredSkillsSize(); j++) {
			StringBuffer skillboxname;
			skillboxname << "@skl_n:" << sBox->getRequiredSkill(j)->getName();

			suiBox->addMenuItem(skillboxname.toString());
		}

		player->addSuiBox(suiBox);
		player->sendMessage(suiBox->generateMessage());
		player->setConversatingCreature(NULL);
		player->sendMessage(new StringList(player));
		player->sendMessage(new StopNpcConversation(player, getObjectID()));

	} else if (qual) {
		sendInitialMessage(player);
	}

}


void TrainerCreatureImplementation::sendInitialMessage(PlayerCreature* player) {
	String stffile = "skill_teacher";
	String stfname = getObjectNameStringIdName();

	NpcConversationMessage* m1 = new NpcConversationMessage(player, stffile, stfname);
	player->sendMessage(m1);

	player->setLastNpcConvMessStr("trainer_initial");
	sendInitialChoices(player);
}


void TrainerCreatureImplementation::sendInitialChoices(PlayerCreature* player) {
	StringList* slist = new StringList(player);

	slist->insertOption("skill_teacher", "opt1_1");
	slist->insertOption("skill_teacher", "opt1_2");
	//slist->insertOption("skill_teacher", "opt1_3");
	//slist->insertOption("skill_teacher", "opt1_4");

	player->setLastNpcConvMessStr("trainer_initial");

	player->sendMessage(slist);
}

void TrainerCreatureImplementation::sendSkillBoxes(PlayerCreature* player, bool checkXp) {
	StringList* slist = new StringList(player);
	Vector<SkillBox*>* skillBoxes;
	String stffile = "skill_teacher";

	skillBoxes = profession->getSkillBoxes();

	String option;
	int known = 0;

	player->clearLastNpcConvOptions();

	PlayerObject* playerObject = (PlayerObject*) player->getSlottedObject("ghost");

	for (int i = 0; i < skillBoxes->size(); i++) {
		SkillBox* skillBox = skillBoxes->get(i);
		bool qual = true;

		if (player->hasSkillBox(skillBox->getName())) {
			known++;
			qual = false;
		}

		if (checkXp && (skillBox->getSkillXpCost() > playerObject->getExperience(skillBox->getSkillXpType())))
			qual = false;

		for (int j = 0; (qual == true) && (j < skillBox->getRequiredSkillsSize()); j++) {
			String skillname;
			skillBox->getRequiredSkill(skillname, j);

			if (!player->hasSkillBox(skillname))
				qual = false;
		}

		if (qual) {
			slist->insertOption("skl_n", skillBox->getName());
			player->addLastNpcConvOptions(skillBox->getName());
		}
	}

	if (checkXp)
		player->setLastNpcConvMessStr("trainer_canlearn");
	else
		player->setLastNpcConvMessStr("trainer_nextskills");

	if (slist->getOptionCount() > 0)
		if (checkXp)
			option = "msg2_1";
		else
			option = "msg2_2";
	else if (known == skillBoxes->size())
		option = "msg3_1";
	else
		option = "error_empty_category";

	NpcConversationMessage* m2 = new NpcConversationMessage(player, stffile, option);
	player->sendMessage(m2);

	slist->insertOption("skill_teacher", "back");
	player->addLastNpcConvOptions(String("back"));
	player->sendMessage(slist);
}

void TrainerCreatureImplementation::sendSkillBoxList(PlayerCreature* player, bool checkLearned) {
	StringList* slist = new StringList(player);
	Vector<SkillBox*>* skillBoxes;

	String stffile = "skill_teacher";

	skillBoxes = profession->getSkillBoxes();

	for (int i = 0; i < skillBoxes->size(); i++) {
		SkillBox *skillBox = skillBoxes->get(i);

		if (checkLearned && player->hasSkillBox(skillBox->getName()))
			continue;

		slist->insertOption("skl_n", skillBox->getName());
		player->addLastNpcConvOptions(skillBox->getName());
	}

	String option;
	if (checkLearned) {
		option = "msg2_3";
		player->setLastNpcConvMessStr("trainer_unlearned");
	} else {
		option = "msg2_4";
		player->setLastNpcConvMessStr("trainer_allskills");
	}

	NpcConversationMessage* m3 = new NpcConversationMessage(player, stffile, option);
	slist->insertOption("skill_teacher", "back");
	player->addLastNpcConvOptions(String("back"));
	player->sendMessage(slist);
}

void TrainerCreatureImplementation::sendConfirmation(PlayerCreature* player) {
	StringList* slist = new StringList(player);

	slist->insertOption("skill_teacher", "yes");
	slist->insertOption("skill_teacher", "no");

	player->sendMessage(slist);
}

void TrainerCreatureImplementation::selectConversationOption(int option, SceneObject* obj) {
	if (!obj->isPlayerCreature())
		return;

	PlayerCreature* player = (PlayerCreature*) obj;

	if (player->getLastNpcConvStr() != getObjectNameStringIdName())
		return;

	PlayerObject* ghost = (PlayerObject*) player->getSlottedObject("ghost");

	String stffile = "skill_teacher";

	Vector<SkillBox*>* skillBoxes;

	bool deleteSkills = false;
	skillBoxes = profession->getSkillBoxes();

	String choice;

	if (player->countLastNpcConvOptions() > 0) {
		if (player->getLastNpcConvMessStr() == "trainer_learn")
			choice = player->getLastNpcConvOption(0);
		else if (player->countLastNpcConvOptions() > (uint32)option)
			choice = player->getLastNpcConvOption(option);
	}

	player->clearLastNpcConvOptions();

	if (player->getLastNpcConvMessStr() == "trainer_initial" ||
			player->getLastNpcConvMessStr() == "jedi_trainer_initial") {
		switch (option) {
		case 0:
			sendSkillBoxes(player, true);
			break;
		case 1:
			sendSkillBoxes(player, false);
			break;
		case 2:
			sendSkillBoxList(player, true);
			break;
		case 3:
			sendSkillBoxList(player, false);
			break;
		default:
			break;
		};

	} else if (player->getLastNpcConvMessStr() == "trainer_canlearn") {
		if (choice == "back") {
			sendInitialMessage(player);
		} else {
			NpcConversationMessage* skillmsg = new NpcConversationMessage(player, stffile, "confirm");
			player->setLastNpcConvMessStr("trainer_learn");
			player->addLastNpcConvOptions(choice);
			player->sendMessage(skillmsg);
			sendConfirmation(player);
		}
	} else if (player->getLastNpcConvMessStr() == "trainer_nextskills") {
		if (choice == "back") {
			sendInitialMessage(player);
		} else {
			NpcConversationMessage* skillmsg = new NpcConversationMessage(player, "skl_d", choice);
			player->sendMessage(skillmsg);
			sendSkillBoxes(player, false);
		}
	} else if (player->getLastNpcConvMessStr() == "trainer_unlearned") {
		if (choice == "back") {
			sendInitialMessage(player);
		} else {
			NpcConversationMessage* skillmsg = new NpcConversationMessage(player, "skl_d", choice);
			player->sendMessage(skillmsg);
			sendSkillBoxList(player, true);
		}
	} else if (player->getLastNpcConvMessStr() == "trainer_allskills") {
		if (choice == "back") {
			sendInitialMessage(player);
		} else {
			NpcConversationMessage* skillmsg = new NpcConversationMessage(player, "skl_d", choice);
			player->sendMessage(skillmsg);
			sendSkillBoxList(player, false);
		}
	} else if (player->getLastNpcConvMessStr() == "trainer_learn") {
		SkillBox* sBox = NULL;
		String optionmessage;
		int money, sp;

		switch (option) {
		case 0: {
			ParameterizedStringId params;
			params.setTO("skl_n", choice);

			for (int i = 0; i < skillBoxes->size(); i++) {
				if (skillBoxes->get(i)->getName() == choice) {
					sBox = skillBoxes->get(i);
					break;
				}
			}

			if (sBox != NULL) {
				money = sBox->getSkillMoneyRequired();
				sp = sBox->getSkillPointsRequired();

				PlayerObject* playerObject = (PlayerObject*) player->getSlottedObject("ghost");

				if (sBox->getSkillXpCost() > playerObject->getExperience(sBox->getSkillXpType())) {
					params.setStringId(stffile, "prose_train_failed");
					player->sendSystemMessage(params);
				} else if ((player->getSkillPoints() + sBox->getSkillPointsRequired()) > 250) {
					params.setDI(sp);
					if (player->getSkillPoints() != 250) {
						params.setStringId(stffile, "nsf_skill_points");
						player->sendSystemMessage(params);
					} else
						player->sendSystemMessage(stffile, "no_skill_points");
				} else if (!player->verifyCashCredits(money)) {
					params.setDI(money);
					params.setStringId(stffile, "prose_nsf");
					player->sendSystemMessage(params);
				} else {
					params.setDI(money);

					bool res = ProfessionManager::instance()->trainSkillBox(sBox, player, true);

					if (res == true) {
						playerObject->addExperience(sBox->getSkillXpType(), (-1) * sBox->getSkillXpCost(), true);
						player->substractCashCredits(money);
						params.setStringId(stffile, "prose_pay");
						player->sendSystemMessage(params);
						params.setStringId(stffile, "prose_skill_learned");
					}
				}
			}
			optionmessage = "msg_yes";
			break;
		}
		case 1: //no
			optionmessage = "msg_no";
			break;
		default:
			break;
		};

		NpcConversationMessage* skillmsg = new NpcConversationMessage(player, stffile, optionmessage);
		player->sendMessage(skillmsg);
		sendInitialChoices(player);
	} else
		player->sendMessage(new StopNpcConversation(player, getObjectID()));

	if (deleteSkills)
		delete skillBoxes;
}


/*
void TrainerCreatureImplementation::getMapLocation(GetMapLocationsResponseMessage* gmlr) {
	uint8 type2 = 0;

	if (profession->getName() == "combat_brawler")
		type2 = 20;

	if (profession->getName() == "crafting_artisan")
		type2 = 21;

	if (profession->getName() == "outdoors_scout")
		type2 = 22;

	if (profession->getName() == "combat_marksman")
		type2 = 23;

	if (profession->getName() == "social_entertainer")
		type2 = 24;

	if (profession->getName() == "science_medic")
		type2 = 25;

	if (type2 == 0)
		return;

	float x = positionX;
	float y = positionY;

	gmlr->addMapLocation(objectID, customName, x, y, 19, type2, 0);
}
*/
