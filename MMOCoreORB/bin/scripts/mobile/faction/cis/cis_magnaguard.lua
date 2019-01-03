cis_magnaguard = Creature:new {
	objectName = "@mob/creature_names:cis_magnaguard",
	customName = "A Magnaguard",
	socialGroup = "self",
	faction = "rebel",
	level = 30,
	chanceHit = 3,
	damageMin = 645,
	damageMax = 1000,
	baseXp = 45,
	baseHAM = 21060,
	baseHAMmax = 23520,
	armor = 1,
	resists = {45,45,45,45,45,45,45,45,45},
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
	optionsBitmask = AIENABLED + FACTIONAGGRO,
	diet = HERBIVORE,

	templates = {
		"object/mobile/magnaguard.iff"
	},
	lootGroups = {},
	weapons = {"magnaguard_weapons"},
	conversationTemplate = "",
	attacks = merge(lightsabermaster,pikemanmaster)
}

CreatureTemplates:addCreatureTemplate(cis_magnaguard, "cis_magnaguard")
