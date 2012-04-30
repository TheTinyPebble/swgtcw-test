masterful_panshee_warrior = Creature:new {
	objectName = "@mob/creature_names:masterful_panshee_warrior",
	socialGroup = "Panshee Tribe",
	pvpFaction = "Panshee Tribe",
	faction = "",
	level = 42,
	chanceHit = 0.450000,
	damageMin = 355,
	damageMax = 420,
	baseXp = 4188,
	baseHAM = 9500,
	baseHAMmax = 11600,
	armor = 0,
	resists = {0,0,0,0,0,0,0,0,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + KILLER,
	diet = HERBIVORE,

	templates = {},
	lootGroups = {},
	weapons = {"ewok_weapons"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(masterful_panshee_warrior, "masterful_panshee_warrior")