gnarled_pubam_spiritmaster = Creature:new {
	objectName = "@mob/creature_names:gnarled_pubam_spiritmaster",
	socialGroup = "Pubam",
	pvpFaction = "Pubam",
	faction = "",
	level = 31,
	chanceHit = 0.390000,
	damageMin = 290,
	damageMax = 300,
	baseXp = 3188,
	baseHAM = 8900,
	baseHAMmax = 10900,
	armor = 0,
	resists = {0,0,0,40,40,-1,-1,-1,-1},
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

CreatureTemplates:addCreatureTemplate(gnarled_pubam_spiritmaster, "gnarled_pubam_spiritmaster")