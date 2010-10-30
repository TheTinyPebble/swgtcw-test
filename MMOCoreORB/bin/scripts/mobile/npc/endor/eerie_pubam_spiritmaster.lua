eerie_pubam_spiritmaster = Creature:new {
	objectName = "@mob/creature_names:eerie_pubam_spiritmaster",
	socialGroup = "Pubam",
	pvpFaction = "Pubam",
	faction = "",
	level = 10,
	chanceHit = 0.280000,
	damageMin = 130,
	damageMax = 140,
	baseXp = 430,
	baseHAM = 675,
	baseHAMmax = 825,
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
	pvpBitmask = ATTACKABLE + AGGRESSIVE,
	creatureBitmask = PACK + KILLER,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {""},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(eerie_pubam_spiritmaster, "eerie_pubam_spiritmaster")