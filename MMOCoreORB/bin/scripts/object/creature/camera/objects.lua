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


object_creature_camera_shared_intro_camera = SharedCreatureObjectTemplate:new {
	acceleration = {6,2},
	animationMapFilename = "all_male.map",
	appearanceFilename = "appearance/intro_camera.sat",
	arrangementDescriptors = {},

	cameraHeight = 0,
	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 255,
	collisionActionPassFlags = 0,
	collisionHeight = 1.8,
	collisionLength = 1.5,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	collisionOffsetX = 0,
	collisionOffsetZ = 0,
	collisionRadius = 0.5,
	containerType = 1,
	containerVolumeLimit = 0,
	customizationVariableMapping = {},

	detailedDescription = "@theme_park_detail:intro_camera",

	gameObjectType = 1025,
	gender = 2,

	locationReservationRadius = 0,
	lookAtText = "@theme_park_lookat:intro_camera",

	movementDatatable = "datatables/movement/movement_human.iff",

	niche = 5,
	noBuildRadius = 0,

	objectName = "@theme_park_name:intro_camera",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",
	postureAlignToTerrain = {0,0,1,0,0,1,0,1,0,0,0,0,1,1,1},

	race = 0,
	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slopeModAngle = 15,
	slopeModPercent = 0.1,
	slotDescriptors = {"inventory", "default_weapon"},
	snapToTerrain = 1,
	socketDestinations = {},
	species = 0,
	speed = {6,2},
	stepHeight = 0.5,
	structureFootprintFileName = "",
	surfaceType = 0,
	swimHeight = 1,

	targetable = 1,
	turnRate = {90,180},

	useStructureFootprintOutline = 0,

	warpTolerance = 17,
	waterModPercent = 0.5,

	clientObjectCRC = 2217042692
}

ObjectTemplates:addTemplate(object_creature_camera_shared_intro_camera, 2217042692)

object_creature_camera_shared_intro_controller = SharedCreatureObjectTemplate:new {
	acceleration = {6,2},
	animationMapFilename = "all_male.map",
	appearanceFilename = "appearance/intro_controller.sat",
	arrangementDescriptors = {},

	cameraHeight = 0,
	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "clientdata/client_shared_intro_controller.cdf",
	collisionActionBlockFlags = 0,
	collisionActionFlags = 255,
	collisionActionPassFlags = 0,
	collisionHeight = 1.8,
	collisionLength = 1.5,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	collisionOffsetX = 0,
	collisionOffsetZ = 0,
	collisionRadius = 0.5,
	containerType = 1,
	containerVolumeLimit = 0,
	customizationVariableMapping = {},

	detailedDescription = "@theme_park_detail:intro_controller",

	gameObjectType = 1025,
	gender = 2,

	locationReservationRadius = 0,
	lookAtText = "@theme_park_lookat:intro_controller",

	movementDatatable = "datatables/movement/movement_human.iff",

	niche = 5,
	noBuildRadius = 0,

	objectName = "@theme_park_name:intro_controller",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",
	postureAlignToTerrain = {0,0,1,0,0,1,0,1,0,0,0,0,1,1,1},

	race = 0,
	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slopeModAngle = 15,
	slopeModPercent = 0.1,
	slotDescriptors = {"inventory", "default_weapon"},
	snapToTerrain = 1,
	socketDestinations = {},
	species = 0,
	speed = {6,2},
	stepHeight = 0.5,
	structureFootprintFileName = "",
	surfaceType = 0,
	swimHeight = 1,

	targetable = 1,
	turnRate = {90,180},

	useStructureFootprintOutline = 0,

	warpTolerance = 17,
	waterModPercent = 0.5,

	clientObjectCRC = 1416223243
}

ObjectTemplates:addTemplate(object_creature_camera_shared_intro_controller, 1416223243)
