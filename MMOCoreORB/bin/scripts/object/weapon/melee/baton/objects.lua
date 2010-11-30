--Copyright (C) 2009 <SWGEmu>

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


object_weapon_melee_baton_shared_baton_gaderiffi = SharedWeaponObjectTemplate:new {
	appearanceFilename = "appearance/wp_mle_baton_gaderiffi.apt",
	arrangementDescriptors = {"hold_r"},
	attackType = 1,

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/weapon/client_melee_baton.cdf",
	clientGameObjectType = 131073,
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 0,
	customizationVariableMapping = {},

	detailedDescription = "@weapon_detail:baton_gaderiffi",

	gameObjectType = 131073,

	locationReservationRadius = 0,
	lookAtText = "@weapon_lookat:baton_gaderiffi",

	noBuildRadius = 0,

	objectName = "@weapon_name:baton_gaderiffi",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {"default_weapon_ammo_slot", "crafted_components"},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,
	totalCellNumber = 0,

	useStructureFootprintOutline = 0,

	weaponEffect = "bolt",
	weaponEffectIndex = 0,

	clientObjectCRC = 1521219232
}

ObjectTemplates:addClientTemplate(object_weapon_melee_baton_shared_baton_gaderiffi, "object/weapon/melee/baton/shared_baton_gaderiffi.iff")

object_weapon_melee_baton_shared_baton_stun = SharedWeaponObjectTemplate:new {
	appearanceFilename = "appearance/wp_mle_baton_stun.apt",
	arrangementDescriptors = {"hold_r"},
	attackType = 1,

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/weapon/client_melee_baton.cdf",
	clientGameObjectType = 131073,
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 0,
	customizationVariableMapping = {},

	detailedDescription = "@weapon_detail:baton_stun",

	gameObjectType = 131073,

	locationReservationRadius = 0,
	lookAtText = "@weapon_lookat:baton_stun",

	noBuildRadius = 0,

	objectName = "@weapon_name:baton_stun",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {"default_weapon_ammo_slot", "crafted_components"},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,
	totalCellNumber = 0,

	useStructureFootprintOutline = 0,

	weaponEffect = "bolt",
	weaponEffectIndex = 0,

	clientObjectCRC = 2740869510
}

ObjectTemplates:addClientTemplate(object_weapon_melee_baton_shared_baton_stun, "object/weapon/melee/baton/shared_baton_stun.iff")

object_weapon_melee_baton_shared_victor_baton_gaderiffi = SharedWeaponObjectTemplate:new {
	appearanceFilename = "appearance/wp_mle_baton_gaderiffi.apt",
	arrangementDescriptors = {"hold_r"},
	attackType = 1,

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/weapon/client_melee_baton.cdf",
	clientGameObjectType = 131073,
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 0,
	customizationVariableMapping = {},

	detailedDescription = "@weapon_detail:victor_baton_gaderiffi",

	gameObjectType = 131073,

	locationReservationRadius = 0,
	lookAtText = "@weapon_lookat:victor_baton_gaderiffi",

	noBuildRadius = 0,

	objectName = "@weapon_name:victor_baton_gaderiffi",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {"default_weapon_ammo_slot", "crafted_components"},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,
	totalCellNumber = 0,

	useStructureFootprintOutline = 0,

	weaponEffect = "bolt",
	weaponEffectIndex = 0,

	clientObjectCRC = 926540761
}

ObjectTemplates:addClientTemplate(object_weapon_melee_baton_shared_victor_baton_gaderiffi, "object/weapon/melee/baton/shared_victor_baton_gaderiffi.iff")
