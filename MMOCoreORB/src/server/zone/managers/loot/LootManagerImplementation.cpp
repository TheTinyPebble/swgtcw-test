/*
 * LootManagerImplementation.cpp
 *
 *  Created on: Jun 20, 2011
 *      Author: Kyle
 */

#include "engine/engine.h"

#include "LootManager.h"
#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/creature/AiAgent.h"
#include "server/zone/managers/crafting/CraftingManager.h"
#include "server/zone/managers/templates/TemplateManager.h"
#include "server/zone/templates/LootItemTemplate.h"
#include "server/zone/ZoneServer.h"
#include "LootGroupMap.h"

void LootManagerImplementation::initialize() {

	lua = new Lua();
	lua->init();

	info("Loading configuration.");

	if(!loadConfigData()) {

		loadDefaultConfig();

		info("***** ERROR in configuration, using default values");
	}

	lootGroupMap = LootGroupMap::instance();
	lootGroupMap->initialize();

	info("Loaded " + String::valueOf(lootGroupMap->getTotalItems()) + " loot items.", true);
	info("Loaded " + String::valueOf(lootGroupMap->getTotalGroups()) + " loot groups.", true);

	info("Initialized.");
}

bool LootManagerImplementation::loadConfigFile() {
	return lua->runFile("scripts/managers/loot_manager.lua");
}

bool LootManagerImplementation::loadConfigData() {
	if (!loadConfigFile())
		return false;

	return true;
}

void LootManagerImplementation::loadDefaultConfig() {

}

void LootManagerImplementation::setInitialObjectStats(LootItemTemplate* templateObject, CraftingValues* craftingValues, TangibleObject* prototype) {
	int size = craftingValues->getExperimentalPropertyTitleSize();

	craftingValues->clear();

	Vector<String>* properties = templateObject->getExperimentalSubGroupTitles();
	Vector<int>* minValues = templateObject->getExperimentalMin();
	Vector<int>* maxValues = templateObject->getExperimentalMax();

	for (int i = 0; i < properties->size(); ++i) {
		String property = properties->get(i);

		craftingValues->setMinValue(property, minValues->get(i));
		craftingValues->setMaxValue(property, maxValues->get(i));

		craftingValues->setMaxPercentage(property, 1.0f);
		craftingValues->setCurrentPercentage(property, .5f);
	}

	Vector<String>* customizationData = templateObject->getCustomizationStringNames();
	Vector<Vector<int> >* customizationValues = templateObject->getCustomizationValues();

	for (int i = 0; i < customizationData->size(); ++i) {
		String customizationString = customizationData->get(i);
		Vector<int>* values = &customizationValues->get(i);

		int idx = customizationString.lastIndexOf("/");

		if (idx != -1)
			customizationString = customizationString.subString(idx + 1);

		if (values->size() > 0) {
			int randomValue = values->get(System::random(values->size() - 1));

			prototype->setCustomizationVariable(customizationString, randomValue, false);
		}
	}
}

void LootManagerImplementation::setCustomObjectName(TangibleObject* object, LootItemTemplate* templateObject) {
	String customName = templateObject->getCustomObjectName();

	if (!customName.isEmpty()) {
		if (customName.charAt(0) == '@') {
			StringId stringId(customName);

			object->setObjectName(stringId);
		} else {
			object->setCustomObjectName(customName, false);
		}
	}

}

int LootManagerImplementation::calculateLootCredits(int level) {
	int maxcredits = (int) round((.03f * level * level) + (3 * level) + 50);
	int mincredits = (int) round((((float) maxcredits) * .5f) + (2.0f * level));

	int credits = mincredits + System::random(maxcredits - mincredits);

	return credits;
}

