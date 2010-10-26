selonian_separatist = Creature:new {
	objectName = "@mob/creature_names:selonian_separatist",
	socialGroup = "Selonian",
	pvpFaction = "",
	faction = "",
	level = 7,
	chanceHit = 0.260000,
	damageMin = 70,
	damageMax = 75,
	baseXp = 187,
	baseHAM = 270-330,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
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
	creatureBitmask = PACK,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {"rebel_weapons_medium"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(selonian_separatist, "selonian_separatist")