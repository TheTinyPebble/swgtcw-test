panshee_elder = Creature:new {
	objectName = "@mob/creature_names:panshee_elder",
	socialGroup = "Panshee Tribe",
	pvpFaction = "Panshee Tribe",
	faction = "",
	level = 46,
	chanceHit = 0.48,
	damageMin = 375,
	damageMax = 460,
	baseXp = 4461,
	baseHAM = 9800,
	baseHAMmax = 12000,
	armor = 1,
	resists = {30,30,0,-1,0,0,-1,0,-1},
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

	templates = {"object/mobile/dressed_ewok_m_10.iff"},
	lootGroups = {},
	weapons = {"ewok_weapons"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(panshee_elder, "panshee_elder")