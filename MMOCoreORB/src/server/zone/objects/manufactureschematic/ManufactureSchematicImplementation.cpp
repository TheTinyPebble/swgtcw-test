/*
Copyright (C) 2007 <SWGEmu>

This File is part of Core3.

This program is free software; you can redistribute
it and/or modify it under the terms of the GNU Lesser
General Public License as published by the Free Software
Foundation; either version 2 of the License,
or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Lesser General Public License for
more details.

You should have received a copy of the GNU Lesser General
Public License along with this program; if not, write to
the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

Linking Engine3 statically or dynamically with other modules
is making a combined work based on Engine3.
Thus, the terms and conditions of the GNU Lesser General Public License
cover the whole combination.

In addition, as a special exception, the copyright holders of Engine3
give you permission to combine Engine3 program with free software
programs or libraries that are released under the GNU LGPL and with
code included in the standard release of Core3 under the GNU LGPL
license (or modified versions of such code, with unchanged license).
You may copy and distribute such a system following the terms of the
GNU LGPL for Engine3 and the licenses of the other code concerned,
provided that you include the source code of that other code when
and as the GNU LGPL requires distribution of source code.

Note that people who make modified versions of Engine3 are not obligated
to grant this special exception for their modified versions;
it is their choice whether to do so. The GNU Lesser General Public License
gives permission to release a modified version without this exception;
this exception also makes it possible to release a modified version
which carries forward this exception.
*/

#include "ManufactureSchematic.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/zone/objects/tangible/tool/CraftingTool.h"

#include "server/zone/packets/scene/SceneObjectCreateMessage.h"
#include "server/zone/packets/scene/SceneObjectCloseMessage.h"
#include "server/zone/packets/scene/UpdateContainmentMessage.h"
#include "server/zone/packets/manufactureschematic/ManufactureSchematicObjectMessage3.h"
#include "server/zone/packets/manufactureschematic/ManufactureSchematicObjectMessage6.h"
#include "server/zone/packets/manufactureschematic/ManufactureSchematicObjectMessage8.h"
#include "server/zone/packets/manufactureschematic/ManufactureSchematicObjectMessage9.h"

#include "ingredientslots/ResourceSlot.h"
//#include "ingredientslots/IdenticalSlot.h"
//#include "ingredientslots/MixedSlot.h"
//#include "ingredientslots/OptionalIdenticalSlot.h"
//#include "ingredientslots/OptionalMixedSlot.h"

/*#include "server/zone/packets/manufactureschematic/ManufactureSchematicObjectDeltaMessage3.h"
#include "server/zone/packets/manufactureschematic/ManufactureSchematicObjectDeltaMessage6.h"
#include "server/zone/packets/manufactureschematic/ManufactureSchematicObjectDeltaMessage7.h"*/

void ManufactureSchematicImplementation::fillAttributeList(AttributeListMessage* alm, PlayerCreature* object) {


}

void ManufactureSchematicImplementation::sendTo(SceneObject* player, bool doClose) {
	if (isStaticObject())
		return;

	// Scene Create
	BaseMessage* create = new SceneObjectCreateMessage(getObjectID(), 0x3819C409);
	player->sendMessage(create);

	// Link to Crafting Tool
	BaseMessage* link = new UpdateContainmentMessage(getObjectID(), getParent()->getObjectID(), 4);
	player->sendMessage(link);

	sendBaselinesTo(player);

	sendSlottedObjectsTo(player);
	sendContainerObjectsTo(player);

	if(doClose) {
		BaseMessage* msg = new SceneObjectCloseMessage(_this);
		player->sendMessage(msg);
	}

}

void ManufactureSchematicImplementation::sendBaselinesTo(SceneObject* player) {
	if (!player->isPlayerCreature())
		return;

	PlayerCreature* playerCreature = (PlayerCreature*) player;

	ManufactureSchematicObjectMessage3* msco3 =
			new ManufactureSchematicObjectMessage3(getObjectID(),
					draftSchematic->getComplexity(), playerCreature->getFirstName());
	player->sendMessage(msco3);

	// MSCO6
	ManufactureSchematicObjectMessage6* msco6 =
		new ManufactureSchematicObjectMessage6(getObjectID(), getClientObjectCRC());
	player->sendMessage(msco6);

	// MSCO8
	ManufactureSchematicObjectMessage8* msco8 =
		new ManufactureSchematicObjectMessage8(getObjectID());
	player->sendMessage(msco8);

	// MSCO9
	ManufactureSchematicObjectMessage9* msco9 =
		new ManufactureSchematicObjectMessage9(getObjectID());
	player->sendMessage(msco9);

}

Reference<IngredientSlot*> ManufactureSchematicImplementation::getIngredientSlot(int index) {
	if(index < ingredientSlots.size())
		return ingredientSlots.get(index);

	return NULL;
}

int ManufactureSchematicImplementation::getSlotCount() {
	return ingredientSlots.size();
}

void ManufactureSchematicImplementation::synchronizedUIListen(SceneObject* player, int value) {

	if(!player->isPlayerCreature())
		return;

	ManagedReference<PlayerCreature* > playerCreature = (PlayerCreature*) player;

	ManagedReference<CraftingTool* > craftingTool = playerCreature->getLastCraftingToolUsed();

	if(craftingTool != NULL)
		craftingTool->synchronizedUIListenForSchematic(playerCreature);
	else
		playerCreature->sendSystemMessage("ui_craft", "err_no_crafting_tool");
}

void ManufactureSchematicImplementation::synchronizedUIStopListen(SceneObject* player, int value) {

}

void ManufactureSchematicImplementation::initializeIngredientSlots(
		DraftSchematic* schematic) {

	cleanupIngredientSlots();

	assembled = false;
	completed = false;
	complexity = schematic->getComplexity();
	manufactureLimit = 0;

	Reference<IngredientSlot* > ingredientSlot = NULL;
	Reference<DraftSlot* > draftSlot = NULL;

	for (int i = 0; i < draftSchematic->getDraftSlotCount(); ++i) {

		draftSlot = draftSchematic->getDraftSlot(i);

		String type = draftSlot->getResourceType();
		int quantity = draftSlot->getQuantity();

		switch (draftSlot->getSlotType()) {
		case IngredientSlot::RESOURCESLOT:
			ingredientSlot = new ResourceSlot(type, quantity);
			break;
		case IngredientSlot::IDENTICALSLOT:
			//ingredientSlot = new IdenticalSlot();
			break;
		case IngredientSlot::MIXEDSLOT:
			//ingredientSlot = new MixedSlot();
			break;
		case IngredientSlot::OPTIONALIDENTICALSLOT:
			//ingredientSlot = new OptionalIdenticalSlot();
			break;
		case IngredientSlot::OPTIONALMIXEDSLOT:
			//ingredientSlot = new OptionalMixedSlot();
			break;
		}

		ingredientSlots.add(ingredientSlot);
	}
}

void ManufactureSchematicImplementation::cleanupIngredientSlots() {

	while (ingredientSlots.size() > 0) {
		Reference<IngredientSlot* > slot = ingredientSlots.remove(0);

		if (slot != NULL) {

			if(!assembled && slot->hasItem())
				slot->returnObjectToParent();

			slot = NULL;
		}
	}
}

bool ManufactureSchematicImplementation::isReadyForAssembly() {

	for (int i = 0; i < ingredientSlots.size(); ++i) {

		Reference<IngredientSlot* > slot = ingredientSlots.get(i);

		if(slot == NULL || !slot->hasItem() || !slot->isComplete())
			return false;
	}
	return true;
}
