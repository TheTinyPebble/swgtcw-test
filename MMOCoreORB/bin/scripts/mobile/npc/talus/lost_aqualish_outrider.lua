lost_aqualish_outrider = Creature:new {
	objectName = "@mob/creature_names:lost_aqualish_outrider",
	socialGroup = "Lost Aql. Reg.",
	pvpFaction = "Lost Aql. Reg.",
	faction = "",
	level = 12,
	chanceHit = 0.290000,
	damageMin = 130,
	damageMax = 140,
	baseXp = 514,
	baseHAM = 1200-1400,
	armor = 0,
	resists = {0,0,0,0,15,0,0,-1,-1},
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
	weapons = {"pirate_weapons_medium"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(lost_aqualish_outrider, "lost_aqualish_outrider")