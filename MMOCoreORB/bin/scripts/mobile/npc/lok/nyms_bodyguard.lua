nyms_bodyguard = Creature:new {
	objectName = "@mob/creature_names:nym_bodyguard",
	socialGroup = "Nym",
	pvpFaction = "Nym",
	faction = "",
	level = 28,
	chanceHit = 0.37,
	damageMin = 260,
	damageMax = 270,
	baseXp = 2914,
	baseHAM = 8100,
	baseHAMmax = 9900,
	armor = 1,
	resists = {15,15,15,15,40,15,-1,-1,-1},
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

	templates = {"object/mobile/dressed_nym_bodyguard_rod_m.iff"},
	lootGroups = {},
	weapons = {"rebel_weapons_medium"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(nyms_bodyguard, "nyms_bodyguard")