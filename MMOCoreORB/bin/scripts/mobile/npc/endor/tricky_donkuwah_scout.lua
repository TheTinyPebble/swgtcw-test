tricky_donkuwah_scout = Creature:new {
	objectName = "@mob/creature_names:tricky_donkuwah_scout",
	socialGroup = "Donkuwah Tr.",
	pvpFaction = "Donkuwah Tr.",
	faction = "",
	level = 31,
	chanceHit = 0.390000,
	damageMin = 300,
	damageMax = 310,
	baseXp = 3188,
	baseHAM = 8500-10300,
	armor = 0,
	resists = {0,40,-1,0,0,-1,0,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE + AGGRESSIVE,
	creatureBitmask = PACK + KILLER,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {""},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(tricky_donkuwah_scout, "tricky_donkuwah_scout")