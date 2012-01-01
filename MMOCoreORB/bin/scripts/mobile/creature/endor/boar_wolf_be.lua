boar_wolf_be = Creature:new {
	objectName = "@mob/creature_names:boar_wolf_be",
	socialGroup = "Boar Wolf",
	pvpFaction = "",
	faction = "",
	level = 1,
	chanceHit = 0.2,
	damageMin = 30,
	damageMax = 40,
	baseXp = 40,
	baseHAM = 50,
	baseHAMmax = 50,
	armor = 0,
	resists = {0,0,0,0,0,0,0,0,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE,
	creatureBitmask = PACK,
	optionsBitmask = 128,
	diet = CARNIVORE,

	templates = {"object/mobile/boar_wolf_hue.iff"},
	lootgroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(boar_wolf_be, "boar_wolf_be")