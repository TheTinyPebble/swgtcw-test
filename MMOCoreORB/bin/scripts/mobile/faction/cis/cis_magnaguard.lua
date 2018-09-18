cis_magnaguard = Creature:new {
	objectName = "@mob/creature_names:light_jedi_sentinel",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "self",
	faction = "rebel",
	level = 30,
	chanceHit = 3,
	damageMin = 645,
	damageMax = 1000,
	baseXp = 45,
	baseHAM = 11060,
	baseHAMmax = 13520,
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
	weapons = {"light_jedi_weapons"},
	conversationTemplate = "imperialRecruiterConvoTemplate",
	attacks = merge(lightsabermaster)
}

CreatureTemplates:addCreatureTemplate(cis_magnaguard, "cis_magnaguard")
