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


object_ship_player_shared_player_awing = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/awing_body.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_awing"},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/ship/client_shared_awing.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_awing",

	noBuildRadius = 0,

	objectName = "@space_ship:player_awing",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_awing, 2823165423)

object_ship_player_shared_player_basic_hutt_light = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/hutt_fighter_light_body_s01.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_lighthuttfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_hutt_light_s01.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_basic_hutt_light",

	noBuildRadius = 0,

	objectName = "@space_ship:player_basic_hutt_light",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_basic_hutt_light, 770455739)

object_ship_player_shared_player_basic_tiefighter = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/tie_fighter.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_tiefighterlight"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_tiefighter.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_basic_tiefighter",

	noBuildRadius = 0,

	objectName = "@space_ship:player_basic_tiefighter",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_basic_tiefighter, 2430870087)

object_ship_player_shared_player_basic_z95 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/z95_body.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_z95headhunter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_z95.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_basic_z95",

	noBuildRadius = 0,

	objectName = "@space_ship:player_basic_z95",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_basic_z95, 960125460)

object_ship_player_shared_player_blacksun_heavy_s01 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/black_sun_fighter_heavy_body_s01.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_heavyblacksunfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_blacksun_heavy_s01.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_blacksun_heavy_s01",

	noBuildRadius = 0,

	objectName = "@space_ship:player_blacksun_heavy_s01",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_blacksun_heavy_s01, 2406012699)

object_ship_player_shared_player_blacksun_heavy_s02 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/black_sun_fighter_heavy_body_s01.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_heavyblacksunfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_blacksun_heavy_s02.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_blacksun_heavy_s02",

	noBuildRadius = 0,

	objectName = "@space_ship:player_blacksun_heavy_s02",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_blacksun_heavy_s02, 1417641868)

object_ship_player_shared_player_blacksun_heavy_s03 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/black_sun_fighter_heavy_body_s02.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_heavyblacksunfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_blacksun_heavy_s03.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_blacksun_heavy_s03",

	noBuildRadius = 0,

	objectName = "@space_ship:player_blacksun_heavy_s03",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_blacksun_heavy_s03, 494016513)

object_ship_player_shared_player_blacksun_heavy_s04 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/black_sun_fighter_heavy_body_s02.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_heavyblacksunfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_blacksun_heavy_s04.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_blacksun_heavy_s04",

	noBuildRadius = 0,

	objectName = "@space_ship:player_blacksun_heavy_s04",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_blacksun_heavy_s04, 3868275477)

object_ship_player_shared_player_blacksun_light_s01 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/black_sun_fighter_light_body_s01.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_lightblacksunfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_blacksun_light_s01.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_blacksun_light_s01",

	noBuildRadius = 0,

	objectName = "@space_ship:player_blacksun_light_s01",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_blacksun_light_s01, 2468301121)

object_ship_player_shared_player_blacksun_light_s02 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/black_sun_fighter_light_body_s01.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_lightblacksunfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_blacksun_light_s02.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_blacksun_light_s02",

	noBuildRadius = 0,

	objectName = "@space_ship:player_blacksun_light_s02",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_blacksun_light_s02, 1208541654)

object_ship_player_shared_player_blacksun_light_s03 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/black_sun_fighter_light_body_s02.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_lightblacksunfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_blacksun_light_s03.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_blacksun_light_s03",

	noBuildRadius = 0,

	objectName = "@space_ship:player_blacksun_light_s03",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_blacksun_light_s03, 17139291)

object_ship_player_shared_player_blacksun_light_s04 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/black_sun_fighter_light_body_s02.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_lightblacksunfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_blacksun_light_s04.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_blacksun_light_s04",

	noBuildRadius = 0,

	objectName = "@space_ship:player_blacksun_light_s04",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_blacksun_light_s04, 4209421647)

object_ship_player_shared_player_blacksun_medium_s01 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/black_sun_fighter_medium_body_s01.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_mediumblacksunfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_blacksun_medium_s01.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_blacksun_medium_s01",

	noBuildRadius = 0,

	objectName = "@space_ship:player_blacksun_medium_s01",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_blacksun_medium_s01, 2060411448)

object_ship_player_shared_player_blacksun_medium_s02 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/black_sun_fighter_medium_body_s01.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_mediumblacksunfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_blacksun_medium_s02.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_blacksun_medium_s02",

	noBuildRadius = 0,

	objectName = "@space_ship:player_blacksun_medium_s02",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_blacksun_medium_s02, 2715339439)

object_ship_player_shared_player_blacksun_medium_s03 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/black_sun_fighter_medium_body_s02.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_mediumblacksunfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_blacksun_medium_s03.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_blacksun_medium_s03",

	noBuildRadius = 0,

	objectName = "@space_ship:player_blacksun_medium_s03",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_blacksun_medium_s03, 3906317602)

