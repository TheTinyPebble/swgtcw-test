/*
 * MissionManagerImplementation.cpp
 *
 *  Created on: 21/06/2010
 *      Author: victor
 */

#include "MissionManager.h"
#include "server/zone/objects/tangible/terminal/mission/MissionTerminal.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/mission/MissionObject.h"
#include "server/zone/objects/mission/SurveyMissionObjective.h"
#include "server/zone/objects/mission/DestroyMissionObjective.h"
#include "server/zone/objects/mission/DeliverMissionObjective.h"
#include "server/zone/objects/mission/EntertainerMissionObjective.h"
#include "server/zone/objects/mission/HuntingMissionObjective.h"
#include "server/zone/objects/mission/ReconMissionObjective.h"
#include "server/zone/objects/mission/BountyMissionObjective.h"
#include "server/zone/objects/creature/AiAgent.h"
#include "server/zone/objects/region/Region.h"
#include "server/zone/managers/resource/ResourceManager.h"
#include "server/zone/managers/templates/TemplateManager.h"
#include "server/zone/managers/planet/PlanetManager.h"
#include "server/zone/managers/planet/MissionTargetMap.h"
#include "server/zone/managers/name/NameManager.h"
#include "server/zone/templates/tangible/LairObjectTemplate.h"
#include "server/zone/managers/planet/HuntingTargetEntry.h"
#include "server/zone/objects/tangible/tool/SurveyTool.h"
#include "server/zone/Zone.h"
#include "server/db/ServerDatabase.h"

void MissionManagerImplementation::loadLairObjectsToSpawn() {
	info("loading lair objects to spawn...", true);

	String query = "SELECT * FROM mission_manager_spawn_lairs";

	Reference<ResultSet*> res = ServerDatabase::instance()->executeQuery(query);

	while (res->next()) {
		String templateObject = res->getString(1);
		String planets = res->getString(2);

		StringTokenizer tokenizer(planets);
		tokenizer.setDelimeter((","));

		while (tokenizer.hasMoreTokens()) {
			int planetID = tokenizer.getIntToken();

			lairObjectTemplatesToSpawn.addTemplate(planetID, templateObject.hashCode());
		}
	}

	/*StringBuffer msg;
	msg << "loaded " << lairObjectTemplatesToSpawn.size() << " lairs to spawn";
	info(msg.toString(), true);*/
}

void MissionManagerImplementation::loadNpcObjectsToSpawn() {
	info("loading npc objects to spawn...", true);

	String query = "SELECT * FROM mission_manager_spawn_bounty";

	Reference<ResultSet*> res = NULL;

	try {
		res = ServerDatabase::instance()->executeQuery(query);

		while (res->next()) {
			String templateName = res->getString(1);

			npcObjectTemplatesToSpawn.add(templateName.hashCode());
		}
	} catch (DatabaseException& e) {
		error(e.getMessage());
	}
}

void MissionManagerImplementation::handleMissionListRequest(MissionTerminal* missionTerminal, CreatureObject* player, int counter) {
	// newbie and statue terminals don't exist, but their templates do
	if (missionTerminal->isStatueTerminal() || missionTerminal->isNewbieTerminal()) {
		player->sendSystemMessage("skill_teacher", "skill_terminal_disabled");
		return;
	}

	ManagedReference<SceneObject*> missionBag = player->getSlottedObject("mission_bag");

	if (missionBag == NULL)
		return;

	while (missionBag->getContainerObjectsSize() < 6) {
		SceneObject* mission = server->createObject(0x18e19914, 1); // empty mission
		missionBag->addObject(mission, -1, false);
		mission->sendTo(player, true);
		//missionBag->updateToDatabaseWithoutChildren();
	}

	populateMissionList(missionTerminal, player, counter);
}

