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

#ifndef INGREDIENTSLOT_H_
#define INGREDIENTSLOT_H_

#include "server/zone/objects/tangible/TangibleObject.h"

class IngredientSlot : public Serializable, public Logger {

protected:


	String type;
	int requiredQuantity;
	int slottype;
	String serial;
	ManagedReference<SceneObject* > previousParent;

	bool requiresIdentical;
	bool optional;

public:

	static const int RESOURCESLOT = 0;
	static const int IDENTICALSLOT = 1;
	static const int MIXEDSLOT = 2;
	static const int OPTIONALIDENTICALSLOT = 3;
	static const int OPTIONALMIXEDSLOT = 4;

	// Crafting error messages
	static const short OK = 0x00;
	static const short NOSERVER = 0x01; // No server for Owner
	static const short NOTASSEMBLYSTAGE = 0x02; // Not in crafting assembly stage
	static const short NOTCUSTOMIZATIONSTAGE = 0x03; // Not in crafting customization stage
	static const short NOSCHEMATIC = 0x04; // No Draft Schematic Found
	static const short NOTOOL = 0x05; // No Crafting tool Found
	static const short NOMANUFACTURE = 0x06; // No manufacturing schematic found
	static const short INVALID = 0x07; // Invalid Slot Chosen
	static const short INVALIDOPTION = 0x08; // Invalid Slot Option Chosen
	static const short INVALIDINGREDIENTSIZE = 0x09; // Invalid ingredient size for slot
	static const short FULL = 0x0A; // Slot Full
	static const short INVALIDINGREDIENT = 0x0B; // Invalid Ingredient
	static const short INGREDIENTNOTININVENTORY = 0x0C; // Ingredient not in inventory
	static const short BADCRATE = 0x0D; // Cannot remove resource from crate
	static const short BADRESOURCEFOR = 0x0E; // Bad resource for Slot
	static const short COMPONENTDAMAGED = 0x0F; // Component too damaged for use
	static const short NOCOMPONENTTRANSFER = 0x10; // Cannot transfer componenet
	static const short BADCOMPONENT = 0x11; // Bad component for slot
	static const short NOINVENTORY = 0x12; // Inventory Missing
	static const short BADSTATIONHOPPER = 0x13; // Bad station Hopper
	static const short BADTARGETCONTAINER = 0x14; // Bad target container
	static const short EMPTYISEMPTY = 0x15; // Empty slot is empty
	static const short FAILEDRESOURCECREATE = 0x16; // Cannot create resource container
	static const short EMPTYASSEMBLE = 0x17; // Trying to assemble with empty slot
	static const short PARTIALASSEMBLE = 0x18; // Trying to assemble with patially full slot
	static const short PROTOTYPENOTFOUND = 0x19; // Prototype not found
	static const short BADNAME = 0x1A; // Rename object and resend
	static const short MYSTERY = 0x1B; // Didn't read this one
	static const short FAILEDTOTRANSFER = 0x1C; // Failed to transfer resources to station
	static const short WEIRDFAILEDMESSAGE = 0x1D; // Hey nonny nonny tra la la!

public:
	IngredientSlot(String t, int q){

		type = t;
		requiredQuantity = q;
	}

	~IngredientSlot(){
		info("Deleting Slot type " + String::valueOf(slottype));
	}

	bool isType(int type) {
		return type == slottype;
	}

	bool isOptional() {
		return optional;
	}

	virtual inline void init(const int size){

	}

	virtual inline void cleanup(){

	}

	virtual inline int getQuantity() {

		return 0;
	}

	virtual inline bool add(PlayerCreature* player, TangibleObject* tano) {

		return false;
	}

	virtual inline bool remove(PlayerCreature* player){

		return false;
	}

	virtual inline TangibleObject* get() {

		return NULL;
	}

	virtual inline bool isComplete() {
		return false;
	}

	virtual inline bool hasItem() {
		return false;
	}

	virtual inline uint64 getObjectID() {
		return 0;
	}

	virtual inline bool returnObjectToParent() {;
		return false;
	}

	SceneObject* getPreviousParent() {
		return previousParent;
	}

	virtual void print(){


	}
};
#endif /*INGREDIENTSLOT_H_*/
