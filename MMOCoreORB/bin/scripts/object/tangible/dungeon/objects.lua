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


object_tangible_dungeon_shared_cave_stalagmite_ice_style_01 = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/thm_all_cave_stalagmite_ice_a1.apt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/terminal/client_shared_terminal_geo_bunker.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@terminal_detail:terminal_power_switch",

	gameObjectType = 16396,

	locationReservationRadius = 0,
	lookAtText = "@terminal_lookat:nightsister_trap_crystal",

	noBuildRadius = 0,

	objectName = "@terminal_name:nightsister_trap_crystal",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_cave_stalagmite_ice_style_01, 1546847010)

object_tangible_dungeon_shared_chemical_storage = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/thm_prp_tank_gas.apt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 2,
	containerVolumeLimit = 20,
	customizationVariableMapping = {},

	detailedDescription = "@obj_d:chemical_reactor",

	gameObjectType = 8197,

	locationReservationRadius = 0,
	lookAtText = "@container_lookat:base_container",

	noBuildRadius = 0,

	objectName = "@obj_n:chemical_reactor",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_chemical_storage, 2171896668)

object_tangible_dungeon_shared_coal_bin_container = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/bunker_mine_bucket_s01.apt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 2,
	containerVolumeLimit = 20,
	customizationVariableMapping = {},

	detailedDescription = "@obj_d:coal_bin",

	gameObjectType = 8197,

	locationReservationRadius = 0,
	lookAtText = "@container_lookat:base_container",

	noBuildRadius = 0,

	objectName = "@obj_n:coal_bin",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_coal_bin_container, 1342811705)

object_tangible_dungeon_shared_computer_desktop = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/eqp_medic_medical_console.apt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@obj_d:computer_desktop",

	gameObjectType = 16396,

	locationReservationRadius = 0,
	lookAtText = "@terminal_lookat:base_terminal",

	noBuildRadius = 0,

	objectName = "@obj_n:computer_desktop",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_computer_desktop, 1483156059)

object_tangible_dungeon_shared_computer_mainframe = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/frn_tech_console_sectional_b.apt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@obj_d:computer_mainframe",

	gameObjectType = 16396,

	locationReservationRadius = 0,
	lookAtText = "@terminal_lookat:base_terminal",

	noBuildRadius = 0,

	objectName = "@obj_n:computer_mainframe",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_computer_mainframe, 2299324292)

object_tangible_dungeon_shared_droid_maint_module = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/eqp_repair_droids.apt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@obj_d:corvette_droid_maint_module",

	gameObjectType = 8211,

	locationReservationRadius = 0,
	lookAtText = "string_id_table",

	noBuildRadius = 0,

	objectName = "@obj_n:corvette_droid_maint_module",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_droid_maint_module, 3106365328)

object_tangible_dungeon_shared_keypad_terminal = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/eqp_keypad_door_s01.apt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/terminal/client_shared_terminal_geo_bunker.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@terminal_detail:keypad",

	gameObjectType = 16396,

	locationReservationRadius = 0,
	lookAtText = "@terminal_lookat:keyapd",

	noBuildRadius = 0,

	objectName = "@terminal_name:keypad",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_keypad_terminal, 307119363)

object_tangible_dungeon_shared_poison_gas_cloud = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/pt_miasma_of_fog_greenish.prt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 0,
	collisionMaterialBlockFlags = 1,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@obj_d:poison_gas_cloud",

	gameObjectType = 8203,

	locationReservationRadius = 0,
	lookAtText = "string_id_table",

	noBuildRadius = 0,

	objectName = "@obj_n:poison_gas_cloud",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {"crafted_components"},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_poison_gas_cloud, 1380579021)

object_tangible_dungeon_shared_poison_stabilizer = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/eqp_medic_antidote_sm_s1.apt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@obj_d:poison_stabilizer",

	gameObjectType = 8211,

	locationReservationRadius = 0,
	lookAtText = "string_id_table",

	noBuildRadius = 0,

	objectName = "@obj_n:poison_stabilizer",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {{"/private/index_color_1", "palette/item_meds.pal", 6}},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_poison_stabilizer, 2249389472)

object_tangible_dungeon_shared_terminal_free_s1 = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/frn_all_data_terminal_free_s3.apt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@terminal_detail:terminal_free_s1",

	gameObjectType = 16396,

	locationReservationRadius = 0,
	lookAtText = "@terminal_lookat:base_terminal",

	noBuildRadius = 0,

	objectName = "@terminal_name:terminal_free_s1",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_terminal_free_s1, 2707720646)

object_tangible_dungeon_shared_trash_container = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/poi_all_lair_trash_dark.apt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 2,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@obj_d:trash_container",

	gameObjectType = 8197,

	locationReservationRadius = 0,
	lookAtText = "@container_lookat:base_container",

	noBuildRadius = 0,

	objectName = "@obj_n:trash_container",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_trash_container, 1529401041)

object_tangible_dungeon_shared_wall_terminal_s1 = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/frn_all_data_terminal_wall_s1.apt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/terminal/client_shared_terminal_geo_bunker.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@terminal_detail:terminal_gas_valve",

	gameObjectType = 16396,

	locationReservationRadius = 0,
	lookAtText = "@terminal_lookat:terminal_gas_valve",

	noBuildRadius = 0,

	objectName = "@terminal_name:terminal_gas_valve",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_wall_terminal_s1, 4069617127)

object_tangible_dungeon_shared_wall_terminal_s2 = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/frn_all_data_terminal_wall_s2.apt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/terminal/client_shared_terminal_geo_bunker.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@terminal_detail:terminal_power_switch",

	gameObjectType = 16396,

	locationReservationRadius = 0,
	lookAtText = "@terminal_lookat:terminal_power_switch",

	noBuildRadius = 0,

	objectName = "@terminal_name:terminal_power_switch",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_wall_terminal_s2, 696698224)

object_tangible_dungeon_shared_wall_terminal_s3 = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/frn_all_data_terminal_wall_s3.apt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/terminal/client_shared_terminal_geo_bunker.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@terminal_detail:terminal_general_switch",

	gameObjectType = 16396,

	locationReservationRadius = 0,
	lookAtText = "@terminal_lookat:terminal_general_switch",

	noBuildRadius = 0,

	objectName = "@terminal_name:terminal_general_switch",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_wall_terminal_s3, 1619763965)

object_tangible_dungeon_shared_wall_terminal_s4 = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/frn_all_data_terminal_wall_s4.apt",
	arrangementDescriptors = {},

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/terminal/client_shared_terminal_geo_bunker.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@terminal_detail:terminal_power_switch",

	gameObjectType = 16396,

	locationReservationRadius = 0,
	lookAtText = "@terminal_lookat:terminal_power_switch",

	noBuildRadius = 0,

	objectName = "@terminal_name:terminal_power_switch",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_dungeon_shared_wall_terminal_s4, 2607319529)