void MissionManagerImplementation::handleMissionAccept(MissionTerminal* missionTerminal, MissionObject* mission, CreatureObject* player) {
	SceneObject* missionBag = mission->getParent();

	if (missionBag == NULL)
		return;

	SceneObject* bagParent = missionBag->getParent();

	if (bagParent != player)
		return;

	SceneObject* playerMissionBag = player->getSlottedObject("mission_bag");

	if (playerMissionBag != missionBag)
		return;

	SceneObject* datapad = player->getSlottedObject("datapad");

	int missionCount = 0;

	for (int i = 0; i < datapad->getContainerObjectsSize(); ++i) {
		SceneObject* obj = datapad->getContainerObject(i);

		if (obj->isMissionObject())
			++missionCount;
	}

	if (missionCount >= 2) {
		StringIdChatParameter stringId("mission/mission_generic", "too_many_missions");
		player->sendSystemMessage(stringId);
		return;
	}

	// why are we limiting to one survey mission?
	/*if (mission->isSurveyMission()) {
		if (hasSurveyMission(player, mission->getTargetName())) {
			StringIdChatParameter stringId("mission/mission_generic", "npc_job_request_already_have");
			player->sendSystemMessage(stringId);

			return;
		}
	}*/

	missionBag->removeObject(mission);

	datapad->addObject(mission, -1, true);

	createMissionObjectives(mission, missionTerminal, player);

	player->updateToDatabaseAllObjects(false);
}

bool MissionManagerImplementation::hasSurveyMission(CreatureObject* player, const String& spawn) {
	SceneObject* datapad = player->getSlottedObject("datapad");

	int missionCount = 0;

	for (int i = 0; i < datapad->getContainerObjectsSize(); ++i) {
		SceneObject* obj = datapad->getContainerObject(i);

		if (obj->isMissionObject()) {
			MissionObject* mission = cast<MissionObject*>( obj);

			if (mission->getTargetName() == spawn)
				return true;
		}
	}

	return false;
}

void MissionManagerImplementation::createDestroyMissionObjectives(MissionObject* mission, MissionTerminal* missionTerminal, CreatureObject* player) {
	ManagedReference<DestroyMissionObjective*> objective = new DestroyMissionObjective(mission);
	objective->setLairTemplateToSpawn(mission->getTargetTemplate());

	ObjectManager::instance()->persistObject(objective, 1, "missionobjectives");

	mission->setMissionObjective(objective);
	objective->activate();
}

void MissionManagerImplementation::createDeliverMissionObjectives(MissionObject* mission, MissionTerminal* missionTerminal, CreatureObject* player) {
	ManagedReference<DeliverMissionObjective*> objective = new DeliverMissionObjective(mission);

	ObjectManager::instance()->persistObject(objective, 1, "missionobjectives");

	mission->setMissionObjective(objective);
	objective->activate();
}

void MissionManagerImplementation::createSurveyMissionObjectives(MissionObject* mission, MissionTerminal* missionTerminal, CreatureObject* player) {
	ManagedReference<SurveyMissionObjective*> objective = new SurveyMissionObjective(mission);
	objective->setEfficiency(mission->getDifficultyLevel());

	String spawnName = mission->getTargetName();

	objective->setSpawnFamily(spawnName);
	objective->setMissionGiver(missionTerminal);

	ObjectManager::instance()->persistObject(objective, 1, "missionobjectives");

	mission->setMissionObjective(objective);
	objective->activate();
}

void MissionManagerImplementation::createEntertainerMissionObjectives(MissionObject* mission, MissionTerminal* missionTerminal, CreatureObject* player) {
	ManagedReference<EntertainerMissionObjective*> objective = new EntertainerMissionObjective(mission);

	ObjectManager::instance()->persistObject(objective, 1, "missionobjectives");

	mission->setMissionObjective(objective);
	objective->activate();
}

void MissionManagerImplementation::createHuntingMissionObjectives(MissionObject* mission, MissionTerminal* missionTerminal, CreatureObject* player) {
	ManagedReference<HuntingMissionObjective*> objective = new HuntingMissionObjective(mission);

	ObjectManager::instance()->persistObject(objective, 1, "missionobjectives");

	mission->setMissionObjective(objective);
	objective->activate();
}

void MissionManagerImplementation::createReconMissionObjectives(MissionObject* mission, MissionTerminal* missionTerminal, CreatureObject* player) {
	ManagedReference<ReconMissionObjective*> objective = new ReconMissionObjective(mission);

	ObjectManager::instance()->persistObject(objective, 1, "missionobjectives");

	mission->setMissionObjective(objective);
	objective->activate();
}

