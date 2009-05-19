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
oldMan = Creature:new {
	objectName = "oldMan",  -- Lua Object Name
	creatureType = "NPC",
	faction = "rebel", 
	factionPoints = 20,
	gender = "",

	speciesName = "fs_intro_oldman",
	stfName = "mob/creature_names", 
	objectCRC = 2513398694, 
	socialGroup = "rebel",
	level = 700,
	

	combatFlags = 0,

	healthMax = 1200000,
	healthMin = 1000000,
	strength = 620000,
	constitution = 620000,

	actionMax = 1200000,
	actionMin = 1000000,
	quickness = 620000,
	stamina = 620000,

	mindMax = 1200000,
	mindMin = 620000,
	focus = 620000,
	willpower = 620000,

	height = 1, -- Size of creature
	armor = 3, -- Just a guess
	kinetic = 98,
	energy = 98,
	electricity = 98,
	stun = 98,
 	blast = 98,
 	heat = 98,
 	cold = 98,
 	acid = 98,
 	lightSaber = 98, 

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

	weapon = "object/weapon/melee/sword/shared_sword_lightsaber_anakin.iff", -- File path to weapon -> object\xxx\xxx\xx
	weaponName = "Old Man Saber", -- Name ex. 'a Vibrolance'
	weaponTemp = "sword_lightsaber_anakin", -- Weapon Template ex. 'lance_vibrolance'
	weaponClass = "OneHandedJediWeapon", -- Weapon Class ex. 'PolearmMeleeWeapon'
	weaponEquipped = 1,
	weaponMinDamage = 850,
	weaponMaxDamage = 1024,
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

	lootGroup = "0,11,15,19,33,39,40", -- Group it belongs to for loot

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

	skills = { "oldManAttack1", "oldManAttack4", "oldManAttack5", "oldManAttack6", "oldManAttack7", "oldManAttack8", "oldManAttack2", "oldManAttack9", "oldManAttack10", "oldManAttack11", "oldManAttack12", "oldManAttack13", "oldManAttack14", "oldManAttack3", "oldManAttack15", "oldManAttack16", "oldManAttack17" },
	respawnTimer = 43200,

	behaviorScript = "", -- Link to the behavior script for this object
}

Creatures:addCreature(oldMan, 2513398694) --  Add to Global Table
