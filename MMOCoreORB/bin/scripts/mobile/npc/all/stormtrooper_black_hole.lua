stormtrooper_black_hole = Creature:new {
	objectName = "Stormtrooper Black Hole",
	socialGroup = "Imperial",
	pvpFaction = "Imperial",
	faction = "",
	level = 27,
	chanceHit = 0.370000,
	damageMin = 260,
	damageMax = 270,
	baseXp = 2822,
	baseHAM = 8100-9900,
	armor = 0,
	resists = {0,0,0,-1,30,-1,30,-1,-1},
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
	creatureBitmask = PACK + KILLER,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {"stormtrooper_weapons"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(stormtrooper_black_hole, "stormtrooper_black_hole")