void MissionManagerImplementation::createBountyMissionObjectives(MissionObject* mission, MissionTerminal* missionTerminal, CreatureObject* player) {
	uint32 templateCRC = npcObjectTemplatesToSpawn.get(System::random(npcObjectTemplatesToSpawn.size() - 1));
	SharedObjectTemplate* templateObject = TemplateManager::instance()->getTemplate(templateCRC);

	if (templateObject == NULL) {
		removeMission(mission, player);
		error("incorrect template object in createBountyMission " + String::valueOf(templateCRC));
		return;
	}

	ManagedReference<BountyMissionObjective*> objective = new BountyMissionObjective(mission);

	objective->setNpcTemplateToSpawn(templateObject);

	ObjectManager::instance()->persistObject(objective, 1, "missionobjectives");

	mission->setMissionObjective(objective);
	objective->activate();
}

void MissionManagerImplementation::createMissionObjectives(MissionObject* mission, MissionTerminal* missionTerminal, CreatureObject* player) {
	uint32 missionType = mission->getTypeCRC();

	switch (missionType) {
	case MissionObject::SURVEY: // survey
		createSurveyMissionObjectives(mission, missionTerminal, player);
		break;
	case MissionObject::DESTROY:
		createDestroyMissionObjectives(mission, missionTerminal, player);
		break;
	case MissionObject::DELIVER:
		createDeliverMissionObjectives(mission, missionTerminal, player);
		break;
	case MissionObject::HUNTING:
		createHuntingMissionObjectives(mission, missionTerminal, player);
		break;
	case MissionObject::RECON:
		createReconMissionObjectives(mission, missionTerminal, player);
		break;
	case MissionObject::BOUNTY:
		createBountyMissionObjectives(mission, missionTerminal, player);
		break;
	default:
		break;
	}
}

void MissionManagerImplementation::removeMission(MissionObject* mission, CreatureObject* player) {
	ManagedReference<MissionObject*> ref = mission;

	SceneObject* missionParent = mission->getParent();
	SceneObject* datapad = player->getSlottedObject("datapad");

	if (missionParent != datapad)
		return;

	datapad->removeObject(mission, true);
	mission->sendDestroyTo(player);

	mission->destroyObjectFromDatabase(true);
	player->updateToDatabaseAllObjects(false);
}

void MissionManagerImplementation::handleMissionAbort(MissionObject* mission, CreatureObject* player) {
	mission->abort();

	removeMission(mission, player);
}

void MissionManagerImplementation::populateMissionList(MissionTerminal* missionTerminal, CreatureObject* player, int counter) {
	SceneObject* missionBag = player->getSlottedObject("mission_bag");
	int bagSize = missionBag->getContainerObjectsSize();

	for (int i = 0; i < bagSize; ++i) {
		MissionObject* mission = cast<MissionObject*>( missionBag->getContainerObject(i));

		// TODO: make mission distribution function more like live
		if (missionTerminal->isGeneralTerminal()) {
			if (i < bagSize / 2) {
				randomizeDestroyMission(player, mission);
				if (missionTerminal->isSlicer(player))
					mission->setRewardCredits(mission->getRewardCredits() * 2);
			} else {
				randomizeDeliverMission(player, mission);
				if (missionTerminal->isSlicer(player))
					mission->setRewardCredits(mission->getRewardCredits() * 2);
			}
		} else if (missionTerminal->isArtisanTerminal()) {
			if (i < bagSize / 2) {
				randomizeSurveyMission(player, mission);
				if (missionTerminal->isSlicer(player))
					mission->setRewardCredits(mission->getRewardCredits() * 2);
			} else {
				randomizeCraftingMission(player, mission);
				if (missionTerminal->isSlicer(player))
					mission->setRewardCredits(mission->getRewardCredits() * 2);
			}
		} else if (missionTerminal->isEntertainerTerminal()) {
			// TODO: implement entertainer missions after entertainer is implemented
			/*randomizeEntertainerMission(player, mission);if (!dancing)
			if (i < bagSize / 2)
				mission->setTypeCRC(MissionObject::MUSICIAN);
			else
				mission->setTypeCRC(MissionObject::DANCER);*/
			mission->setTypeCRC(0); // missions won't show on terminals
		} else if (missionTerminal->isImperialTerminal()) {
			if (i < bagSize / 2)
				randomizeImperialDestroyMission(player, mission);
			else
				randomizeImperialDeliverMission(player, mission);
		} else if (missionTerminal->isRebelTerminal()) {
			if (i < bagSize / 2)
				randomizeRebelDestroyMission(player, mission);
			else
				randomizeRebelDeliverMission(player, mission);
		} else if (missionTerminal->isScoutTerminal()) {
			if (i < bagSize / 2)
				randomizeReconMission(player, mission);
			else
				randomizeHuntingMission(player, mission);
		} else if (missionTerminal->isBountyTerminal())
			randomizeBountyMission(player, mission);

		mission->setRefreshCounter(counter, true);
	}

	// Remove the Slicer from the List. They have recived their one time mission reward increase.
	if (missionTerminal->isSlicer(player))
		missionTerminal->removeSlicer(player);

}

