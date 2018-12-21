rep_jedi_master = Creature:new {
	objectName = "@mob/creature_names:rep_jedi_master",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "self",
	faction = "imperial",
	level = 100,
	chanceHit = 27.25,
	damageMin = 1645,
	damageMax = 3000,
	baseXp = 25266,
	baseHAM = 151060,
	baseHAMmax = 185020,
	armor = 3,
	resists = {90,90,90,90,90,90,90,90,45},
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

CreatureTemplates:addCreatureTemplate(rep_jedi_master, "rep_jedi_master")
