great_squill = Creature:new {
	objectName = "@mob/creature_names:great_squill",
	socialGroup = "Squill",
	pvpFaction = "",
	faction = "",
	level = 20,
	chanceHit = 0.33,
	damageMin = 200,
	damageMax = 210,
	baseXp = 1609,
	baseHAM = 5400,
	baseHAMmax = 6600,
	armor = 0,
	resists = {10,10,10,10,-1,-1,10,-1,-1},
	meatType = "meat_carnivore",
	meatAmount = 6,
	hideType = "hide_leathery",
	hideAmount = 6,
	boneType = "bone_mammal",
	boneAmount = 5,
	milk = 0,
	tamingChance = 0.05,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE,
	creatureBitmask = PACK + STALKER,
	optionsBitmask = 128,
	diet = CARNIVORE,

	templates = {"object/mobile/squill.iff"},
	lootgroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"stunattack","stunChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(great_squill, "great_squill")