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


#include "Dice.h"
#include "DiceImplementation.h"

#include "../../../objects.h"

DiceImplementation::DiceImplementation(uint64 oid, uint32 tempCRC, const UnicodeString& n, const String& tempn)
		: DiceServant(oid, tempCRC, n, tempn, DICE) {
	customName = n;
	templateTypeName = "obj_n";
	templateName = tempn;

	diceType = objectCRC;
	diceSides = 0;
	init();
}

DiceImplementation::DiceImplementation(CreatureObject* creature, uint64 oid, uint32 tempCRC, const UnicodeString& n, const String& tempn)
		: DiceServant(creature, oid, tempCRC, n, tempn, DICE) {
	diceType = objectCRC;
	diceSides = 0;
	init();
}


DiceImplementation::DiceImplementation(CreatureObject* creature, uint32 tempCRC, const UnicodeString& n, const String& tempn)
		: DiceServant(creature, creature->getNewItemID(), tempCRC, n, tempn, DICE) {
	diceType = objectCRC;
	diceSides = 0;
	init();
}

DiceImplementation::~DiceImplementation() {
}

void DiceImplementation::sendDeltas(Player* player) {
}

void DiceImplementation::generateAttributes(SceneObject* obj) {
	if (!obj->isPlayer())
		return;

	Player* player = (Player*) obj;
	AttributeListMessage* alm = new AttributeListMessage((TangibleObject*) _this);

	addAttributes(alm);

	player->sendMessage(alm);
}

void DiceImplementation::parseItemAttributes() {
}

void DiceImplementation::addHeaderAttributes(AttributeListMessage* alm) {
	//alm->insertAttribute("volume", "1");

	if (craftersName != ""){
		alm->insertAttribute("crafter", craftersName);
	}

	if (craftedSerial != ""){
		alm->insertAttribute("serial_number", craftedSerial);
	}
}

void DiceImplementation::addFooterAttributes(AttributeListMessage* alm) {
}

void DiceImplementation::addAttributes(AttributeListMessage* alm) {
	addHeaderAttributes(alm);
	addFooterAttributes(alm);
}

void DiceImplementation::sendRadialResponseTo(Player* player, ObjectMenuResponse* omr) {
	if (player->getInventoryItem(getObjectID()) != NULL) {
		RadialMenuParent* rollMenu = new RadialMenuParent(172,3,"@dice/dice:dice_roll_single");

		if (diceType != CHANCECUBE && diceType != CONFIGURABLE) {
			rollMenu->addRadialMenuItem(172,3,"@dice/dice:dice_roll_one_single");
			rollMenu->addRadialMenuItem(173,3,"@dice/dice:dice_roll_two_single");
			rollMenu->addRadialMenuItem(174,3,"@dice/dice:dice_roll_three_single");
			rollMenu->addRadialMenuItem(175,3,"@dice/dice:dice_roll_four_single");
		}

		omr->addRadialParent(rollMenu);

		if (diceType == CONFIGURABLE) {
			RadialMenuParent* configureMenu = new RadialMenuParent(164,3,"@dice/dice_details:eqp_dice_configure");
			configureMenu->addRadialMenuItem(171,3,"@dice/dice:dice_eight_single");
			configureMenu->addRadialMenuItem(170,3,"@dice/dice:dice_seven_single");
			configureMenu->addRadialMenuItem(169,3,"@dice/dice:dice_six_single");
			configureMenu->addRadialMenuItem(168,3,"@dice/dice:dice_five_single");
			configureMenu->addRadialMenuItem(167,3,"@dice/dice:dice_four_single");
			configureMenu->addRadialMenuItem(166,3,"@dice/dice:dice_three_single");
			configureMenu->addRadialMenuItem(165,3,"@dice/dice:dice_two_single");
			omr->addRadialParent(configureMenu);
		}
	}

	if (_this->getParent() != NULL) {
		bool cellPermission = true;

		if (_this->getParent()->isCell() && cellPermission) {
			omr->addRadialParent(10, 3, "@ui_radial:item_pickup");
		}
	}

	omr->finish();

	player->sendMessage(omr);
}

void DiceImplementation::init() {
	switch (diceType) {
	case CHANCECUBE:
		diceSides = 2;
		break;
	case CONFIGURABLE:
		diceSides = 0;
		break;
	case CENTIHEDRON:
		diceSides = 100;
		break;
	case HEXAHEDRON:
		diceSides = 6;
		break;
	case DECAHEDRON:
		diceSides = 10;
		break;
	case DODECAHEDRON:
		diceSides = 12;
		break;
	case ICOSAHEDRON:
		diceSides = 20;
		break;
	default:
		break;
	};
}

void DiceImplementation::rollDice(Player* player, int dnum) {
	if (diceSides == 0) {
		if (diceType == CONFIGURABLE)
			player->sendSystemMessage("dice/dice", "dice_configure_msg");

		return;
	}

	StringBuffer results;
	//TODO: add this functinoality - results.precision(0);
	results << " ";

	String resultsString, filename = "dice/dice", selfString, otherString;

	for (int i = 0; i < dnum; i++) {
		if (i == dnum - 1) {
            if (dnum > 1)
                results << "and ";
			results << System::random(diceSides-1) + 1;
        } else if (dnum == 2)
            results << System::random(diceSides-1) + 1 << " ";
        else
			results << System::random(diceSides-1) + 1 << ", ";
	}

	resultsString = results.toString();
	StfParameter* stfparams = new StfParameter();

	String dicesides;
	switch (diceSides) {
    case 2:
        dicesides = "two";
        break;
    case 3:
        dicesides = "three";
        break;
    case 4:
        dicesides = "four";
        break;
    case 5:
        dicesides = "five";
        break;
    case 6:
        dicesides = "six";
        break;
    case 7:
        dicesides = "seven";
        break;
    case 8:
        dicesides = "eight";
        break;
    case 10:
        dicesides = "ten";
        break;
    case 12:
        dicesides = "twelve";
        break;
    case 20:
        dicesides = "twenty";
        break;
    case 100:
        dicesides = "hundred";
        break;
    default:
        // undefined diceSides
        return;
	};
	stfparams->addTT(dicesides);

	stfparams->addDI(dnum);
	stfparams->addTU(player->getFirstNameProper());

	if (dnum > 1) { // cannot have multiple chance cubes or configurable dice at once
		selfString = "roll_many_self";
		otherString = "roll_many_other";
	} else if (dnum == 1) { // now have to check for chance cube, where the stf's are slightly different, and results aren't numbers
		if (objectCRC == CHANCECUBE) {
			stfparams->addTT(player->getFirstNameProper());
			if (resultsString == " 1")
				resultsString = "red";
			else if (resultsString == " 2")
				resultsString = "blue";
			selfString = "chance_cube_result_self";
			otherString = "chance_cube_result_other";
		} else { // not a chance cube
			selfString = "roll_one_self";
			otherString = "roll_one_other";
		}
	}

	stfparams->addTO(resultsString);

	//output to player and those around them
	ChatSystemMessage* msg = new ChatSystemMessage(filename, selfString, stfparams);
	player->sendMessage(msg);
	ChatSystemMessage* msg2 = new ChatSystemMessage(filename, otherString, stfparams);
	player->broadcastMessage(msg2, 128, true, false);
}

void DiceImplementation::setConfigurableDice(int dsides) {
	if (diceType != CONFIGURABLE)
		return;
	// set the number of sides
	diceSides = dsides;
}