void MissionManagerImplementation::randomizeDestroyMission(CreatureObject* player, MissionObject* mission) {
	/* TODO: Redo this section to use zoneName
	//String mission = "mission/mission_destroy_neutral_easy_creature_naboo";
	int zoneID = player->getZone()->getZoneID();

	uint32 templateCRC = lairObjectTemplatesToSpawn.getRandomTemplate(zoneID);

	if (templateCRC == 0) {
		mission->setTypeCRC(0);
		return;
	}

	SharedObjectTemplate* templateObject = TemplateManager::instance()->getTemplate(templateCRC);

	if (templateObject == NULL || !templateObject->isLairObjectTemplate()) {
		mission->setTypeCRC(0);
		error("incorrect template object in randomizeDestroyMission " + String::valueOf(templateCRC));
		return;
	}

	LairObjectTemplate* lairObjectTemplate = cast<LairObjectTemplate*>( templateObject);

	NameManager* nm = processor->getNameManager();

	int randTexts = System::random(34) + 1;

	mission->setMissionNumber(randTexts);

	Vector3 startPos = player->getCoordinate(System::random(1000) + 1000, (float)System::random(360));
	//mission->setMissionTarget(lairObjectTemplate->getObjectName());
	mission->setStartPlanetCRC(player->getZone()->getZoneCRC());
	mission->setStartPosition(startPos.getX(), startPos.getY(), player->getPlanetCRC());
	mission->setCreatorName(nm->makeCreatureName());

	mission->setMissionTargetName(lairObjectTemplate->getObjectName());
	mission->setTargetTemplate(lairObjectTemplate);

	// TODO: this all needs to change to be less static and use player levels
	mission->setRewardCredits(500 + System::random(500));
	mission->setMissionDifficulty(5);
	mission->setMissionTitle("mission/mission_destroy_neutral_easy_creature", "m" + String::valueOf(randTexts) + "t");
	mission->setMissionDescription("mission/mission_destroy_neutral_easy_creature", "m" + String::valueOf(randTexts) + "d");

	mission->setTypeCRC(MissionObject::DESTROY);
	*/
}

