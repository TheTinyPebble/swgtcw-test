object_draft_schematic_clothing_clothing_hat_singing_mtn_02 = object_draft_schematic_clothing_shared_clothing_hat_singing_mtn_02:new {

   templateType = DRAFTSCHEMATIC,

   customObjectName = "Cryo Lance",

   craftingToolTab = 1, -- (See DraftSchematicObjectTemplate.h)
   complexity = 30,
   size = 4,

   xpType = "crafting_clothings_general",
   xp = 130,

   assemblySkill = "clothing_assembly",
   experimentingSkill = "clothing_experimentation",
   customizationSkill = "clothing_customization",

   customizationOptions = {},
   customizationStringNames = {},
   customizationDefaults = {},

   ingredientTemplateNames = {"craft_clothing_ingredients_n", "craft_clothing_ingredients_n", "craft_clothing_ingredients_n", "craft_clothing_ingredients_n"},
   ingredientTitleNames = {"lance_shaft", "vibro_unit_and_power_cell_brackets", "grip", "vibration_generator"},
   ingredientSlotType = {0, 0, 0, 1},
   resourceTypes = {"steel_ditanium", "copper_polysteel", "metal", "object/tangible/component/clothing/shared_vibro_unit_nightsister.iff"},
   resourceQuantities = {38, 17, 6, 1},
   contribution = {100, 100, 100, 100},


   targetTemplate = "object/clothing/melee/polearm/clothing_hat_singing_mtn_02.iff",

   additionalTemplates = {
             }

}
ObjectTemplates:addTemplate(object_draft_schematic_clothing_clothing_hat_singing_mtn_02, "object/draft_schematic/clothing/clothing_hat_singing_mtn_02.iff")
