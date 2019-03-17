object_draft_schematic_furniture_wod_ns_potted_plant_scem_08 = object_draft_schematic_furniture_shared_wod_ns_potted_plant_scem_08:new {
	templateType = DRAFTSCHEMATIC,

	customObjectName = "Potted Plant Style VIII",

	craftingToolTab = 512, -- (See DraftSchematicObjectTemplate.h)
	complexity = 15,
	size = 2,
	factoryCrateSize = 10,

	xpType = "crafting_structure_general",
	xp = 160,

	assemblySkill = "structure_assembly",
	experimentingSkill = "structure_experimentation",
	customizationSkill = "structure_customization",

	customizationOptions = {},
	customizationStringNames = {},
	customizationDefaults = {},

	ingredientTemplateNames = {"craft_furniture_ingredients_n", "craft_furniture_ingredients_n", "craft_furniture_ingredients_n"},
	ingredientTitleNames = {"pot", "tree", "greenery"},
	ingredientSlotType = {0, 0, 0},
	resourceTypes = {"mineral", "wood", "chemical"},
	resourceQuantities = {30, 30, 20},
	contribution = {100, 100, 100},

	targetTemplate = "object/tangible/furniture/decorative/wod_ns_potted_plant_08.iff",

	additionalTemplates = {}

}
ObjectTemplates:addTemplate(object_draft_schematic_furniture_wod_ns_potted_plant_scem_08, "object/draft_schematic/furniture/wod_ns_potted_plant_scem_08.iff")