void MissionManagerImplementation::randomizeSurveyMission(CreatureObject* player, MissionObject* mission) {
	int maxLevel = 50;
	int minLevel = 50;
	long long surveySkill = player->getSkillMod("surveying");
	if (surveySkill > 30) {
		maxLevel += 10;
	}
	if (surveySkill > 50) {
		maxLevel += 10;
	}
	if (surveySkill > 70) {
		maxLevel += 10;
	}
	if (surveySkill > 90) {
		maxLevel += 10;
	}
	if (surveySkill > 100) {
		//Max mission level is 95.
		maxLevel += 5;
	}

	//Mission level used as needed concentration in increments of 5. I.e. 50, 55, 60 etc. up to 95.
	int randLevel = minLevel + 5 * System::random((maxLevel - minLevel) / 5);

	if (randLevel > maxLevel)
		randLevel = maxLevel;

	ResourceManager* manager = server->getResourceManager();

	String zoneName = player->getZone()->getZoneName();

	Vector<ManagedReference<ResourceSpawn*> > resources;

	int toolType = SurveyTool::MINERAL;

	//75 % mineral, 25 % chemical.
	if (System::random(3) == 0) {
		toolType = SurveyTool::CHEMICAL;
	}

	manager->getResourceListByType(resources, toolType, zoneName);

	ManagedReference<ResourceSpawn*> spawn = resources.get(System::random(resources.size() - 1));
	uint32 containerCRC = spawn->getContainerCRC();
	SharedObjectTemplate* templateObject = TemplateManager::instance()->getTemplate(containerCRC);

	NameManager* nm = processor->getNameManager();

	int texts = System::random(50);

	if (texts == 0)
		texts = 1;

	mission->setMissionTargetName(spawn->getFamilyName());
	mission->setTargetTemplate(templateObject);

	//Reward depending on mission level.
	mission->setRewardCredits(400 + (randLevel - minLevel) * 20 + System::random(100));

	mission->setMissionDifficulty(randLevel);
	mission->setStartPlanetCRC(zoneName.hashCode());
	mission->setStartPosition(player->getPositionX(), player->getPositionY(), player->getPlanetCRC());
	mission->setMissionTitle("mission/mission_npc_survey_neutral_easy", "m" + String::valueOf(texts) + "t");
	mission->setMissionDescription("mission/mission_npc_survey_neutral_easy", "m" + String::valueOf(texts) + "o");
	mission->setCreatorName(nm->makeCreatureName());

	mission->setTypeCRC(MissionObject::SURVEY);
}

void MissionManagerImplementation::randomizeBountyMission(CreatureObject* player, MissionObject* mission) {
	/*
	int zoneID = player->getZone()->getZoneID();

	// TODO: switch difficulties in here
	if (!player->hasSkillBox("combat_bountyhunter_novice")) {
		mission->setTypeCRC(0);
		return;
	}

	SharedObjectTemplate* templateObject = TemplateManager::instance()->getTemplate(MissionManager::UNKNOWN_TARGET);

	if (templateObject == NULL) {
		mission->setTypeCRC(0);
		error("incorrect template object in randomizeBountyMission UNKNOWN_TARGET");
		return;
	}

	NameManager* nm = processor->getNameManager();

	int randTexts = System::random(24) + 1;

	mission->setMissionNumber(randTexts);

	Vector3 startPos = player->getCoordinate(System::random(1000) + 1000, (float)System::random(360));
	mission->setStartPlanetCRC(player->getZone()->getPlanetName().hashCode());
	mission->setStartPosition(player->getPositionX(), player->getPositionY(), player->getPositionZ());
	mission->setCreatorName(nm->makeCreatureName());

	mission->setMissionTargetName("???");
	mission->setTargetTemplate(templateObject);

	mission->setRewardCredits(500 + System::random(500));
	mission->setMissionDifficulty(1);
	mission->setMissionTitle("mission/mission_bounty_neutral_easy", "m" + String::valueOf(randTexts) + "t");
	mission->setMissionDescription("mission/mission_bounty_neutral_easy", "m" + String::valueOf(randTexts) + "d");

	mission->setTypeCRC(MissionObject::BOUNTY);
	*/
}

