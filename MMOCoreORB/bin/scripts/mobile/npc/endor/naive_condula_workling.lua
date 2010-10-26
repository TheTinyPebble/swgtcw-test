naive_condula_workling = Creature:new {
	objectName = "naive Condula workling",
	socialGroup = "Gondula Tribe",
	pvpFaction = "Gondula Tribe",
	faction = "",
	level = 9,
	chanceHit = 0.270000,
	damageMin = 70,
	damageMax = 75,
	baseXp = 292,
	baseHAM = 405-495,
	armor = 0,
	resists = {15,15,0,10,10,0,0,-1,-1},
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
	creatureBitmask = PACK,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {"ewok_weapons"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(naive_condula_workling, "naive_condula_workling")