/*
 * InstallationObjectImplementation.cpp
 *
 *  Created on: Jun 4, 2010
 *      Author: kyle
 */

#include "FactoryObject.h"
#include "tasks/CreateFactoryObjectTask.h"

#include "server/zone/managers/resource/ResourceManager.h"
#include "server/chat/ChatManager.h"

#include "server/zone/packets/installation/InstallationObjectMessage3.h"
#include "server/zone/packets/installation/InstallationObjectDeltaMessage3.h"
#include "server/zone/packets/installation/InstallationObjectDeltaMessage7.h"
#include "server/zone/packets/installation/InstallationObjectMessage6.h"
#include "server/zone/packets/manufactureschematic/ManufactureSchematicObjectDeltaMessage3.h"
#include "server/zone/packets/factory/FactoryCrateObjectDeltaMessage3.h"
#include "server/zone/packets/resource/ResourceContainerObjectDeltaMessage3.h"
#include "server/zone/packets/tangible/TangibleObjectDeltaMessage3.h"
#include "server/zone/packets/factory/FactoryCrateObjectDeltaMessage3.h"

#include "server/zone/packets/chat/ChatSystemMessage.h"

#include "server/zone/packets/object/ObjectMenuResponse.h"
#include "server/zone/objects/player/sui/listbox/SuiListBox.h"
#include "server/zone/objects/player/sui/inputbox/SuiInputBox.h"
#include "server/zone/objects/player/sui/transferbox/SuiTransferBox.h"

#include "server/zone/objects/resource/ResourceSpawn.h"
#include "server/zone/objects/resource/ResourceContainer.h"
#include "server/zone/Zone.h"

#include "server/zone/objects/manufactureschematic/ManufactureSchematic.h"
#include "server/zone/objects/factorycrate/FactoryCrate.h"

#include "server/zone/templates/installation/FactoryObjectTemplate.h"

void FactoryObjectImplementation::loadTemplateData(SharedObjectTemplate* templateData) {
	InstallationObjectImplementation::loadTemplateData(templateData);

	FactoryObjectTemplate* factory = dynamic_cast<FactoryObjectTemplate*>(templateData);

	craftingTabsSupported = factory->getCraftingTabsSupported();
}

void FactoryObjectImplementation::initializeTransientMembers() {
	InstallationObjectImplementation::initializeTransientMembers();

	/*if(operating)
		startFactory();*/

	setLoggingName("FactoryObject");
}

void FactoryObjectImplementation::createChildObjects() {

	String ingredientHopperName = "object/tangible/hopper/manufacture_installation_ingredient_hopper_1.iff";
	ManagedReference<SceneObject*> ingredientHopper = server->getZoneServer()->createObject(ingredientHopperName.hashCode(), 1);

	addObject(ingredientHopper, 4);

	String outputHopperName = "object/tangible/hopper/manufacture_installation_output_hopper_1.iff";
	ManagedReference<SceneObject*> outputHopper = server->getZoneServer()->createObject(outputHopperName.hashCode(), 1);

	addObject(outputHopper, 4);
}

void FactoryObjectImplementation::fillAttributeList(AttributeListMessage* alm, PlayerCreature* object) {
	InstallationObjectImplementation::fillAttributeList(alm, object);

	if (operating && isOnAdminList(object)) {
		ManagedReference<SceneObject*> outputHopper = getSlottedObject("output_hopper");

		if (outputHopper != NULL) {
			alm->insertAttribute("manufacture_count", outputHopper->getContainerObjectsSize()); //Manufactured Items:
		}
	}
}

void FactoryObjectImplementation::fillObjectMenuResponse(ObjectMenuResponse* menuResponse, PlayerCreature* player) {
	if (!isOnAdminList(player))
		return;

	InstallationObjectImplementation::fillObjectMenuResponse(menuResponse, player);


	menuResponse->addRadialMenuItem(29, 3, "@manf_station:options"); //Options

	if(getContainerObjectsSize() > 0) {
		if(!operating)
			menuResponse->addRadialMenuItemToRadialID(29, 69, 3, "@manf_station:activate"); //Start manufacturing objects.
		else
			menuResponse->addRadialMenuItemToRadialID(29, 69, 3, "@manf_station:deactivate"); //Stop manufacturing objects.

		if(!operating)
			menuResponse->addRadialMenuItemToRadialID(29, 68, 3, "@manf_station:ingredients"); //List ingredients needed for station
	}

	if(!operating) {
		menuResponse->addRadialMenuItemToRadialID(29, 197, 3, "@manf_station:schematic"); //Access schematic slot.
		menuResponse->addRadialMenuItemToRadialID(29, 195, 3, "@manf_station:input_hopper"); //Access station ingredient hopper
		menuResponse->addRadialMenuItemToRadialID(29, 196, 3, "@manf_station:output_hopper"); //Access station output hopper
	}
}

