neo_cobral_bandit = Creature:new {
	objectName = "Neo-Cobral bandit",
	socialGroup = "Cobral",
	pvpFaction = "Cobral",
	faction = "",
	level = 20,
	chanceHit = 0.330000,
	damageMin = 200,
	damageMax = 210,
	baseXp = 1609,
	baseHAM = 4500-5500,
	armor = 0,
	resists = {10,10,0,25,25,25,25,-1,-1},
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
	weapons = {"ranged_weapons"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(neo_cobral_bandit, "neo_cobral_bandit")