naive_condula_workling = Creature:new {
	objectName = "@mob/creature_names:naive_gondula_workling",
	socialGroup = "Gondula Tribe",
	pvpFaction = "Gondula Tribe",
	faction = "",
	level = 9,
	chanceHit = 0.27,
	damageMin = 70,
	damageMax = 75,
	baseXp = 292,
	baseHAM = 405,
	baseHAMmax = 495,
	armor = 0,
	resists = {15,15,0,10,10,0,0,-1,-1},
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
	creatureBitmask = PACK,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {},
	lootGroups = {},
	weapons = {"ewok_weapons"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(naive_condula_workling, "naive_condula_workling")