object_ship_player_shared_player_blacksun_medium_s04 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/black_sun_fighter_medium_body_s02.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_mediumblacksunfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_blacksun_medium_s04.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_blacksun_medium_s04",

	noBuildRadius = 0,

	objectName = "@space_ship:player_blacksun_medium_s04",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_blacksun_medium_s04, 322340406)

object_ship_player_shared_player_bwing = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/bwing_cockpit_pod.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_bwing"},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/ship/client_shared_bwing.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_bwing",

	noBuildRadius = 0,

	objectName = "@space_ship:player_bwing",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_bwing, 3129407218)

object_ship_player_shared_player_corvette = SharedShipObjectTemplate:new {
	appearanceFilename = "",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/ship/client_shared_yt1300.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "string_id_table",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_corvette",

	noBuildRadius = 0,

	objectName = "@space_ship:player_corvette",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "appearance/corellian_corvette_pob.pob",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_corvette, 1738437900)

object_ship_player_shared_player_decimator = SharedShipObjectTemplate:new {
	appearanceFilename = "",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_decimator"},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/ship/client_shared_decimator.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "string_id_table",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_decimator",

	noBuildRadius = 0,

	objectName = "@space_ship:player_decimator",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "appearance/vt49.pob",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_decimator, 3150522393)

object_ship_player_shared_player_firespray = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/kse_firespray_body.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_firespray"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_firespray.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_firespray",

	noBuildRadius = 0,

	objectName = "@space_ship:player_firespray",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_firespray, 4073039210)

object_ship_player_shared_player_hutt_heavy_s01 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/hutt_fighter_heavy_body_s01.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_heavyhuttfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_hutt_heavy_s01.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_hutt_heavy_s01",

	noBuildRadius = 0,

	objectName = "@space_ship:player_hutt_heavy_s01",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_hutt_heavy_s01, 354676203)

object_ship_player_shared_player_hutt_heavy_s02 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/hutt_fighter_heavy_body_s02.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_heavyhuttfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_hutt_heavy_s02.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_hutt_heavy_s02",

	noBuildRadius = 0,

	objectName = "@space_ship:player_hutt_heavy_s02",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_hutt_heavy_s02, 3459532156)

object_ship_player_shared_player_hutt_light_s01 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/hutt_fighter_light_body_s01.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_lighthuttfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_hutt_light_s01.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_hutt_light_s01",

	noBuildRadius = 0,

	objectName = "@space_ship:player_hutt_light_s01",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_hutt_light_s01, 156529585)

object_ship_player_shared_player_hutt_light_s02 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/hutt_fighter_light_body_s02.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_lighthuttfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_hutt_light_s02.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_hutt_light_s02",

	noBuildRadius = 0,

	objectName = "@space_ship:player_hutt_light_s02",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_hutt_light_s02, 3527662374)

object_ship_player_shared_player_hutt_medium_s01 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/hutt_fighter_medium_body_s01.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_mediumhuttfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_hutt_medium_s01.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_hutt_medium_s01",

	noBuildRadius = 0,

	objectName = "@space_ship:player_hutt_medium_s01",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_hutt_medium_s01, 996310896)

object_ship_player_shared_player_hutt_medium_s02 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/hutt_fighter_medium_body_s02.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_mediumhuttfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_hutt_medium_s02.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_hutt_medium_s02",

	noBuildRadius = 0,

	objectName = "@space_ship:player_hutt_medium_s02",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_hutt_medium_s02, 3765819367)

object_ship_player_shared_player_hutt_turret_ship = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/hutt_fighter_heavy_body_s03.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_hutt_turret_ship"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_hutt_turret_ship.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_hutt_turret_ship",

	noBuildRadius = 0,

	objectName = "@space_ship:player_hutt_turret_ship",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid", "ship_gunner1"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_hutt_turret_ship, 2830008910)

object_ship_player_shared_player_prototype_hutt_light = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/hutt_fighter_light_body_s01.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_lighthuttfighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_hutt_light_s01.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_prototype_hutt_light",

	noBuildRadius = 0,

	objectName = "@space_ship:player_prototype_hutt_light",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_prototype_hutt_light, 1541926498)

object_ship_player_shared_player_prototype_tiefighter = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/tie_fighter.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_tiefighterlight"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_tiefighter.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_prototype_tiefighter",

	noBuildRadius = 0,

	objectName = "@space_ship:player_prototype_tiefighter",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_prototype_tiefighter, 3874485406)

object_ship_player_shared_player_prototype_z95 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/z95_body.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_z95headhunter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_z95.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_prototype_z95",

	noBuildRadius = 0,

	objectName = "@space_ship:player_prototype_z95",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_prototype_z95, 4125787031)

object_ship_player_shared_player_sorosuub_space_yacht = SharedShipObjectTemplate:new {
	appearanceFilename = "",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/ship/client_shared_sorosuub_space_yacht.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "string_id_table",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_sorosuub_space_yacht",

	noBuildRadius = 0,

	objectName = "@space_ship:player_sorosuub_space_yacht",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "appearance/sorosuub_space_yacht.pob",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_sorosuub_space_yacht, 4077746601)