int FactoryObjectImplementation::handleObjectMenuSelect(PlayerCreature* player, byte selectedID) {
	if (!isOnAdminList(player))
		return 1;

	switch (selectedID) {
	case 195: /// Send ingredient Hopper
		sendIngredientHopper(player);
		break;
	case 29:
	case 196: /// Send output Hopper
		sendOutputHopper(player);
		break;
	case 197: /// Schematic Slot
		sendInsertManuSui(player);
		break;
	case 68: /// Send ingredients list
		sendIngredientsNeededSui(player);
		break;
	case 69: /// Send schematic requirements
		handleOperateToggle(player);
		break;

	default:
		InstallationObjectImplementation::handleObjectMenuSelect(player, selectedID);
	}

	return 0;
}

/*
 * Opens a SUI with all manufacturing schematics available for the player to insert into factory
 */
void FactoryObjectImplementation::sendInsertManuSui(PlayerCreature* player){

	ManagedReference<SuiListBox*> schematics = NULL;
	if(getContainerObjectsSize() == 0) {
		schematics = new SuiListBox(player, SuiWindowType::FACTORY_SCHEMATIC2BUTTON, SuiListBox::HANDLETWOBUTTON);
		schematics->setPromptText("Choose a schematic to be added to the factory.");
	} else {

		schematics = new SuiListBox(player, SuiWindowType::FACTORY_SCHEMATIC3BUTTON, SuiListBox::HANDLETHREEBUTTON);

		StringBuffer message;
		message << "Current Schematic Installed: ";

		if(getContainerObject(0)->getCustomObjectName().isEmpty())
			message << "@" << getContainerObject(0)->getObjectNameStringIdFile() << ":" << getContainerObject(0)->getObjectNameStringIdName();
		else
			message << getContainerObject(0)->getCustomObjectName().toString();

		schematics->setPromptText(message.toString());

		schematics->setOtherButton(true, "@remove_schematic");
	}

	schematics->setHandlerText("handleUpdateSchematic");
	schematics->setPromptTitle("SCHEMATIC MANAGEMENT");//found a SS with this as the title so...

	schematics->setOkButton(true, "@use_schematic");
	schematics->setCancelButton(true, "@cancel");

	/*
	 * Insert only the schematics that can be used in this type of factory
	 */
	ManagedReference<SceneObject* > datapad = player->getSlottedObject("datapad");

	for (int i = 0; i < datapad->getContainerObjectsSize(); ++i) {

		ManagedReference<SceneObject* > datapadObject = datapad->getContainerObject(i);

		if (datapadObject != NULL && datapadObject->isManufactureSchematic()) {

			ManagedReference<ManufactureSchematic* > manSchem = dynamic_cast<ManufactureSchematic*>(datapadObject.get());

			 if (manSchem->getDraftSchematic() == NULL)
				 continue;

			uint32 craftingTabId = manSchem->getDraftSchematic()->getToolTab();

			bool match = false;

			for(int j = 0; j < craftingTabsSupported.size(); ++j) {

				if(craftingTabId == craftingTabsSupported.get(j)) {
					match = true;
					break;
				}
			}

			if(!match)
				continue;

			String sendname;

			if(manSchem->getCustomObjectName().isEmpty())
				sendname = "@" + manSchem->getObjectNameStringIdFile() + ":" + manSchem->getObjectNameStringIdName();
			else
				sendname = manSchem->getCustomObjectName().toString();

			schematics->addMenuItem(sendname, manSchem->getObjectID());
		}
	}

	schematics->setUsingObject(_this);
	player->addSuiBox(schematics);
	player->sendMessage(schematics->generateMessage());
}

void FactoryObjectImplementation::updateInstallationWork() {
	Time timeToWorkTill;
	bool shutdownAfterWork = updateMaintenance(timeToWorkTill);

	if(shutdownAfterWork)
		stopFactory("", "", "", -1);
}
/*
 * Opens a SUI with all manufacturing schematics available for the player to insert into factory
 */
