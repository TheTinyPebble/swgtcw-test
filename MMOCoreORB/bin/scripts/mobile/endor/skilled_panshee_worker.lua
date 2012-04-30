skilled_panshee_worker = Creature:new {
	objectName = "@mob/creature_names:skilled_panshee_worker",
	socialGroup = "Panshee Tribe",
	pvpFaction = "Panshee Tribe",
	faction = "",
	level = 36,
	chanceHit = 0.42,
	damageMin = 325,
	damageMax = 360,
	baseXp = 3551,
	baseHAM = 8900,
	baseHAMmax = 10900,
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

CreatureTemplates:addCreatureTemplate(skilled_panshee_worker, "skilled_panshee_worker")