void MissionManagerImplementation::randomizeDeliverMission(CreatureObject* player, MissionObject* mission) {
	/*
	PlanetManager* pmng = player->getZone()->getPlanetManager();
	MissionTargetMap* missionNpcs = pmng->getMissionNpcs();
	// need at least 2 NPCs to have a delivery mission
	if (missionNpcs->size() <= 1) {
		mission->setTypeCRC(0);
		return;
	}

	ManagedReference<SceneObject*> target = missionNpcs->getRandomTarget(player, 1);
	ManagedReference<SceneObject*> targetDest = missionNpcs->getRandomTarget(player, 1);

	if (target == NULL || targetDest == NULL || target == targetDest) {
		mission->setTypeCRC(0);
		return;
	}

	NameManager* nm = processor->getNameManager();

	int randTexts = System::random(29) + 1;

	mission->setMissionNumber(randTexts);
	mission->setMissionTarget(target);
	mission->setMissionTargetDest(targetDest);
	mission->setCreatorName(nm->makeCreatureName());

	mission->setStartPlanetCRC(player->getZone()->getPlanetName().hashCode());
	mission->setStartPosition(target->getPositionX(), target->getPositionY(), target->getPlanetCRC());
	mission->setEndPosition(targetDest->getPositionX(), targetDest->getPositionY(), targetDest->getPlanetCRC());

	// TODO: will need to do table lookup to get the other types of deliver missions (most are datadisk)
	mission->setMissionTargetName("Datadisc");
	mission->setTargetTemplate(TemplateManager::instance()->getTemplate(String("object/tangible/mission/mission_datadisk.iff").hashCode()));

	// TODO: this all needs to change to be less static and use distance
	mission->setRewardCredits(100 + System::random(100));
	mission->setMissionDifficulty(5);
	mission->setMissionTitle("mission/mission_deliver_neutral_easy", "m" + String::valueOf(randTexts) + "t");
	mission->setMissionDescription("mission/mission_deliver_neutral_easy", "m" + String::valueOf(randTexts) + "d");

	mission->setTypeCRC(MissionObject::DELIVER);
	*/
}

void MissionManagerImplementation::randomizeCraftingMission(CreatureObject* player, MissionObject* mission) {
	// TODO: add crafting logic (don't just overload destroy)
	/*
	 * get random low level trash schematic
	 * give player components and schematic
	 * get random NPC like deliver mission
	 * add waypoint
	 * onConversation() --
	 *   check for completed item, success if there
	 */
	//mission->setTypeCRC(MissionObject::CRAFTING);
	mission->setTypeCRC(0);
}

void MissionManagerImplementation::randomizeEntertainerMission(CreatureObject* player, MissionObject* mission) {
	/*
	PlanetManager* pmng = player->getZone()->getPlanetManager();
	MissionTargetMap* performanceLocations = pmng->getPerformanceLocations();
	if (performanceLocations->size() <= 0) {
		mission->setTypeCRC(0);
		return;
	}

	// TODO: filter by distance (get closer locations for lower difficulties)
	SceneObject* target = performanceLocations->getRandomTarget(player, 1);
	if (target == NULL || !target->isStructureObject()) {
		mission->setTypeCRC(0);
		return;
	}

	NameManager* nm = processor->getNameManager();

	bool dancing = false;
	if (System::random(1) == 0)
		dancing = true;

	String missionType = "musician";
	if (dancing)
		missionType = "dancer";

	int randTexts = System::random(49) + 1;

	mission->setMissionNumber(randTexts);
	mission->setMissionTarget(target);
	mission->setCreatorName(nm->makeCreatureName());

	mission->setStartPlanetCRC(player->getZone()->getPlanetName().hashCode());
	mission->setStartPosition(target->getPositionX(), target->getPositionY(), target->getPlanetCRC());

	// TODO: this all needs to change to be less static and use distance
	mission->setMissionTargetName("Theater");
	mission->setTargetTemplate(TemplateManager::instance()->getTemplate(String("object/building/general/mun_all_guild_theater_s01.iff").hashCode()));

	mission->setRewardCredits(100 + System::random(100));
	mission->setMissionDifficulty(5);
	mission->setMissionTitle("mission/mission_npc_" + missionType + "_neutral_easy", "m" + String::valueOf(randTexts) + "t");
	mission->setMissionDescription("mission/mission_npc_" + missionType + "_neutral_easy", "m" + String::valueOf(randTexts) + "o");

	if (!dancing)
		mission->setTypeCRC(MissionObject::MUSICIAN);
	else
		mission->setTypeCRC(MissionObject::DANCER);
	*/
}