void FactoryObjectImplementation::sendIngredientsNeededSui(PlayerCreature* player) {

	if(getContainerObjectsSize() == 0)
		return;

	ManagedReference<SuiListBox*> ingredientList = new SuiListBox(player, SuiWindowType::FACTORY_INGREDIENTS);
	ingredientList->setPromptTitle("@base_player:swg"); //STAR WARS GALAXIES - found a SS with this as the title so....

	ingredientList->setPromptText("@manf_station:examine_prompt"); //Ingredients required to manufacture an item at this station.

	ingredientList->setOkButton(true, "@ok");

	/// List Ingredients
	ManagedReference<ManufactureSchematic* > schematic = dynamic_cast<ManufactureSchematic*>(getContainerObject(0));

	for (int i = 0; i < schematic->getFactoryIngredientsSize(); ++i) {

		ManagedReference<SceneObject* > ingredient = dynamic_cast<SceneObject*>(schematic->getFactoryIngredient(i));

		if (ingredient == NULL)
			continue;

		if (ingredient->isResourceContainer()) {
			ManagedReference<ResourceContainer*> rcno = (ResourceContainer*) ingredient.get();

			String sendstring = rcno->getSpawnObject()->getName() + ":\\>200" + rcno->getQuantity();

			ingredientList->addMenuItem(sendstring, 0);

		} else {

			ManagedReference<TangibleObject*> component = dynamic_cast<TangibleObject*>(ingredient.get());

			String sendstring;

			if (component->getCustomObjectName().isEmpty())
				sendstring = "@" + component->getObjectNameStringIdFile() + ":"
					+ component->getObjectNameStringIdName() + " ";
			else
				sendstring = component->getCustomObjectName().toString();

			sendstring += component->getCraftersSerial() + ":\\>200" + component->getUseCount();

			ingredientList->addMenuItem(sendstring, 0);
		}
	}

	ingredientList->setUsingObject(_this);
	player->addSuiBox(ingredientList);
	player->sendMessage(ingredientList->generateMessage());

}

void FactoryObjectImplementation::sendIngredientHopper(PlayerCreature* player) {

	ManagedReference<SceneObject*> inputHopper = getSlottedObject("ingredient_hopper");

	if(inputHopper == NULL) {
		return;
	}

	inputHopper->sendTo(player, true);
	inputHopper->openContainerTo(player);
}

void FactoryObjectImplementation::sendOutputHopper(PlayerCreature* player) {

	ManagedReference<SceneObject*> outputHopper = getSlottedObject("output_hopper");

	if(outputHopper == NULL) {
		return;
	}

	outputHopper->sendTo(player, true);
	outputHopper->openContainerTo(player);
}

void FactoryObjectImplementation::handleInsertFactorySchem(
		PlayerCreature* player, ManufactureSchematic* schematic) {

	if (schematic == NULL)
		return;

	/// pre: player and _this are locked
	if (!schematic->isManufactureSchematic()) {
		StringIdChatParameter message("manf_station", "schematic_not_added"); //Schematic %TT was not added to the station.

		if(schematic->getCustomObjectName().isEmpty())
			message.setTT(schematic->getObjectNameStringIdFile(), schematic->getObjectNameStringIdName());
		else
			message.setTT(schematic->getCustomObjectName().toString());

		player->sendSystemMessage(message);

		return;
	}

	ManagedReference<SceneObject*> datapad = player->getSlottedObject("datapad");

	datapad->removeObject(schematic, true);

	datapad->updateToDatabase();

	addObject(schematic, -1, true);
	updateToDatabase();

	StringIdChatParameter message("manf_station", "schematic_added"); //Schematic %TT has been inserted into the station. The station is now ready to manufacture items.

	if(schematic->getCustomObjectName().isEmpty())
		message.setTT(schematic->getObjectNameStringIdFile(), schematic->getObjectNameStringIdName());
	else
		message.setTT(schematic->getCustomObjectName().toString());

	player->sendSystemMessage(message);
}

