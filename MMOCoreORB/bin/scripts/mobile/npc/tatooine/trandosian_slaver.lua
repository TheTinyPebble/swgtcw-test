trandosian_slaver = Creature:new {
	objectName = "Trandosian slaver",
	socialGroup = "Slaver",
	pvpFaction = "",
	faction = "",
	level = 5,
	chanceHit = 0.250000,
	damageMin = 45,
	damageMax = 50,
	baseXp = 113,
	baseHAM = 135,
	baseHAMmax = 165,
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
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {"pirate_weapons_light"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(trandosian_slaver, "trandosian_slaver")