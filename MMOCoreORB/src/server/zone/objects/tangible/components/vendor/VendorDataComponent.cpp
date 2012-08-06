/*
 * VendorDataComponent.cpp
 *
 *  Created on: 5/29/2012
 *      Author: Kyle
 */

#include "VendorDataComponent.h"
#include "server/zone/ZoneServer.h"
#include "server/zone/managers/vendor/VendorManager.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/zone/objects/player/sui/callbacks/VendorMaintSuiCallback.h"
#include "server/zone/objects/player/sui/inputbox/SuiInputBox.h"
#include "server/chat/ChatManager.h"
#include "server/zone/objects/auction/events/UpdateVendorTask.h"
#include "server/zone/managers/auction/AuctionManager.h"
#include "server/zone/managers/player/PlayerManager.h"
#include "server/zone/packets/object/SpatialChat.h"
#include "server/zone/objects/player/Races.h"
#include "server/zone/objects/tangible/tasks/VendorReturnToPositionTask.h"

VendorDataComponent::VendorDataComponent() : AuctionTerminalDataComponent() {
	ownerId = 0;
	auctionManager = NULL;
	initialized = false;
	vendorSearchEnabled = false;
	disabled = false;
	registered = false;
	maintAmount = 0;
	awardUsageXP = 0;
	adBarking = false;
	mail1Sent = false;
	mail2Sent = false;
	barkMessage = "";
	originalDirection = 1000;
	addSerializableVariables();
}

void VendorDataComponent::addSerializableVariables() {
	addSerializableVariable("ownerId", &ownerId);
	addSerializableVariable("initialized", &initialized);
	addSerializableVariable("vendorSearchEnabled", &vendorSearchEnabled);
	addSerializableVariable("disabled", &disabled);
	addSerializableVariable("registered", &registered);
	addSerializableVariable("maintAmount", &maintAmount);
	addSerializableVariable("lastXpAward", &lastXpAward);
	addSerializableVariable("awardUsageXP", &awardUsageXP);
	addSerializableVariable("lastSuccessfulUpdate", &lastSuccessfulUpdate);
	addSerializableVariable("adBarking", &adBarking);
	addSerializableVariable("mail1Sent", &mail1Sent);
	addSerializableVariable("mail2Sent", &mail2Sent);
	addSerializableVariable("emptyTimer", &emptyTimer);
	addSerializableVariable("barkMessage", &barkMessage);
	addSerializableVariable("barkMood", &barkMood);
	addSerializableVariable("barkAnimation", &barkAnimation);
	addSerializableVariable("originalDirection", &originalDirection);
}

void VendorDataComponent::initializeTransientMembers() {

	AuctionTerminalDataComponent::initializeTransientMembers();

	lastBark = 0;

	if(parent != NULL) {

		if (isInitialized()) {
			vendorCheckTask = new UpdateVendorTask(parent);

			/// Schedule initial task
			vendorCheckTask->schedule((VENDORCHECKDELAY + System::random(VENDORCHECKINTERVAL)) * 60 * 1000);

			if(originalDirection == 1000)
				originalDirection = parent->getDirectionAngle();

			if(isRegistered() && parent->getZone() != NULL)
				parent->getZone()->registerObjectWithPlanetaryMap(parent);
		}
	}
}

void VendorDataComponent::notifyObjectDestroyingFromDatabase() {

	if(parent == NULL)
		return;

	ManagedReference<CreatureObject*> player = cast<CreatureObject*>(parent->getZoneServer()->getObject(ownerId));
	if(player == NULL)
		return;

	player->getPlayerObject()->removeVendor(parent);
}