void FactoryObjectImplementation::handleRemoveFactorySchem(PlayerCreature* player) {

	/// pre: player and _this are locked

	if(getContainerObjectsSize() == 0) {
		return;
	}

	ManagedReference<SceneObject*> datapad = player->getSlottedObject("datapad");

	ManagedReference<SceneObject*> schematic = getContainerObject(0);
	removeObject(schematic);

	if(!schematic->isManufactureSchematic())
		return;

	datapad->addObject(schematic, -1, true);
	datapad->broadcastObject(schematic, true);
	datapad->updateToDatabase();

	updateToDatabase();

	StringIdChatParameter message("manf_station", "schematic_removed"); //Schematic %TT has been removed from the station and been placed in your datapad. Have a nice day!

	if(schematic->getCustomObjectName().isEmpty())
		message.setTT(schematic->getObjectNameStringIdFile(), getContainerObject(0)->getObjectNameStringIdName());
	else
		message.setTT(schematic->getCustomObjectName().toString());

	player->sendSystemMessage(message);
}

void FactoryObjectImplementation::handleOperateToggle(PlayerCreature* player) {

	if(!operating) {
		currentUserName = player->getFirstName();
		currentRunCount = 0;
		startFactory();
		player->sendSystemMessage("manf_station", "activated"); //Station activated
	} else {

		stopFactory("manf_done", getObjectName()->getDisplayedName(), "", currentRunCount);
		player->sendSystemMessage("manf_station", "deactivated"); //Station deactivated
		currentUserName = "";
	}
}

void FactoryObjectImplementation::startFactory() {
	if (getContainerObjectsSize() == 0) {
		return;
	}

	Locker _locker(_this);

	operating = true;

	timer = (int)(dynamic_cast<ManufactureSchematic*>(getContainerObject(0)))->getComplexity() * 2;

	// Add sampletask
	Reference<CreateFactoryObjectTask* > createFactoryObjectTask = new CreateFactoryObjectTask(_this);
	addPendingTask("createFactoryObject", createFactoryObjectTask);

	createFactoryObjectTask->schedule(timer * 1000);

	updateToDatabase();
}

void FactoryObjectImplementation::stopFactory(const String& message, const String& tt, const String& to, const int di) {

	Locker _locker(_this);

	operating = false;
	Reference<Task* > pending = getPendingTask("createFactoryObject");
	removePendingTask("createFactoryObject");

	if(pending != NULL && pending->isScheduled())
		pending->cancel();

	//Send out email informing them why their factory stopped
	ManagedReference<ChatManager*> chatManager = server->getChatManager();

	if (chatManager != NULL && currentUserName != "") {
		StringIdChatParameter emailBody;
		emailBody.setStringId("@system_msg:" + message);
		if(tt != "")
			emailBody.setTT(tt);
		if(to != "")
			emailBody.setTO(to);
		if(di != -1)
			emailBody.setDI(di);
		UnicodeString subject = "@system_msg:manf_done_sub";
		chatManager->sendMail(getObjectName()->getDisplayedName(), subject, emailBody, currentUserName);
	}

	updateToDatabase();
}

void FactoryObjectImplementation::stopFactory(TangibleObject* ingredient) {

	if(ingredient->isResourceContainer()) {

		ResourceContainer* rcnoObject = (ResourceContainer*) ingredient;

		if(rcnoObject->getSpawnName() == "")
			stopFactory("manf_no_unknown_resource", getObjectName()->getDisplayedName(), "", -1);
		else
			stopFactory("manf_no_named_resource", getObjectName()->getDisplayedName(), rcnoObject->getSpawnName(), -1);

	} else {

		if(ingredient->getCustomObjectName().toString() == "")
			stopFactory("manf_no_component", getObjectName()->getDisplayedName(), ingredient->getObjectName()->getDisplayedName(), -1);
		else
			stopFactory("manf_no_component", getObjectName()->getDisplayedName(), ingredient->getCustomObjectName().toString(), -1);
	}
}

void FactoryObjectImplementation::createNewObject() {

	/// Pre: _this locked
	if (getContainerObjectsSize() == 0) {
		stopFactory("manf_error", "", "", -1);
		return;
	}

	ManagedReference<ManufactureSchematic*> schematic =
			dynamic_cast<ManufactureSchematic*>(getContainerObject(0));

	if (schematic == NULL) {
		stopFactory("manf_error_4", "", "", -1);
		return;
	}

	ManagedReference<TangibleObject*> prototype =
			dynamic_cast<TangibleObject*>(schematic->getPrototype());

	if (prototype == NULL) {
		stopFactory("manf_error_2", "", "", -1);
		return;
	}

	try {

		if (removeIngredientsFromHopper(schematic)) {

			ManagedReference<FactoryCrate*> crate = locateCrateInOutputHopper(prototype);

			if (crate == NULL)
				crate = createNewFactoryCrate(prototype);
			else
				crate->setUseCount(crate->getUseCount() + 1);

			currentRunCount++;

			if (crate == NULL) {
				stopFactory("manf_error_7", "", "", -1);
				return;
			}

			Locker locker(crate);

			Reference<Task*> pending = getPendingTask("createFactoryObject");

			schematic->setManufactureLimit(schematic->getManufactureLimit() - 1);

			if(schematic->getManufactureLimit() == 0) {

				removeObject(schematic);
				stopFactory("manf_done", getObjectName()->getDisplayedName(), "", currentRunCount);

			} else if (pending != NULL)
				pending->reschedule(timer * 1000);
			else
				stopFactory("manf_error", "", "", -1);

		}

		updateToDatabase();
	} catch (...) {
		error("unhandled exception in FactoryObjectImplementation::createNewObject()");
	}
}