SceneObject* LootManagerImplementation::createLootObject(LootItemTemplate* templateObject) {
	String directTemplateObject = templateObject->getDirectObjectTemplate();

	if (!directTemplateObject.isEmpty()) {
		SceneObject* newObject = zoneServer->createObject(directTemplateObject.hashCode(), 2);
		newObject->createChildObjects();

		if (newObject != NULL && newObject->isTangibleObject())
			setCustomObjectName(cast<TangibleObject*>(newObject), templateObject);

		return newObject;
	}

	ManagedReference<DraftSchematic*> draftSchematic = craftingManager->getSchematic(templateObject->getDraftSchematic().hashCode());

	if (draftSchematic == NULL) {
		error("could not create draftSchematic " + templateObject->getDraftSchematic());
		return NULL;
	}

	ManagedReference<ManufactureSchematic*> manufactureSchematic = dynamic_cast<ManufactureSchematic* >(draftSchematic->createManufactureSchematic(NULL));
	manufactureSchematic->setDraftSchematic(NULL, draftSchematic);

	ManagedReference<TangibleObject *> prototype = dynamic_cast<TangibleObject*> (zoneServer->createObject(draftSchematic->getTanoCRC(), 2));
	prototype->createChildObjects();

	CraftingValues* craftingValues = manufactureSchematic->getCraftingValues();

	prototype->setInitialCraftingValues(manufactureSchematic);
	prototype->updateCraftingValues(manufactureSchematic);

	Vector<byte>* customizationOptions = draftSchematic->getCustomizationOptions();
	Vector<byte>* customizationDefaultValues = draftSchematic->getCustomizationDefaultValues();

	for (int i = 0; i < customizationOptions->size(); ++i) {
		prototype->setCustomizationVariable(customizationOptions->get(i), customizationDefaultValues->get(i));
	}

	manufactureSchematic->setAssembled();

	manufactureSchematic->setFirstCraftingUpdateComplete();

	setInitialObjectStats(templateObject, craftingValues, prototype);

	int qualityResult = System::random(templateObject->getQualityRangeMin() - templateObject->getQualityRangeMax()) + templateObject->getQualityRangeMax();

	//info("qualityResult = " + String::valueOf(qualityResult), true);

	float modifier, newValue;

	String title, subtitle, subtitlesTitle;

	for (int i = 0; i < craftingValues->getExperimentalPropertySubtitleSize(); ++i) {
		subtitlesTitle = craftingValues->getExperimentalPropertySubtitlesTitle(i);
		subtitle = craftingValues->getExperimentalPropertySubtitle(i);
		modifier = craftingManager->calculateExperimentationValueModifier(qualityResult, 5);
		newValue = craftingValues->getCurrentPercentage(subtitle) + modifier;

		if (newValue > craftingValues->getMaxPercentage(subtitle))
			newValue = craftingValues->getMaxPercentage(subtitle);

		craftingValues->setCurrentPercentage(subtitle, newValue);
	}

	// Use percentages to recalculate the values
	craftingValues->recalculateValues(false);

	// Update the Tano with new values
	prototype->updateCraftingValues(manufactureSchematic);

	setCustomObjectName(prototype, templateObject);

	return prototype;
}

void LootManagerImplementation::createLoot(SceneObject* container, AiAgent* creature) {
	LootGroupCollection* lootGroups = creature->getLootGroups();
	int lootChance = creature->getLootChance();

	if (lootGroups == NULL || lootChance <= 0)
		return;

	//First roll is on what loot group, if any, to use.
	int roll = System::random(10000000); //100.00000% with 5 decimal precision

	if (roll > lootChance) {
		//The creature isn't dropping loot because the roll was in the "no drop" zone of the percentage.
		return;
	}

	int tempChance = 0; //Start at 0.

	//Now loop through the lootgroups to figure out which lootgroup to use.
	for (int i = 0; i < lootGroups->size(); ++i) {
		LootGroupEntry entry = lootGroups->get(i);

		tempChance += entry.getWeight();

		//Is this entry lower than the roll? If yes, then we want to try the next entry.
		if (tempChance < roll)
			continue;

		createLoot(container, entry.getItemTemplate(), creature->getLevel());

		return; //If we got here, then we found the entry we were looking for.
	}
}

void LootManagerImplementation::createLoot(SceneObject* container, const String& lootGroup, int level) {
	if (container->hasFullContainerObjects())
		return;

	Reference<LootGroup*> group = lootGroupMap->get(lootGroup);

	if (group == NULL)
		return;

	//Now we do the second roll for the item out of the group.
	int roll = System::random(10000000);

	int tempChance = 0;

	for (int i = 0; i < group->size(); ++i) {
		if (container->hasFullContainerObjects())
			return;

		LootGroupEntry entry = group->get(i);

		tempChance += entry.getWeight();

		if (tempChance < roll)
			continue; //If the roll is greater than this item, move on to the next one.

		String item = entry.getItemTemplate();

		LootItemTemplate* itemTemplate = lootGroupMap->getLootItem(item);

		if (itemTemplate != NULL) {
			//int minLevel = itemTemplate->getMinimumLevel();
			//int maxLevel = itemTemplate->getMaximumLevel();

			//if (level != -1) {
				//if (minLevel != -1 && level < minLevel)
					//continue;

				//if (maxLevel != -1 && level > maxLevel)
					//continue;
			//}

			SceneObject* obj = createLootObject(itemTemplate);

			if (obj != NULL) {
				if (container->transferObject(obj, -1, false))
					container->broadcastObject(obj, true);
			}

		} else {
			error(item + " loot item template not found");
		}

		return;
	}
}
