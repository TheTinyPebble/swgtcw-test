tusken_raid_hunter = Creature:new {
	objectName = "Tusken raid hunter",
	socialGroup = "Tusken Raider",
	pvpFaction = "Tusken Raider",
	faction = "",
	level = 51,
	chanceHit = 0.510000,
	damageMin = 400,
	damageMax = 510,
	baseXp = 5007,
	baseHAM = 10000-13000,
	armor = 0,
	resists = {30,30,0,30,-1,30,0,0,-1},
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
	creatureBitmask = PACK + KILLER + STALKER,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {"tusken_weapons"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(tusken_raid_hunter, "tusken_raid_hunter")