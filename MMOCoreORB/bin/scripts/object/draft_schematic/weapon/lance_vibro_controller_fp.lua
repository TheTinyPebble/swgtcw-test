--Copyright (C) 2010 <SWGEmu>


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


object_draft_schematic_weapon_lance_vibro_controller_fp = object_draft_schematic_weapon_shared_lance_vibro_controller_fp:new {

   templateType = DRAFTSCHEMATIC,

   customObjectName = "Lance",

   groupName = "craftWeaponMeleeGroupB", -- Group schematic is awarded in (See skills table)

   craftingToolTab = 1, -- (See DraftSchemticImplementation.h)
   complexity = 25, 
   size = 5, 

   xpType = "crafting_weapons_general", 
   xp = 100, 

   assemblySkill = "weapon_assembly", 
   experimentingSkill = "weapon_experimentation", 
   customizationSkill = "weapon_customization", 

   customizationOptions = {},
   customizationStringNames = {},
   customizationDefaults = {},

   ingredientTemplateNames = {"craft_weapon_ingredients_n", "craft_weapon_ingredients_n", "craft_weapon_ingredients_n", "craft_weapon_ingredients_n"},
   ingredientTitleNames = {"staff_shaft", "vibro_unit_and_power_cell_brackets", "power_circuits", "vibration_generator"},
   ingredientSlotType = {0, 0, 2, 2},
   resourceTypes = {"metal_nonferrous", "metal", "object/tangible/component/item/shared_electronic_control_unit.iff", "object/tangible/component/weapon/shared_vibro_unit.iff"},
   resourceQuantities = {17, 27, 1, 1},
   combineTypes = {0, 0, 1, 1},
   contribution = {100, 100, 100, 100},

   numberExperimentalProperties = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   experimentalProperties = {"XX", "XX", "SR", "SR", "SR", "SR", "SR", "SR", "SR", "XX", "SR", "XX", "SR", "SR", "SR"},
   experimentalWeights = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   experimentalGroupTitles = {"null", "null", "expDamage", "expDamage", "expDamage", "expDamage", "exp_durability", "expRange", "expRange", "null", "expRange", "null", "expEffeciency", "expEffeciency", "expEffeciency"},
   experimentalSubGroupTitles = {"null", "null", "mindamage", "maxdamage", "attackspeed", "woundchance", "hitpoints", "zerorangemod", "maxrangemod", "midrange", "midrangemod", "maxrange", "attackhealthcost", "attackactioncost", "attackmindcost"},
   experimentalMin = {0, 0, 7, 133, 7, 9, 750, 5, 5, 3, 5, 5, 26, 59, 29},
   experimentalMax = {0, 0, 13, 247, 4, 18, 1500, 15, 15, 3, 15, 5, 14, 32, 15},
   experimentalPrecision = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},

   tanoCRC = 3892633613, -- Script: 'object/weapon/melee/polearm/lance_controllerfp.iff'
}
ObjectTemplates:addTemplate(object_draft_schematic_weapon_lance_vibro_controller_fp, "object/draft_schematic/weapon/lance_vibro_controller_fp.iff")
