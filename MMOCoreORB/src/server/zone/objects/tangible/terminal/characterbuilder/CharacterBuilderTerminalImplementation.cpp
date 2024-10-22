#include "server/zone/objects/tangible/terminal/characterbuilder/CharacterBuilderTerminal.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/creature/ai/AiAgent.h"
#include "server/zone/objects/player/sui/characterbuilderbox/SuiCharacterBuilderBox.h"
#include "server/zone/managers/skill/SkillManager.h"
#include "templates/tangible/CharacterBuilderTerminalTemplate.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/zone/managers/player/PlayerManager.h"
#include "server/zone/managers/jedi/JediManager.h"
#include "server/zone/managers/director/DirectorManager.h"

void CharacterBuilderTerminalImplementation::loadTemplateData(SharedObjectTemplate* templateData) {
	TangibleObjectImplementation::loadTemplateData(templateData);

	CharacterBuilderTerminalTemplate* terminalData = dynamic_cast<CharacterBuilderTerminalTemplate*>(templateData);

	if (terminalData == NULL)
		return;

	rootNode = terminalData->getItemList();

	//info("loaded " + String::valueOf(itemList.size()));
}

void CharacterBuilderTerminalImplementation::initializeTransientMembers() {
	TerminalImplementation::initializeTransientMembers();

	setLoggingName("CharacterBuilderTerminal");
}

int CharacterBuilderTerminalImplementation::handleObjectMenuSelect(CreatureObject* player, byte selectedID) {
	//info("entering start terminal radial call", true);

	if (selectedID != 20) // not use object
		return 1;

	sendInitialChoices(player);

	return 0;
}

void CharacterBuilderTerminalImplementation::sendInitialChoices(CreatureObject* player) {
	//info("entering sendInitialChoices", true);

	if (rootNode == NULL) {
		player->sendSystemMessage("There was an error initializing the menu for this character builder terminal. Sorry for the inconvenience.");
		return;
	}

	ManagedReference<SuiCharacterBuilderBox*> sui = new SuiCharacterBuilderBox(player, rootNode);
	sui->setUsingObject(_this.getReferenceUnsafeStaticCast());

	player->sendMessage(sui->generateMessage());
	player->getPlayerObject()->addSuiBox(sui);
}

void CharacterBuilderTerminalImplementation::enhanceCharacter(CreatureObject* player, int type) {
	PlayerManager* pm = player->getZoneServer()->getPlayerManager();

	pm->enhanceCharacter(player, type);

	ManagedReference<PlayerObject*> ghost = player->getPlayerObject();

	if (ghost == NULL)
		return;

	for (int i = 0; i < ghost->getActivePetsSize(); i++) {
		ManagedReference<AiAgent*> pet = ghost->getActivePet(i);

		if (pet != NULL) {
			Locker crossLocker(pet, player);

			pm->enhanceCharacter(pet, type);
		}
	}
}

void CharacterBuilderTerminalImplementation::giveLanguages(CreatureObject* player) {
	SkillManager* skillManager = server->getSkillManager();

	skillManager->awardSkill("social_language_basic_speak", player, true, true, true);
	skillManager->awardSkill("social_language_basic_comprehend", player, true, true, true);
	skillManager->awardSkill("social_language_rodian_speak", player, true, true, true);
	skillManager->awardSkill("social_language_rodian_comprehend", player, true, true, true);
	skillManager->awardSkill("social_language_trandoshan_speak", player, true, true, true);
	skillManager->awardSkill("social_language_trandoshan_comprehend", player, true, true, true);
	skillManager->awardSkill("social_language_moncalamari_speak", player, true, true, true);
	skillManager->awardSkill("social_language_moncalamari_comprehend", player, true, true, true);
	skillManager->awardSkill("social_language_wookiee_speak", player, true, true, true);
	skillManager->awardSkill("social_language_wookiee_comprehend", player, true, true, true);
	skillManager->awardSkill("social_language_bothan_speak", player, true, true, true);
	skillManager->awardSkill("social_language_bothan_comprehend", player, true, true, true);
	skillManager->awardSkill("social_language_twilek_speak", player, true, true, true);
	skillManager->awardSkill("social_language_twilek_comprehend", player, true, true, true);
	skillManager->awardSkill("social_language_zabrak_speak", player, true, true, true);
	skillManager->awardSkill("social_language_zabrak_comprehend", player, true, true, true);
	skillManager->awardSkill("social_language_lekku_speak", player, true, true, true);
	skillManager->awardSkill("social_language_lekku_comprehend", player, true, true, true);
	skillManager->awardSkill("social_language_ithorian_speak", player, true, true, true);
	skillManager->awardSkill("social_language_ithorian_comprehend", player, true, true, true);
	skillManager->awardSkill("social_language_sullustan_speak", player, true, true, true);
	skillManager->awardSkill("social_language_sullustan_comprehend", player, true, true, true);
}

void CharacterBuilderTerminalImplementation::grantGlowyBadges(CreatureObject* player) {
	CharacterBuilderTerminalTemplate* terminalTemplate = dynamic_cast<CharacterBuilderTerminalTemplate*>(templateObject.get());

	if (terminalTemplate == NULL)
		return;

	PlayerObject* ghost = player->getPlayerObject();

	if (ghost == NULL)
		return;

	int ids[] = { 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 38, 39, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 105, 106, 107, 108, 112, 113, 114, 115, 116, 117, 118, 119, 120, 129, 130, 131, 132, 134, 135, 136, 137, 138, 143, 144, 145, 146 };

	for (int i = 0; i < 30; i++) {
		ghost->awardBadge(ids[i]);
	}
}

void CharacterBuilderTerminalImplementation::grantJediInitiate(CreatureObject* player) {
	if (JediManager::instance()->getJediProgressionType() != JediManager::VILLAGEJEDIPROGRESSION)
		return;

	CharacterBuilderTerminalTemplate* terminalTemplate = dynamic_cast<CharacterBuilderTerminalTemplate*>(templateObject.get());

	if (terminalTemplate == NULL)
		return;

	PlayerObject* ghost = player->getPlayerObject();

	if (ghost == NULL)
		return;

	SkillManager* skillManager = server->getSkillManager();

	grantGlowyBadges(player);

	Lua* lua = DirectorManager::instance()->getLuaInstance();

	Reference<LuaFunction*> luaVillageGmCmd = lua->createFunction("FsIntro", "completeVillageIntroFrog", 0);
	*luaVillageGmCmd << player;

	luaVillageGmCmd->callFunction();

	Vector<String> branches = terminalTemplate->getVillageBranchUnlocks();

	for (int i = 0; i < branches.size(); i++) {
		String branch = branches.get(i);
		player->setScreenPlayState("VillageUnlockScreenPlay:" + branch, 2);
		skillManager->awardSkill(branch + "_04", player, true, true, true);
	}

	luaVillageGmCmd = lua->createFunction("FsOutro", "completeVillageOutroFrog", 0);
	*luaVillageGmCmd << player;

	luaVillageGmCmd->callFunction();
}