void VendorDataComponent::runVendorUpdate() {

	if(vendorCheckTask == NULL)
		vendorCheckTask = new UpdateVendorTask(parent);

	vendorCheckTask->reschedule(1000 * 60 * VENDORCHECKINTERVAL);

	ManagedReference<CreatureObject*> owner = cast<CreatureObject*>(parent->getZoneServer()->getObject(getOwnerId()));
	ManagedReference<PlayerManager*> playerManager = parent->getZoneServer()->getPlayerManager();
	ManagedReference<TangibleObject*> vendor = cast<TangibleObject*>(parent.get());

	if (owner == NULL || !owner->isPlayerCreature() || playerManager == NULL || vendor == NULL) {
		return;
	}

	vendorBarks.removeAll();

	int now = time(0);
	int last = lastSuccessfulUpdate.getTime();
	float hoursSinceLastUpdate = now - last;
	hoursSinceLastUpdate /= 3600.f;

	float skillReduction = 1;
	if(owner->hasSkill("crafting_merchant_sales_2"))
		skillReduction = .80f;
	if(owner->hasSkill("crafting_merchant_master"))
		skillReduction = .60f;

	float regMaint = 0;

	/// 6 credits per hour to be registered
	if(registered)
		regMaint -= (6 * hoursSinceLastUpdate);

	if(maintAmount > 0)
		inactiveTimer.updateToCurrentTime();

	/// parent salaries
	maintAmount -= ((15.f * skillReduction) * hoursSinceLastUpdate) - regMaint;

	if(maintAmount < 0)
			vendor->setConditionDamage(-maintAmount, true);
	else {
		vendor->setConditionDamage(0, true);
		vendor->setMaxCondition(1000, true);
	}

	if(isEmpty()) {

		ManagedReference<ChatManager*> cman = parent->getZoneServer()->getChatManager();

		String sender = parent->getDisplayedName();
		UnicodeString subject("@auction:vendor_status_subject");

		if(!mail1Sent && time(0) - emptyTimer.getTime() > FIRSTWARNING) {
			StringIdChatParameter body("@auction:vendor_status_unaccessed");
			body.setTO(parent->getDisplayedName());
			cman->sendMail(sender, subject, body, owner->getFirstName());
			mail1Sent = true;
		}

		if(!mail2Sent && time(0) - emptyTimer.getTime() > SECONDWARNING) {
			StringIdChatParameter body("@auction:vendor_status_endangered");
			body.setTO(parent->getDisplayedName());
			cman->sendMail(sender, subject, body, owner->getFirstName());
			mail2Sent = true;
		}

		if(time(0) - emptyTimer.getTime() > EMPTYDELETE) {
			StringIdChatParameter body("@auction:vendor_status_deleted");
			cman->sendMail(sender, subject, body, owner->getFirstName());
			VendorManager::instance()->destroyVendor(parent);
			vendorCheckTask->cancel();
			return;
		}
	}

	if(isOnStrike()) {

		if(time(0) - inactiveTimer.getTime() > DELETEWARNING) {

			ManagedReference<ChatManager*> cman = parent->getZoneServer()->getChatManager();

			String sender = parent->getDisplayedName();
			UnicodeString subject("@auction:vendor_status_subject");

			StringIdChatParameter body("@auction:vendor_status_deleted");
			cman->sendMail(sender, subject, body, owner->getFirstName());
			VendorManager::instance()->destroyVendor(parent);
			vendorCheckTask->cancel();
		}

	} else {

		/// Award hourly XP
		Locker locker(owner);
		playerManager->awardExperience(owner, "merchant", 150 * hoursSinceLastUpdate, false);

		playerManager->awardExperience(owner, "merchant", awardUsageXP * 50, false);

	}

	awardUsageXP = 0;
	lastSuccessfulUpdate.updateToCurrentTime();
}

void VendorDataComponent::payMaintanence() {

	ManagedReference<CreatureObject*> owner = cast<CreatureObject*>(parent->getZoneServer()->getObject(getOwnerId()));
	if(owner == NULL)
		return;

	ManagedReference<SuiInputBox*> input = new SuiInputBox(owner, SuiWindowType::STRUCTURE_VENDOR_PAY);
	input->setPromptTitle("@player_structure:pay_vendor_t"); //Add Militia Member
	input->setPromptText("@player_structure:pay_vendor_d");
	input->setUsingObject(parent);
	input->setForceCloseDistance(5.f);
	input->setCallback(new VendorMaintSuiCallback(parent->getZoneServer()));

	owner->getPlayerObject()->addSuiBox(input);
	owner->sendMessage(input->generateMessage());

}