FactoryCrate* FactoryObjectImplementation::locateCrateInOutputHopper(TangibleObject* prototype) {

	ManagedReference<SceneObject*> outputHopper = getSlottedObject("output_hopper");

	if(outputHopper == NULL || prototype == NULL) {
		stopFactory("manf_error_6", "", "", -1);
		return false;
	}

	for (int i = 0; i < outputHopper->getContainerObjectsSize(); ++i) {

		ManagedReference<SceneObject* > object = outputHopper->getContainerObject(i);

		if(object == NULL || !object->isFactoryCrate())
			continue;

		FactoryCrate* crate = (FactoryCrate*) object.get();

		if(crate->getPrototype() != NULL && crate->getPrototype()->getCraftersSerial() ==
				prototype->getCraftersSerial() && crate->getUseCount() < FactoryCrate::MAXCAPACITY) {

			return crate;
		}

	}
	return NULL;
}

FactoryCrate* FactoryObjectImplementation::createNewFactoryCrate(TangibleObject* prototype) {

	String file;
	uint32 type = prototype->getGameObjectType();

	if(type & SceneObject::ARMOR)
		file = "object/factory/factory_crate_armor.iff";
	else if(type == SceneObject::CHEMICAL || type == SceneObject::PHARMACEUTICAL || type == SceneObject::PETMEDECINE)
		file = "object/factory/factory_crate_chemicals.iff";
	else if(type & SceneObject::CLOTHING)
		file = "object/factory/factory_crate_clothing.iff";
	else if(type == SceneObject::ELECTRONICS)
		file = "object/factory/factory_crate_electronics.iff";
	else if(type == SceneObject::FOOD || type == SceneObject::DRINK)
		file = "object/factory/factory_crate_food.iff";
	else if(type == SceneObject::FURNITURE)
		file = "object/factory/factory_crate_furniture.iff";
	else if(type & SceneObject::INSTALLATION)
		file = "object/factory/factory_crate_installation.iff";
	else if(type & SceneObject::WEAPON)
		file = "object/factory/factory_crate_weapon.iff";
	else
		file = "object/factory/factory_crate_generic_items.iff";

	ObjectManager* objectManager = ObjectManager::instance();

	FactoryCrate* crate = dynamic_cast<FactoryCrate*>(server->getZoneServer()->createObject(file.hashCode(), 2));

	if (crate == NULL) {
		stopFactory("manf_error_7", "", "", -1);
		return NULL;
	}

	crate->setOptionsBitmask(0x2100);
	ManagedReference<TangibleObject*> protoclone = (TangibleObject*) objectManager->cloneObject(prototype);

	if (protoclone == NULL) {
		stopFactory("manf_error", "", "", -1);
		return NULL;
	}

	protoclone->setOptionsBitmask(0x2100);
	crate->addObject(protoclone, -1, false);

	if(protoclone->getCustomObjectName().isEmpty()) {
		UnicodeString newName = "@" + protoclone->getObjectNameStringIdFile()
				+ ":" + protoclone->getObjectNameStringIdName();
		crate->setCustomObjectName(newName, false);
	} else
		crate->setCustomObjectName(protoclone->getCustomObjectName(), false);

	ManagedReference<SceneObject*> outputHopper = getSlottedObject("output_hopper");

	if(outputHopper == NULL) {
		stopFactory("manf_error_6", "", "", -1);
		return false;
	}

	outputHopper->addObject(crate, -1, false);
	broadcastObject(crate, true);

	crate->updateToDatabase();

	return crate;
}

