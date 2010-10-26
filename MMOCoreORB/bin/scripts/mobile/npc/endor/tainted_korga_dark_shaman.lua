tainted_korga_dark_shaman = Creature:new {
	objectName = "@mob/creature_names:tainted_korga_dark_shaman",
	socialGroup = "Korga Tribe",
	pvpFaction = "Korga Tribe",
	faction = "",
	level = 24,
	chanceHit = 0.350000,
	damageMin = 220,
	damageMax = 230,
	baseXp = 2543,
	baseHAM = 6300-7700,
	armor = 0,
	resists = {20,20,0,50,50,-1,0,-1,-1},
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

CreatureTemplates:addCreatureTemplate(tainted_korga_dark_shaman, "tainted_korga_dark_shaman")