void MissionManagerImplementation::randomizeHuntingMission(CreatureObject* player, MissionObject* mission) {
	/*
	PlanetManager* pmng = player->getZone()->getPlanetManager();

	// TODO: randomize difficulty (weighted by what?) once more missions are in the db
	HuntingTargetEntry* entry = pmng->getHuntingTargetTemplate(1);
	if (entry == NULL) {
		//System::out << "NULL Hunting entry!" << endl;
		mission->setTypeCRC(0);
		return;
	}

	mission->setTemplateStrings(entry->getPrimary(), entry->getSecondary());
	String targetTemp = entry->getPrimary();

	NameManager* nm = processor->getNameManager();

	int randTexts = System::random(7) + 1;

	mission->setMissionNumber(randTexts);
	mission->setCreatorName(nm->makeCreatureName());

	mission->setStartPlanetCRC(player->getZone()->getPlanetName().hashCode());
	mission->setStartPosition(player->getPositionX(), player->getPositionY(), player->getPlanetCRC());

	// TODO: this all needs to change to be less static and use distance
	mission->setMissionTargetName(TemplateManager::instance()->getTemplate(targetTemp.hashCode())->getObjectName());
	mission->setTargetTemplate(TemplateManager::instance()->getTemplate(targetTemp.hashCode()));

	mission->setRewardCredits(100 + System::random(100));
	mission->setMissionDifficulty(1);
	mission->setMissionTitle("mission/mission_npc_hunting_neutral_easy", "m" + String::valueOf(randTexts) + "t");
	mission->setMissionDescription("mission/mission_npc_hunting_neutral_easy", "m" + String::valueOf(randTexts) + "o");

	mission->setTypeCRC(MissionObject::HUNTING);
	*/
}

void MissionManagerImplementation::randomizeReconMission(CreatureObject* player, MissionObject* mission) {
	/*
	PlanetManager* pmng = player->getZone()->getPlanetManager();

	MissionTargetMap* reconlocs = pmng->getReconLocs();
	if (reconlocs->size() <= 0) {
		//System::out << "No recon locations!" << endl;
		mission->setTypeCRC(0);
		return;
	}

	ManagedReference<SceneObject*> target = reconlocs->getRandomTarget(player, 2);
	if (target == NULL || target->getZone() == NULL) {
		System::out << "Failed to get recon target!" << endl;
		mission->setTypeCRC(0);
		return;
	}

	mission->setMissionTarget(target);

	NameManager* nm = processor->getNameManager();

	int randTexts = System::random(24) + 1;

	mission->setMissionNumber(randTexts);
	mission->setCreatorName(nm->makeCreatureName());

	mission->setStartPlanetCRC(target->getZone()->getPlanetName().hashCode());
	mission->setStartPosition(target->getPositionX(), target->getPositionY(), target->getPlanetCRC());

	mission->setMissionTargetName(TemplateManager::instance()->getTemplate(target->getServerObjectCRC())->getObjectName());
	mission->setTargetTemplate(TemplateManager::instance()->getTemplate(target->getServerObjectCRC()));

	mission->setRewardCredits(100 + System::random(100));
	mission->setMissionDifficulty(1);
	mission->setMissionTitle("mission/mission_npc_recon_neutral_easy", "m" + String::valueOf(randTexts) + "t");
	mission->setMissionDescription("mission/mission_npc_recon_neutral_easy", "m" + String::valueOf(randTexts) + "o");

	mission->setTypeCRC(MissionObject::RECON);
	*/
}

void MissionManagerImplementation::randomizeImperialDestroyMission(CreatureObject* player, MissionObject* mission) {
	// TODO: add faction-specific targets
	randomizeDestroyMission(player, mission);
}

void MissionManagerImplementation::randomizeImperialDeliverMission(CreatureObject* player, MissionObject* mission) {
	// TODO: add faction-specific targets
	randomizeDeliverMission(player, mission);
}

void MissionManagerImplementation::randomizeRebelDestroyMission(CreatureObject* player, MissionObject* mission) {
	// TODO: add faction-specific targets
	randomizeDestroyMission(player, mission);
}

void MissionManagerImplementation::randomizeRebelDeliverMission(CreatureObject* player, MissionObject* mission) {
	// TODO: add faction-specific targets
	randomizeDeliverMission(player, mission);
}
