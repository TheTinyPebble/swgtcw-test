lieutenant_heb_nee = Creature:new {
	objectName = "@mob/creature_names:lieutenant_heb_nee",
	socialGroup = "Rorgungan",
	pvpFaction = "Rorgungan",
	faction = "",
	level = 50,
	chanceHit = 0.500000,
	damageMin = 395,
	damageMax = 500,
	baseXp = 4916,
	baseHAM = 10000-12000,
	armor = 0,
	resists = {30,30,0,40,0,10,0,-1,-1},
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
	creatureBitmask = PACK + KILLER + HERD,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {"lt._heb_nee's_weapons"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(lieutenant_heb_nee, "lieutenant_heb_nee")