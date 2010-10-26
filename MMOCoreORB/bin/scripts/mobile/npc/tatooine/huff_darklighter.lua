huff_darklighter = Creature:new {
	objectName = "Huff darklighter",
	socialGroup = "Darklighter",
	pvpFaction = "",
	faction = "",
	level = 99,
	chanceHit = 0.990000,
	damageMin = 640,
	damageMax = 990,
	baseXp = 9243,
	baseHAM = 24000-29000,
	armor = 0,
	resists = {40,40,0,0,0,0,0,0,-1},
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
	creatureBitmask = HERD,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {"rebel_weapons_light"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(huff_darklighter, "huff_darklighter")