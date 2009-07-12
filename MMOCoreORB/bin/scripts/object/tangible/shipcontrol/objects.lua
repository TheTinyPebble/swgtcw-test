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


object_tangible_shipcontrol_shared_pilot_chair = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/frn_all_chair_metal_s1.apt",
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
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@space_item:pilot_chair",

	gameObjectType = 8228,

	locationReservationRadius = 0,
	lookAtText = "string_id_table",

	noBuildRadius = 0,

	objectName = "@space_item:pilot_chair",
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

ObjectTemplates:addTemplate(object_tangible_shipcontrol_shared_pilot_chair, 3541722217)

object_tangible_shipcontrol_shared_shipcontrol_corvette = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/frn_spc_chair_pilot_s02.apt",
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
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@space/space_item:shipcontrol_corvette",

	gameObjectType = 8228,

	locationReservationRadius = 0,
	lookAtText = "string_id_table",

	noBuildRadius = 0,

	objectName = "@space/space_item:shipcontrol_corvette",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {"ship_pilot_pob", "ship_droid"},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_shipcontrol_shared_shipcontrol_corvette, 543526931)

object_tangible_shipcontrol_shared_shipcontrol_falcon = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/frn_spc_chair_pilot_s01.apt",
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
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@space/space_item:shipcontrol_falcon",

	gameObjectType = 8228,

	locationReservationRadius = 0,
	lookAtText = "string_id_table",

	noBuildRadius = 0,

	objectName = "@space/space_item:shipcontrol_falcon",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {"ship_pilot_pob", "ship_droid"},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_shipcontrol_shared_shipcontrol_falcon, 362033500)

object_tangible_shipcontrol_shared_shipoperations_falcon = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/frn_spc_chair_pilot_s01.apt",
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
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@space/space_item:shipoperations_falcon",

	gameObjectType = 8229,

	locationReservationRadius = 0,
	lookAtText = "string_id_table",

	noBuildRadius = 0,

	objectName = "@space/space_item:shipoperations_falcon",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {"ship_operations_pob"},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_shipcontrol_shared_shipoperations_falcon, 752872042)

object_tangible_shipcontrol_shared_turretcontrol_falcon = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/yt1300_ladder.apt",
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
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@space/space_item:turretcontrol_falcon",

	gameObjectType = 8230,

	locationReservationRadius = 0,
	lookAtText = "string_id_table",

	noBuildRadius = 0,

	objectName = "@space/space_item:turretcontrol_falcon",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {"ship_gunner0_pob", "ship_gunner1_pob"},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_shipcontrol_shared_turretcontrol_falcon, 3238239508)

object_tangible_shipcontrol_shared_turretcontrol_vt49 = SharedTangibleObjectTemplate:new {
	appearanceFilename = "appearance/vt49_ladder.apt",
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
	containerType = 1,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@space/space_item:turretcontrol_falcon",

	gameObjectType = 8230,

	locationReservationRadius = 0,
	lookAtText = "string_id_table",

	noBuildRadius = 0,

	objectName = "@space/space_item:turretcontrol_falcon",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptors = {"ship_gunner0_pob", "ship_gunner1_pob"},
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,

	useStructureFootprintOutline = 0
}

ObjectTemplates:addTemplate(object_tangible_shipcontrol_shared_turretcontrol_vt49, 315011154)
