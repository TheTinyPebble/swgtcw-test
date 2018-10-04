rep_jedi_knight = Creature:new {
	objectName = "@mob/creature_names:rep_jedi_knight",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "self",
	faction = "imperial",
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
	optionsBitmask = AIENABLED + CONVERSABLE,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dressed_jedi_knight_01.iff",
		"object/mobile/dressed_jedi_knight_02.iff",
		"object/mobile/dressed_neja_bertolo.iff"
		},

	lootGroups = {},
	weapons = {"light_jedi_weapons_basic"},
	conversationTemplate = "imperialRecruiterConvoTemplate",
	attacks = merge(lightsabermaster,forcepowermaster)
}

CreatureTemplates:addCreatureTemplate(rep_jedi_knight, "rep_jedi_knight")
