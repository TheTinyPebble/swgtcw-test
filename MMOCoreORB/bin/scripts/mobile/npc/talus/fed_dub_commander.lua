fed_dub_commander = Creature:new {
	objectName = "@mob/creature_names:fed_dub_commander",
	socialGroup = "Fed Dub",
	pvpFaction = "Fed Dub",
	faction = "",
	level = 23,
	chanceHit = 0.340000,
	damageMin = 200,
	damageMax = 210,
	baseXp = 2219,
	baseHAM = 5400-6600,
	armor = 0,
	resists = {0,30,0,40,-1,40,-1,-1,-1},
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
	creatureBitmask = PACK + HERD,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {""},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(fed_dub_commander, "fed_dub_commander")