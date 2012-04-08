/*
 * ImageDesignSessionImplementation.cpp
 *
 *  Created on: Feb 2, 2011
 *      Author: Polonel
 */

#include "engine/engine.h"
#include "ImageDesignSession.h"
#include "server/zone/ZoneServer.h"
#include "server/zone/packets/object/ImageDesignMessage.h"
#include "server/zone/packets/object/ImageDesignRejectMessageCallback.h"
#include "server/zone/managers/skill/SkillManager.h"
#include "server/zone/managers/skill/imagedesign/ImageDesignManager.h"
#include "server/zone/managers/player/PlayerManager.h"
#include "server/zone/objects/scene/variables/CustomizationVariables.h"
#include "server/zone/ZoneServer.h"

#include "server/zone/objects/player/events/ImageDesignTimeoutEvent.h"

void ImageDesignSessionImplementation::initializeTransientMembers() {
	FacadeImplementation::initializeTransientMembers();

	if (idTimeoutEvent == NULL) {
		idTimeoutEvent = new ImageDesignTimeoutEvent(_this);
		idTimeoutEvent->schedule(1000);
	} else {
		idTimeoutEvent->reschedule(1000);
	}
}

void ImageDesignSessionImplementation::startImageDesign(CreatureObject* designer, CreatureObject* targetPlayer) {
	uint64 tentID = 0; // Equals False, that controls if you can stat migrate or not (only in a Salon).

	ManagedReference<SceneObject*> obj = designer->getParentRecursively(SceneObjectType::SALONBUILDING);

	if (obj != NULL) // If they are in a salon, enable the tickmark for stat migration.
		tentID = obj->getObjectID();

	designer->addActiveSession(SessionFacadeType::IMAGEDESIGN, _this);

	String hairTemplate;

	TangibleObject* targetHair = dynamic_cast<TangibleObject*>(targetPlayer->getSlottedObject("hair"));

	ImageDesignStartMessage* msg = new ImageDesignStartMessage(designer, designer, targetPlayer, tentID, hairTemplate);
	designer->sendMessage(msg);

	if (designer != targetPlayer) {
		targetPlayer->addActiveSession(SessionFacadeType::IMAGEDESIGN, _this);

		ImageDesignStartMessage* msg2 = new ImageDesignStartMessage(targetPlayer, designer, targetPlayer, tentID, hairTemplate);
		targetPlayer->sendMessage(msg2);
	}

	designerCreature = designer;
	targetCreature = targetPlayer;

	idTimeoutEvent = new ImageDesignTimeoutEvent(_this);
}

void ImageDesignSessionImplementation::updateImageDesign(CreatureObject* updater, uint64 designer, uint64 targetPlayer, uint64 tent, int type, const ImageDesignData& data) {
	ManagedReference<SceneObject*> strongReferenceTarget = targetCreature.get();
	ManagedReference<SceneObject*> strongReferenceDesigner = designerCreature.get();

	if (strongReferenceTarget == NULL || strongReferenceDesigner == NULL)
		return;

	Locker locker(designerCreature);
	Locker clocker(targetCreature, designerCreature);

	imageDesignData = data;

	CreatureObject* targetObject = NULL;

	if (updater == designerCreature)
		targetObject = targetCreature;
	else
		targetObject = designerCreature;

	ImageDesignChangeMessage* message = new ImageDesignChangeMessage(targetObject->getObjectID(), designer, targetPlayer, tent, type);

	imageDesignData.insertToMessage(message);

	bool commitChanges = false;

	if (imageDesignData.isAcceptedByDesigner()) {
		commitChanges = true;

		if (designerCreature != targetCreature && !imageDesignData.isAcceptedByTarget()) {
			commitChanges = false;

			if (!idTimeoutEvent->isScheduled())
				idTimeoutEvent->schedule(120000); //2 minutes
		} else {
			commitChanges = doPayment();
		}
	}

	//System::out << h << endl;
	if (commitChanges) {
		//TODO: set XP Values

		int xpGranted = 50; // Minimum Image Design XP granted (base amount).

		String hairTemplate = imageDesignData.getHairTemplate();

		VectorMap<String, float>* bodyAttributes = imageDesignData.getBodyAttributesMap();
		VectorMap<String, uint32>* colorAttributes = imageDesignData.getColorAttributesMap();

		imageDesignManager = designerCreature->getZoneServer()->getSkillManager()->getImageDesignManager();

		if (type == 1)
			hairObject = imageDesignManager->createHairObject(designerCreature, targetCreature, imageDesignData.getHairTemplate(), imageDesignData.getHairCustomizationString());
		else
			hairObject = dynamic_cast<TangibleObject*>(targetCreature->getSlottedObject("hair"));

		for (int i = 0; i < bodyAttributes->size(); ++i) {
			VectorMapEntry<String, float>* entry = &bodyAttributes->elementAt(i);
			imageDesignManager->updateCustomization(designerCreature, entry->getKey(), entry->getValue(), targetCreature);
			xpGranted += 25;
		}

		for (int i = 0; i < colorAttributes->size(); ++i) {
			VectorMapEntry<String, uint32>* entry = &colorAttributes->elementAt(i);
			imageDesignManager->updateColorCustomization(designerCreature, entry->getKey(), entry->getValue(), hairObject, targetCreature);
			xpGranted += 25;
		}

		imageDesignManager->updateHairObject(targetCreature, hairObject);

		// Drop the Session for both the designer and the targetCreature;
		designerCreature->dropActiveSession(SessionFacadeType::IMAGEDESIGN);
		targetCreature->dropActiveSession(SessionFacadeType::IMAGEDESIGN);

		// Award XP.
		PlayerManager* playerManager = designerCreature->getZoneServer()->getPlayerManager();

		if (playerManager != NULL && designerCreature != targetCreature)
			playerManager->awardExperience(designerCreature, "imagedesigner", xpGranted, true);

		if (idTimeoutEvent->isScheduled())
			dequeueIdTimeoutEvent();
	}

	targetObject->sendMessage(message);
}

int ImageDesignSessionImplementation::doPayment() {
	int targetCash = targetCreature->getCashCredits();

	uint32 requiredPayment = imageDesignData.getRequiredPayment();

	// The client should pervent this, but in case it doesn't
	if (targetCash < requiredPayment) {
		targetCreature->sendSystemMessage("You do not have enough cash to pay the required payment.");
		designerCreature->sendSystemMessage("Target does not have enough cash for the required payment.");

		cancelSession();

		return 0;
	}

	targetCreature->subtractCashCredits(requiredPayment);
	designerCreature->addCashCredits(requiredPayment);

	return 1;

}

void ImageDesignSessionImplementation::cancelImageDesign(uint64 designer, uint64 targetPlayer, uint64 tent, int type, const ImageDesignData& data) {
	if (targetCreature == NULL || designerCreature == NULL)
		return;

	Locker locker(designerCreature);
	Locker clocker(targetCreature, designerCreature);

	imageDesignData = data;

	ImageDesignRejectMessage* message = new ImageDesignRejectMessage(targetCreature->getObjectID(), designer, targetPlayer,tent, type);
	imageDesignData.insertToMessage(message);
	targetCreature->sendMessage(message);

	ImageDesignRejectMessage* msg2 = new ImageDesignRejectMessage(designerCreature->getObjectID(), designer, targetPlayer,tent, type);
	imageDesignData.insertToMessage(msg2);
	designerCreature->sendMessage(msg2);


	//TODO: Needs research.

	cancelSession();
}
