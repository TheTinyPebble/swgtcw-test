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


object_weapon_melee_knife_shared_knife_dagger = SharedWeaponObjectTemplate:new {
	appearanceFilename = "appearance/wp_mle_knife_dagger.apt",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/hold_r.iff",
	attackType = 1,

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/weapon/client_melee_knife.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 0,
	customizationVariableMapping = {},

	detailedDescription = "@weapon_detail:knife_dagger",

	gameObjectType = 131079,

	locationReservationRadius = 0,
	lookAtText = "@weapon_lookat:knife_dagger",

	noBuildRadius = 0,

	objectName = "@weapon_name:knife_dagger",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/default_weapon.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0,

	weaponEffect = "bolt",
	weaponEffectIndex = 0
}

ObjectTemplates:addTemplate(object_weapon_melee_knife_shared_knife_dagger, 4040009714)

object_weapon_melee_knife_shared_knife_donkuwah = SharedWeaponObjectTemplate:new {
	appearanceFilename = "appearance/wp_mle_knife_stone.apt",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/hold_r.iff",
	attackType = 1,

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/weapon/client_melee_knife.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 0,
	customizationVariableMapping = {},

	detailedDescription = "@weapon_detail:knife_donkuwah",

	gameObjectType = 131079,

	locationReservationRadius = 0,
	lookAtText = "@weapon_lookat:knife_donkuwah",

	noBuildRadius = 0,

	objectName = "@weapon_name:knife_donkuwah",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/default_weapon.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0,

	weaponEffect = "bolt",
	weaponEffectIndex = 0
}

ObjectTemplates:addTemplate(object_weapon_melee_knife_shared_knife_donkuwah, 532251396)

object_weapon_melee_knife_shared_knife_janta = SharedWeaponObjectTemplate:new {
	appearanceFilename = "appearance/wp_mle_knife_stone.apt",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/hold_r.iff",
	attackType = 1,

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/weapon/client_melee_knife.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 0,
	customizationVariableMapping = {},

	detailedDescription = "@weapon_detail:knife_janta",

	gameObjectType = 131079,

	locationReservationRadius = 0,
	lookAtText = "@weapon_lookat:knife_janta",

	noBuildRadius = 0,

	objectName = "@weapon_name:knife_janta",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/default_weapon.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0,

	weaponEffect = "bolt",
	weaponEffectIndex = 0
}

ObjectTemplates:addTemplate(object_weapon_melee_knife_shared_knife_janta, 2255187692)

object_weapon_melee_knife_shared_knife_stone = SharedWeaponObjectTemplate:new {
	appearanceFilename = "appearance/wp_mle_knife_stone.apt",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/hold_r.iff",
	attackType = 1,

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/weapon/client_melee_knife.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 0,
	customizationVariableMapping = {},

	detailedDescription = "@weapon_detail:knife_stone",

	gameObjectType = 131079,

	locationReservationRadius = 0,
	lookAtText = "@weapon_lookat:knife_stone",

	noBuildRadius = 0,

	objectName = "@weapon_name:knife_stone",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/default_weapon.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0,

	weaponEffect = "bolt",
	weaponEffectIndex = 0
}

ObjectTemplates:addTemplate(object_weapon_melee_knife_shared_knife_stone, 1218550121)

object_weapon_melee_knife_shared_knife_stone_noob = SharedWeaponObjectTemplate:new {
	appearanceFilename = "appearance/wp_mle_knife_stone.apt",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/hold_r.iff",
	attackType = 1,

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/weapon/client_melee_knife.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 0,
	customizationVariableMapping = {},

	detailedDescription = "@weapon_detail:knife_stone_noob",

	gameObjectType = 131079,

	locationReservationRadius = 0,
	lookAtText = "@weapon_lookat:knife_stone_noob",

	noBuildRadius = 0,

	objectName = "@weapon_name:knife_stone_noob",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/default_weapon.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0,

	weaponEffect = "bolt",
	weaponEffectIndex = 0
}

ObjectTemplates:addTemplate(object_weapon_melee_knife_shared_knife_stone_noob, 1606995338)

object_weapon_melee_knife_shared_knife_survival = SharedWeaponObjectTemplate:new {
	appearanceFilename = "appearance/wp_mle_knife_survival.apt",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/hold_r.iff",
	attackType = 1,

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/weapon/client_melee_knife.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 0,
	customizationVariableMapping = {},

	detailedDescription = "@weapon_detail:knife_survival",

	gameObjectType = 131079,

	locationReservationRadius = 0,
	lookAtText = "@weapon_lookat:knife_survival",

	noBuildRadius = 0,

	objectName = "@weapon_name:knife_survival",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/default_weapon.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0,

	weaponEffect = "bolt",
	weaponEffectIndex = 0
}

ObjectTemplates:addTemplate(object_weapon_melee_knife_shared_knife_survival, 530531036)

object_weapon_melee_knife_shared_knife_vibroblade = SharedWeaponObjectTemplate:new {
	appearanceFilename = "appearance/wp_mle_sword_vibroblade.apt",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/hold_r.iff",
	attackType = 1,

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/weapon/client_melee_small_edged_vibro.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 0,
	customizationVariableMapping = {},

	detailedDescription = "@weapon_detail:knife_vibroblade",

	gameObjectType = 131079,

	locationReservationRadius = 0,
	lookAtText = "@weapon_lookat:knife_vibroblade",

	noBuildRadius = 0,

	objectName = "@weapon_name:knife_vibroblade",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/default_weapon.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0,

	weaponEffect = "bolt",
	weaponEffectIndex = 0
}

ObjectTemplates:addTemplate(object_weapon_melee_knife_shared_knife_vibroblade, 4211610935)

object_weapon_melee_knife_shared_knife_vibroblade_quest = SharedWeaponObjectTemplate:new {
	appearanceFilename = "appearance/wp_mle_sword_vibroblade.apt",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/hold_r.iff",
	attackType = 1,

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/weapon/client_melee_small_edged_vibro.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 0,
	customizationVariableMapping = {},

	detailedDescription = "@weapon_detail:knife_vibroblade_quest",

	gameObjectType = 131079,

	locationReservationRadius = 0,
	lookAtText = "@weapon_lookat:knife_vibroblade",

	noBuildRadius = 0,

	objectName = "@weapon_name:knife_vibroblade_quest",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/default_weapon.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0,

	weaponEffect = "bolt",
	weaponEffectIndex = 0
}

ObjectTemplates:addTemplate(object_weapon_melee_knife_shared_knife_vibroblade_quest, 3270607602)