bool FactoryObjectImplementation::removeIngredientsFromHopper(ManufactureSchematic* schematic) {
	/// List Ingredients

	ManagedReference<SceneObject*> inputHopper = getSlottedObject("ingredient_hopper");

	if(inputHopper == NULL) {
		stopFactory("manf_error_5", "", "", -1);
		return false;
	}

	VectorMap<TangibleObject*, int> usableIngredients;
	usableIngredients.setNoDuplicateInsertPlan();
	usableIngredients.setAllowOverwriteInsertPlan();

	for (int i = 0; i < schematic->getFactoryIngredientsSize(); ++i) {

		ManagedReference<TangibleObject*> ingredient = dynamic_cast<TangibleObject*>(schematic->getFactoryIngredient(i));

		if(ingredient == NULL) {
			error("NULL ingredient in removeIngredientsFromHopper");
			continue;
		}

		ManagedReference<TangibleObject*> usableObject = findMatchInInputHopper(inputHopper, ingredient);

		if(usableObject == NULL || !usableObject->isTangibleObject()) {
			stopFactory(ingredient);
			return false;
		}

		if(usableIngredients.contains(usableObject)) {
			int currentUsedValue = usableIngredients.get(usableObject);
			if(currentUsedValue + ingredient->getUseCount() > usableObject->getUseCount())
				return false;
			else
				usableIngredients.put(usableObject, currentUsedValue + ingredient->getUseCount());
		} else {
			usableIngredients.put(usableObject, ingredient->getUseCount());
		}
	}

	for(int i = 0; i < usableIngredients.size(); ++i) {

		ManagedReference<TangibleObject* > ingredient = usableIngredients.elementAt(i).getKey();

		if(ingredient->isResourceContainer()) {

			ResourceContainer* rcnoObject = dynamic_cast<ResourceContainer*>(ingredient.get());
			rcnoObject->setQuantity(rcnoObject->getQuantity() - usableIngredients.get(i));

			ResourceContainerObjectDeltaMessage3* rcnod3 = new ResourceContainerObjectDeltaMessage3(rcnoObject);
			rcnod3->setQuantity(rcnoObject->getQuantity());
			rcnod3->close();
			broadcastMessage(rcnod3, true);

		} else if(ingredient->isFactoryCrate()){

			ingredient->setUseCount(ingredient->getUseCount() - usableIngredients.get(i));

			FactoryCrateObjectDeltaMessage3* fcty3 = new FactoryCrateObjectDeltaMessage3((FactoryCrate*)ingredient.get());
			fcty3->setQuantity(ingredient->getUseCount());
			fcty3->close();
			broadcastMessage(fcty3, true);

		} else {

			ingredient->setUseCount(ingredient->getUseCount() - usableIngredients.get(i));

			TangibleObjectDeltaMessage3* dtano3 = new TangibleObjectDeltaMessage3(ingredient);
			dtano3->setQuantity(ingredient->getUseCount());
			dtano3->close();
			broadcastMessage(dtano3, true);
		}
	}

	return true;
}

TangibleObject* FactoryObjectImplementation::findMatchInInputHopper(
		SceneObject* inputHopper, TangibleObject* ingredient) {

	try {

		ResourceContainer* rcnoIngredient = dynamic_cast<ResourceContainer*>(ingredient);
		int quantity = 0;

		for (int i = 0; i < inputHopper->getContainerObjectsSize(); ++i) {

			ManagedReference<TangibleObject*> object =
					(TangibleObject*) inputHopper->getContainerObject(i);

			if (object == NULL) {
				error("NULL hopper object in FactoryObjectImplementation::countItemInInputHopper");
				continue;
			}

			if (object->isResourceContainer()) {

				if(rcnoIngredient == NULL)
					continue;

				ResourceContainer* rcnoObject = (ResourceContainer*) object.get();

				String test = rcnoIngredient->getSpawnName();
				String test2 = rcnoObject->getSpawnName();

				if (rcnoIngredient->getSpawnName() == rcnoObject->getSpawnName()
						&& rcnoIngredient->getQuantity() <= rcnoObject->getQuantity())
					return object;

			} else {
				if (ingredient->getCraftersSerial() == object->getCraftersSerial()
						&& ingredient->getUseCount() <= object->getUseCount())
					return object;
			}
		}

		return NULL;

	} catch (...) {
		error("unreported exception caught in TangibleObject* FactoryObjectImplementation::findMatchInInputHopper(");
		return NULL;
	}
}
