nyms_destroyer = Creature:new {
	objectName = "@mob/creature_names:nym_destroyer",
	socialGroup = "Nym",
	pvpFaction = "Nym",
	faction = "",
	level = 40,
	chanceHit = 0.43,
	damageMin = 355,
	damageMax = 420,
	baseXp = 4006,
	baseHAM = 9100,
	baseHAMmax = 11100,
	armor = 1,
	resists = {15,15,15,15,60,15,-1,-1,-1},
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
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_nym_destroyer_rod_m.iff"},
	lootGroups = {},
	weapons = {"rebel_weapons_medium"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(nyms_destroyer, "nyms_destroyer")