object_ship_player_shared_player_tie_in = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/tie_fighter_in.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_tiefighterin"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_tiefighter.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_tie_in",

	noBuildRadius = 0,

	objectName = "@space_ship:player_tie_in",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_tie_in, 500982809)

object_ship_player_shared_player_tie_light_duty = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/tie_fighter.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_tiefighterlight"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_tiefighter.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_tie_light_duty",

	noBuildRadius = 0,

	objectName = "@space_ship:player_tie_light_duty",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_tie_light_duty, 349740221)

object_ship_player_shared_player_tieadvanced = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/tie_advanced.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_tieadvanced"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_tieadvanced.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_tieadvanced",

	noBuildRadius = 0,

	objectName = "@space_ship:player_tieadvanced",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_tieadvanced, 537219045)

object_ship_player_shared_player_tieaggressor = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/tie_aggressor.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_tieadvanced"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_tieaggressor.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_tieaggressor",

	noBuildRadius = 0,

	objectName = "@space_ship:player_tieaggressor",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid", "ship_gunner1"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_tieaggressor, 3313666579)

object_ship_player_shared_player_tiebomber = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/tie_bomber_b.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_tiebomber"},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/ship/client_shared_tiebomber.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_tiebomber",

	noBuildRadius = 0,

	objectName = "@space_ship:player_tiebomber",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_tiebomber, 1403833964)

object_ship_player_shared_player_tiefighter = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/tie_fighter.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_tiefighter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_tiefighter.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_tiefighter",

	noBuildRadius = 0,

	objectName = "@space_ship:player_tiefighter",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_tiefighter, 1253337464)

object_ship_player_shared_player_tieinterceptor = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/tie_interceptor.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_tieinterceptor"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_tieinterceptor.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_tieinterceptor",

	noBuildRadius = 0,

	objectName = "@space_ship:player_tieinterceptor",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_tieinterceptor, 4021866633)

object_ship_player_shared_player_tieoppressor = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/tie_oppressor.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_tieoppressor"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_tieoppressor.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_tieoppressor",

	noBuildRadius = 0,

	objectName = "@space_ship:player_tieoppressor",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_tieoppressor, 3411039109)

object_ship_player_shared_player_xwing = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/xwing_body.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_xwing"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_xwing.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_xwing",

	noBuildRadius = 0,

	objectName = "@space_ship:player_xwing",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_xwing, 3426854753)

object_ship_player_shared_player_ykl37r = SharedShipObjectTemplate:new {
	appearanceFilename = "",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_ykl37r"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_ykl37r.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "string_id_table",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_ykl37r",

	noBuildRadius = 0,

	objectName = "@space_ship:player_ykl37r",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "appearance/ykl37r.pob",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_ykl37r, 4283603432)

object_ship_player_shared_player_yt1300 = SharedShipObjectTemplate:new {
	appearanceFilename = "",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_yt1300"},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/ship/client_shared_yt1300.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "string_id_table",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_yt1300",

	noBuildRadius = 0,

	objectName = "@space_ship:player_yt1300",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "appearance/yt1300.pob",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_yt1300, 2643423122)

object_ship_player_shared_player_yt1300_decorated_01 = SharedShipObjectTemplate:new {
	appearanceFilename = "",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_yt1300"},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/ship/client_shared_yt1300.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "string_id_table",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_yt1300",

	noBuildRadius = 0,

	objectName = "@space_ship:player_yt1300",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "appearance/yt1300.pob",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_yt1300_decorated_01, 3619233988)

object_ship_player_shared_player_ywing = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/ywing_body.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_ywing"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_ywing.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_ywing",

	noBuildRadius = 0,

	objectName = "@space_ship:player_ywing",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid", "ship_gunner1"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_ywing, 1044450567)

object_ship_player_shared_player_ywing_longprobe = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/ywing_body.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_ywinglongprobe"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_ywing.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_ywing_longprobe",

	noBuildRadius = 0,

	objectName = "@space_ship:player_ywing_longprobe",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_ywing_longprobe, 711184758)

object_ship_player_shared_player_z95 = SharedShipObjectTemplate:new {
	appearanceFilename = "appearance/z95_body.apt",
	arrangementDescriptor = "ship_control_device",

	certificationsRequired = {"cert_starships_z95headhunter"},
	clearFloraRadius = 0,
	clientDataFile = "clientData/ship/client_shared_z95.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "",

	gameObjectType = 536870913,

	locationReservationRadius = 0,
	lookAtText = "@space_ship:player_z95",

	noBuildRadius = 0,

	objectName = "@space_ship:player_z95",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptor = {"ship_pilot", "ship_droid"},
	snapToTerrain = 0,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_ship_player_shared_player_z95, 3298750759)
