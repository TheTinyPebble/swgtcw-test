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


object_draft_schematic_munition_mine_dxr55 = object_draft_schematic_munition_shared_mine_dxr55:new {

   groupName = "craftMunitionsGroupB", -- Group schematic is awarded in (See skills table)

   craftingToolTab = 1, -- (See DraftSchemticImplementation.h)
   complexity = 20, 
   size = 3, 

   xpType = "crafting_weapons_general", 
   xp = 35, 

   assemblySkill = "weapon_assembly", 
   experimentingSkill = "weapon_experimentation", 

   ingredientTemplateNames = {"craft_munition_ingredients_n", "craft_munition_ingredients_n", "craft_munition_ingredients_n", "craft_munition_ingredients_n", "craft_munition_ingredients_n", "craft_munition_ingredients_n", "craft_munition_ingredients_n", "craft_munition_ingredients_n", "craft_munition_ingredients_n"},
   ingredientTitleNames = {"weapon_casing", "trigger_mechanism", "warhead_compartment", "grounding_pile", "warhead_insulator", "warhead_assembly", "null_field_generator", "warhead_fusing", "warhead_booster"},
   ingredientSlotType = {0, 0, 0, 0, 0, 2, 2, 2, 4},
   resourceTypes = {"metal", "petrochem_inert_polymer", "ore_carbonate", "steel_thoranium", "ore_siliclastic_crism", "object/tangible/component/munition/shared_warhead_medium.iff", "object/tangible/component/munition/shared_warhead_stabilizer.iff", "object/tangible/component/munition/shared_warhead_fusing_mechanism.iff", "object/tangible/component/munition/shared_enhanced_destructive_pulse_channeling.iff"},
   resourceQuantities = {10, 1, 2, 15, 3, 1, 1, 1, 1},
   combineTypes = {0, 0, 0, 0, 0, 1, 1, 1, 1},
   contribution = {100, 100, 100, 100, 100, 100, 100, 100, 100},

   numberExperimentalProperties = {1, 1, 2, 2, 2, 2, 1},
   experimentalProperties = {"XX", "XX", "SR", "UT", "SR", "UT", "SR", "UT", "SR", "UT", "XX"},
   experimentalWeights = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   experimentalGroupTitles = {"null", "null", "expDamage", "expDamage", "expDamage", "expDamage", "null"},
   experimentalSubGroupTitles = {"null", "null", "mindamage", "maxdamage", "attackspeed", "woundchance", "hitpoints"},
   experimentalMin = {0, 0, 35, 105, 5, 7, 1000},
   experimentalMax = {0, 0, 65, 195, 3, 13, 1000},
   experimentalPrecision = {0, 0, 0, 0, 0, 0, 0},

   tanoCRC = 4243010094, -- Script: 'object/weapon/mine/wp_mine_drx55.iff'
}
ObjectTemplates:addTemplate(object_draft_schematic_munition_mine_dxr55, "object/draft_schematic/munition/mine_dxr55.iff")
