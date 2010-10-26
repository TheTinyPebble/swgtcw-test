mokk_clan_primalist = Creature:new {
	objectName = "Mokk clan primalist",
	socialGroup = "Mokk Tribe",
	pvpFaction = "Mokk Tribe",
	faction = "",
	level = 47,
	chanceHit = 0.470000,
	damageMin = 370,
	damageMax = 450,
	baseXp = 4552,
	baseHAM = 10000-12000,
	armor = 0,
	resists = {15,50,0,-1,-1,60,60,-1,-1},
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
	creatureBitmask = PACK + HERD,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {"primitive_weapons"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(mokk_clan_primalist, "mokk_clan_primalist")