void VendorDataComponent::handlePayMaintanence(int value) {

	ManagedReference<CreatureObject*> owner = cast<CreatureObject*>(parent->getZoneServer()->getObject(getOwnerId()));
	if(owner == NULL)
		return;

	if(value > 100000) {
		owner->sendSystemMessage("@player_structure:vendor_maint_invalid");
		return;
	}

	if(value <= 0) {
		owner->sendSystemMessage("@player_structure:amt_greater_than_zero");
		return;
	}

	if(owner->getBankCredits() + owner->getCashCredits() >= value) {
		maintAmount += value;

		if(owner->getBankCredits() > value) {
			owner->subtractBankCredits(value);
		} else {
			owner->subtractCashCredits(value - owner->getBankCredits());
			owner->subtractBankCredits(owner->getBankCredits());
		}

		StringIdChatParameter message("@player_structure:vendor_maint_accepted");
		message.setDI(maintAmount);
		owner->sendSystemMessage(message);

	} else {
		owner->sendSystemMessage("@player_structure:vendor_maint_denied");
	}
}

void VendorDataComponent::withdrawMaintanence() {

	ManagedReference<CreatureObject*> owner = cast<CreatureObject*>(parent->getZoneServer()->getObject(getOwnerId()));
	if(owner == NULL)
		return;

	ManagedReference<SuiInputBox*> input = new SuiInputBox(owner, SuiWindowType::STRUCTURE_VENDOR_WITHDRAW);
	input->setPromptTitle("@player_structure:withdraw_vendor_t"); //Add Militia Member
	input->setPromptText("@player_structure:withdraw_vendor_d");
	input->setUsingObject(parent);
	input->setForceCloseDistance(5.f);
	input->setCallback(new VendorMaintSuiCallback(parent->getZoneServer()));

	owner->getPlayerObject()->addSuiBox(input);
	owner->sendMessage(input->generateMessage());

}

void VendorDataComponent::handleWithdrawMaintanence(int value) {
	ManagedReference<CreatureObject*> owner = cast<CreatureObject*>(parent->getZoneServer()->getObject(getOwnerId()));
	if(owner == NULL)
		return;

	if(value > maintAmount) {
		owner->sendSystemMessage("@player_structure:vendor_withdraw_fail");
		return;
	}

	if(value <= 0) {
		owner->sendSystemMessage("@player_structure:amt_greater_than_zero");
		return;
	}

	maintAmount -= value;
	owner->addBankCredits(value, true);

	StringIdChatParameter message("@player_stucture:vendor_withdraw");
	message.setDI(maintAmount);
	owner->sendSystemMessage(message);
}

void VendorDataComponent::setVendorSearchEnabled(bool enabled) {

	if(parent == NULL || parent->getZone() == NULL)
		return;

	vendorSearchEnabled = enabled;
	auctionManager->updateVendorSearch(parent, vendorSearchEnabled);
}


void VendorDataComponent::performVendorBark(SceneObject* target) {

	if(isOnStrike()) {
		return;
	}

	ManagedReference<CreatureObject*> vendor = cast<CreatureObject*>(parent.get());
	if(vendor == NULL)
		return;

	ManagedReference<CreatureObject*> player = cast<CreatureObject*>(target);
	if(target == NULL || !target->isPlayerCreature())
		return;

	lastBark = time(0);

	vendor->faceObject(target);
	vendor->updateDirection(vendor->getDirectionAngle());

	SpatialChat* chatMessage = NULL;

	if(barkMessage.beginsWith("@")) {
		StringIdChatParameter message;
		message.setStringId(barkMessage);
		message.setTT(player->getObjectID());
		chatMessage = new SpatialChat(vendor->getObjectID(), target->getObjectID(), message, target->getObjectID(), Races::getMoodID(barkMood), 0);

	} else {
		UnicodeString uniMessage(barkMessage);
		chatMessage = new SpatialChat(vendor->getObjectID(), target->getObjectID(), uniMessage, target->getObjectID(), Races::getMoodID(barkMood), 0, 0);
	}

	vendor->broadcastMessage(chatMessage, true);
	vendor->doAnimation(barkAnimation);

	addBarkTarget(target);

	Reference<VendorReturnToPositionTask*> returnTask = new VendorReturnToPositionTask(vendor, originalDirection);
	vendor->addPendingTask("vendorreturn", returnTask, 3000);
}
