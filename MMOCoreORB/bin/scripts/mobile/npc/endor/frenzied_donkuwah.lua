frenzied_donkuwah = Creature:new {
	objectName = "@mob/creature_names:frenzied_donkuwah",
	socialGroup = "Donkuwah Tr.",
	pvpFaction = "Donkuwah Tr.",
	faction = "",
	level = 39,
	chanceHit = 0.420000,
	damageMin = 365,
	damageMax = 440,
	baseXp = 3915,
	baseHAM = 9000-11000,
	armor = 0,
	resists = {40,0,0,50,50,-1,0,-1,-1},
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

CreatureTemplates:addCreatureTemplate(frenzied_donkuwah, "frenzied_donkuwah")