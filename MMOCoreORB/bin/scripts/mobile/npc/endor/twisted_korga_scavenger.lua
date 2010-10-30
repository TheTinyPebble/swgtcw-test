twisted_korga_scavenger = Creature:new {
	objectName = "@mob/creature_names:twisted_korga_scavenger",
	socialGroup = "Korga Tribe",
	pvpFaction = "Korga Tribe",
	faction = "",
	level = 26,
	chanceHit = 0.350000,
	damageMin = 250,
	damageMax = 260,
	baseXp = 2730,
	baseHAM = 5900,
	baseHAMmax = 7200,
	armor = 0,
	resists = {25,25,0,50,50,-1,0,-1,-1},
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

CreatureTemplates:addCreatureTemplate(twisted_korga_scavenger, "twisted_korga_scavenger")