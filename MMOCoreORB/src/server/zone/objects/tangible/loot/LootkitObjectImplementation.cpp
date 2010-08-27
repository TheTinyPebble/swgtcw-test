/*
 * LootkitObjectImplementation.cpp
 *
 *  Created on: Apr 12, 2010
 *      Author: swgemu
 */

#include "LootkitObject.h"
#include "../TangibleObject.h"
#include "../../scene/SceneObject.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "server/zone/packets/scene/AttributeListMessage.h"
#include "../../scene/variables/CustomizationVariables.h"
#include "server/zone/ZoneServer.h"
#include "server/zone/ZoneProcessServerImplementation.h"
#include "server/zone/templates/tangible/LootkitObjectTemplate.h"

void LootkitObjectImplementation::fillAttributeList(AttributeListMessage* alm, PlayerCreature* object) {
	TangibleObjectImplementation::fillAttributeList(alm,object);

	String boolean[] = {"No","Yes"};

	StringBuffer componentAttributes;
	for (int i=0; i<attributes.size();++i) {
		componentAttributes << boolean[components.get(comps.get(i))];
		alm->insertAttribute(attributes.get(comps.get(i)), componentAttributes);
		componentAttributes.deleteAll();
	}
}

void LootkitObjectImplementation::loadTemplateData(SharedObjectTemplate* templateData) {
	TangibleObjectImplementation::loadTemplateData(templateData);

	LootkitObjectTemplate* LootkitData = dynamic_cast<LootkitObjectTemplate*>(templateData);

	components = LootkitData->getComponents();
	attributes = LootkitData->getAttributes();

	comps = LootkitData->getComps();
	reward = LootkitData->getReward();

	deleteComponents = LootkitData->getDeleteComponents();
}

PlayerCreature* LootkitObjectImplementation::getPlayer() {
	SceneObject* player = getParent()->getParent();
	if (player->isPlayerCreature()) {
		return (PlayerCreature*) player;
	} else {
		player = player->getParent();
		if (player->isPlayerCreature()) {
			return (PlayerCreature*) player;
		}
	}
	return NULL;
}

int LootkitObjectImplementation::notifyObjectInserted(SceneObject* object) {
	addToKit(object);
	return 0;
}

void LootkitObjectImplementation::addToKit(SceneObject* object) {
	uint32 crc = object->getServerObjectCRC();
	if (components.contains(crc)) {

		if (hasObjectInContainer(object->getObjectID())) {

			if (deleteComponents) {

				if (getPlayer() == NULL)
					return;

				getPlayer()->sendSystemMessage("@loot_kit:item_used");

				ManagedReference<SceneObject*> inventory = getPlayer()->getSlottedObject("inventory");
				Locker locker(object);
				Locker iLocker(inventory);
				removeObject(object, true);

				if (object->isPersistent())
					object->destroyObjectFromDatabase(true);
			}

			components.drop(crc);
			components.put(crc,true);

			createItem();
		}
	}
}

void LootkitObjectImplementation::createItem() {
	for (int i = 1; i<comps.size(); ++i) {
		if (components.get(comps.get(i)) == 0) {
			return; // Still missing pieces
		}
	}
	ManagedReference<PlayerCreature*> player = getPlayer();
	if (player != NULL) {

		getPlayer()->sendSystemMessage("@loot_kit:new_item_created");

		ManagedReference<SceneObject*> inventory = player->getSlottedObject("inventory");
		ZoneServer* zoneServer = server->getZoneServer();

		ManagedReference<SceneObject*> rewardObject = zoneServer->createObject(reward.get(System::random(reward.size()-1)),0);

		Locker clocker(inventory, player);
		rewardObject->sendTo(player, true);
		if (inventory->addObject(rewardObject, -1, true)) {
			getParent()->removeObject(_this, true);

			if (isPersistent())
				destroyObjectFromDatabase(true);
		}
	}
}

int LootkitObjectImplementation::canAddObject(SceneObject* object, String& errorDescription) {
	if (components.contains(object->getServerObjectCRC())) {

		if (!components.get(object->getServerObjectCRC()) && getPlayer() != NULL) {
			ManagedReference<SceneObject*> inventory = getPlayer()->getSlottedObject("inventory");

			if (inventory->hasFullContainerObjects()) {
				errorDescription = "@error_message:inv_full";
				return 5;
			}

			return TangibleObjectImplementation::canAddObject(object, errorDescription);

		} else {

			if (getPlayer() != NULL) {
				errorDescription = "@loot_kit:already_contains";
			}

			return 5;
		}
	}

	if (getPlayer() != NULL) {
		errorDescription = "@loot_kit:incorrect_item";
	}

	return 5;
}
