/*
 * SlicingToolImplementation.cpp
 *
 *  Created on: Mar 6, 2011
 *      Author: polonel
 */

#include "SlicingTool.h"

#include "server/zone/objects/manufactureschematic/ManufactureSchematic.h"
#include "server/zone/packets/scene/AttributeListMessage.h"
#include "server/zone/packets/tangible/TangibleObjectDeltaMessage3.h"

#include "server/zone/templates/tangible/tool/SlicingToolTemplate.h"
#include "server/zone/objects/player/sessions/SlicingSession.h"

void SlicingToolImplementation::loadTemplateData(SharedObjectTemplate* templateData) {
	TangibleObjectImplementation::loadTemplateData(templateData);

	SlicingToolTemplate* slicingTempl = dynamic_cast<SlicingToolTemplate*> (templateData);

	effectiveness = slicingTempl->getEffectiveness();

}

int SlicingToolImplementation::handleObjectMenuSelect(PlayerCreature* player, byte selectedID) {
	if (selectedID != 20)
		return TangibleObjectImplementation::handleObjectMenuSelect(player, selectedID);
	/*
	ManagedReference<Facade*> facade = player->getActiveSession(SessionFacadeType::SLICING);
	ManagedReference<SlicingSession*> session = dynamic_cast<SlicingSession*>(facade.get());

	if (session == NULL) {
		player->sendSystemMessage("You must be in a slicing session in order to use that.");
		return 0;
	}

	if (getGameObjectType() == SceneObject::MOLECULARCLAMP)
		session->useClampFromInventory(_this);

	player->sendSystemMessage("You are unable to use that item right now");
	*/

	return 0;
}

void SlicingToolImplementation::fillAttributeList(AttributeListMessage* msg, PlayerCreature* object) {
	TangibleObjectImplementation::fillAttributeList(msg, object);

	uint32 gameObjType = getGameObjectType();

	if (gameObjType != SceneObject::MOLECULARCLAMP)
		msg->insertAttribute("craft_tool_effectiveness", Math::getPrecision(effectiveness, 2));

	if (craftersName != "") {
		msg->insertAttribute("crafter", craftersName);

	}
	if (craftersSerial != "") {
		msg->insertAttribute("serial_number", craftersSerial);

	}
}

void SlicingToolImplementation::updateCraftingValues(ManufactureSchematic* schematic) {
	CraftingValues* craftingValues = schematic->getCraftingValues();
	// useModifier is effectiveness
	effectiveness = craftingValues->getCurrentValue("usemodifier");

}

bool SlicingToolImplementation::calculateSuccessRate() {
	if (getGameObjectType() == SceneObject::FLOWANALYZER) {
		int chance = System::random(100);
		chance =+ (chance + effectiveness);
		if (chance > 25) // 25% chance to fail
			return true;
	}

	return false;
}
