--Copyright (C) 2008 <SWGEmu>


--This File is part of Core3.

--This program is free software; you can redistribute 
--it and/or modify it under the terms of the GNU Lesser 
--General Public License as published by the Free Software
--Foundation; either version 2 of the License, 
--or (at your option) any later version.

--This program is distributed in the hope that it will be useful, 
--but WITHOUT ANY WARRANTY; without even the implied warranty of 
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
--See the GNU Lesser General Public License for
--more details.

--You should have received a copy of the GNU Lesser General 
--Public License along with this program; if not, write to
--the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

--Linking Engine3 statically or dynamically with other modules 
--is making a combined work based on Engine3. 
--Thus, the terms and conditions of the GNU Lesser General Public License 
--cover the whole combination.

--In addition, as a special exception, the copyright holders of Engine3 
--give you permission to combine Engine3 program with free software 
--programs or libraries that are released under the GNU LGPL and with 
--code included in the standard release of Core3 under the GNU LGPL 
--license (or modified versions of such code, with unchanged license). 
--You may copy and distribute such a system following the terms of the 
--GNU LGPL for Engine3 and the licenses of the other code concerned, 
--provided that you include the source code of that other code when 
--and as the GNU LGPL requires distribution of source code.

--Note that people who make modified versions of Engine3 are not obligated 
--to grant this special exception for their modified versions; 
--it is their choice whether to do so. The GNU Lesser General Public License 
--gives permission to release a modified version without this exception; 
--this exception also makes it possible to release a modified version 
--which carries forward this exception.

darthVader = Creature:new {
	objectName = "darthVader",  -- Lua Object Name
	creatureType = "NPC",
	faction = "imperial", 
	factionPoints = 20,
	gender = "",

	speciesName = "darth_vader",
	stfName = "mob/creature_names", 
	objectCRC = 147261716, 
	socialGroup = "imperial",
	level = 500,
	

	combatFlags = 0,

	healthMax = 650000,
	healthMin = 620000,
	strength = 80000,
	constitution = 80000,

	actionMax = 650000,
	actionMin = 620000,
	quickness = 80000,
	stamina = 80000,

	mindMax = 650000,
	mindMin = 620000,
	focus = 80000,
	willpower = 80000,

	height = 1, -- Size of creature
	armor = 3, -- Just a guess
	kinetic = 95,
	energy = 95,
	electricity = 95,
	stun = 95,
 	blast = 95,
 	heat = 95,
 	cold = 95,
 	acid = 95,
 	lightSaber = 95, 

	accuracy = 500,

	healer = 0,

	pack = 1,
	herd = 0,
	stalker = 0,
	killer = 1,
	ferocity = 0,
	aggressive = 0,
	invincible = 0, 

	meleeDefense = 1,
	rangedDefense = 1,

	attackCreatureOnSight = "", -- Enter socialGroups 

	weapon = "object/weapon/melee/sword/shared_sword_lightsaber_vader.iff", -- File path to weapon -> object\xxx\xxx\xx
	weaponName = "Darth Saber", -- Name ex. 'a Vibrolance'
	weaponTemp = "sword_lightsaber_vader", -- Weapon Template ex. 'lance_vibrolance'
	weaponClass = "TwoHandedJediWeapon", -- Weapon Class ex. 'PolearmMeleeWeapon'
	weaponEquipped = 1,
	weaponMinDamage = 1645,
	weaponMaxDamage = 3000,
	weaponAttackSpeed = 2,
	weaponDamageType = "LIGHTSABER", -- ELECTRICITY, KINETIC, etc
	weaponArmorPiercing = "MEDIUM", -- LIGHT, NONE, MEDIUM, HEAVY

	alternateWeapon = "", -- File path to weapon -> object\xxx\xxx\xx
	alternateWeaponName = "", -- Name ex. 'a Vibrolance'
	alternateWeaponTemp = "", -- Weapon Template ex. 'lance_vibrolance'
	alternateWeaponClass = "", -- Weapon Class ex. 'PolearmMeleeWeapon'
	alternateWeaponEquipped = 0,
	alternateWeaponMinDamage = 0,
	alternateWeaponMaxDamage = 0,
	alternateWeaponAttackSpeed = 0,
	alternateWeaponDamageType = "", -- ELECTRICITY, KINETIC, etc
	alternateWeaponArmorPiercing = "", -- LIGHT, NONE, MEDIUM, HEAVY

	internalNPCDamageModifier = 0.3, -- Damage Modifier to other NPC's

	lootGroup = "0,11,15,19,33,39,40,51,52,53,54,55,56,57,58,59,60,61,101", -- Group it belongs to for loot

	tame = 0,
	datapadItemCRC = 0,
	mountCRC = 0,
	mountSpeed = 0,
	mountAcceleration = 0,

	milk = 0,

	boneType = "",
	boneMax = 0,

	hideType = "",
	hideMax = 0,

	meatType = "",
	meatMax = 0,

	skills = { "darthAttack17", "darthAttack1", "darthAttack2", "darthAttack3", "darthAttack4", "darthAttack5", "darthAttack6", "darthAttack7", "darthAttack17", "darthAttack8", "darthAttack9", "darthAttack10", "darthAttack11", "darthAttack12", "darthAttack17", "darthAttack13", "darthAttack14", "darthAttack15", "darthAttack16", "darthAttack17" },
	respawnTimer = 3600,

	behaviorScript = "", -- Link to the behavior script for this object
}

Creatures:addCreature(darthVader, 147261716) --  Add to Global Table
