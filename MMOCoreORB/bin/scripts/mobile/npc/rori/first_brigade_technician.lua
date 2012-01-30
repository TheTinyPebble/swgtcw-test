first_brigade_technician = Creature:new {
	objectName = "@mob/creature_names:brigade_technician",
	socialGroup = "Restuss",
	pvpFaction = "Restuss",
	faction = "",
	level = 11,
	chanceHit = 0.29,
	damageMin = 120,
	damageMax = 130,
	baseXp = 430,
	baseHAM = 1000,
	baseHAMmax = 1200,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + HERD,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {},
	lootGroups = {},
	weapons = {"rebel_weapons_light"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(first_brigade_technician, "first_brigade_technician")