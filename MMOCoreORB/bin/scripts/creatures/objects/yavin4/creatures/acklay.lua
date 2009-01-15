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
acklay = Creature:new {
	objectName = "acklay",  -- Lua Object Name
	creatureType = "ANIMAL",
	gender = "male",

	speciesName = "geonosian_acklay_bunker_boss",
	stfName = "mob/creature_names",
	objectCRC = 258679778, 
	socialGroup = "self",
	level = 157,

	combatFlags = ATTACKABLE_FLAG + ENEMY_FLAG + AGGRESSIVE_FLAG,

	healthMax = 120000,
	healthMin = 110000,
	strength = 20000,
	constitution = 20000,

	actionMax = 120000,
	actionMin = 110000,
	quickness = 20000,
	stamina = 20000,

	mindMax = 120000,
	mindMin = 110000,
	focus = 20000,
	willpower = 20000,

	height = 1.2, -- Size of creature
	armor = 2, -- 0 = None; 1 = Light; 2 = Medium; 3 = Heavy
	kinetic = 30,
	energy = 45,
	electricity = 30,
	stun = 30,
	blast = 55,
	heat = 55,
	cold = 45,
	acid = 30,
	lightsaber = 0,

	accuracy = 400,

	healer = 0,

	pack = 0,
	herd = 0,
	stalker = 0,
	killer = 1,
	aggressive = 1,
	invincible = 0, 

	meleeDefense = 1,  
	rangedDefense = 1,

	attackCreatureOnSight = "", -- Enter socialGroups 

	weapon = "object/weapon/creature/shared_creature_default_weapon.iff", -- File path to weapon -> object\xxx\xxx\xx
	weaponName = "Creature Defualt", -- Name ex. 'a Vibrolance'
	weaponTemp = "creature_default_weapon", -- Weapon Template ex. 'lance_vibrolance'
	weaponClass = "UnarmedMeleeWeapon", -- Weapon Class ex. 'PolearmMeleeWeapon'
	weaponEquipped = 1,
	weaponMinDamage = 800,
	weaponMaxDamage = 1750,
	weaponAttackSpeed = 1,
	weaponDamageType = "KINETIC", -- ELECTRICITY, KINETIC, etc
	weaponArmorPiercing = "NONE", -- LIGHT, NONE, MEDIUM, HEAVY

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

	lootGroup = "0", -- Group it belongs to for loot

	tame = 0,  -- Likely hood to be tamed

	milk = 0,

	boneType = "bone_mammal_yavin4",
	boneMax = 675,

	hideType = "hide_scaley_yavin4",
	hideMax = 750,

	meatType = "meat_insect_yavin4",
	meatMax = 1250,

	
	skills = { "geonosianAcklayAttack1", "geonosianAcklayAttack2", "geonosianAcklayAttack3", "geonosianAcklayAttack4", "geonosianAcklayAttack5", "geonosianAcklayAttack6", "geonosianAcklayAttack7" },
	respawnTimer = 7200,

	behaviorScript = "", -- Link to the behavior script for this object
}

Creatures:addCreature(acklay, 258679778) --  Add to Global Table
