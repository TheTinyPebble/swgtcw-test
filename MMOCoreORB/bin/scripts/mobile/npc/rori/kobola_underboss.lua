kobola_underboss = Creature:new {
	objectName = "@mob/creature_names:kobola_underboss",
	socialGroup = "Kobola",
	pvpFaction = "Kobola",
	faction = "",
	level = 25,
	chanceHit = 0.36,
	damageMin = 210,
	damageMax = 220,
	baseXp = 2637,
	baseHAM = 5900,
	baseHAMmax = 7200,
	armor = 0,
	resists = {35,35,0,-1,0,0,-1,-1,-1},
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

	templates = {"object/mobile/dressed_kobola_underboss_bith_female_01.iff"},
	lootGroups = {},
	weapons = {"pirate_weapons_heavy"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(kobola_underboss, "kobola_underboss")