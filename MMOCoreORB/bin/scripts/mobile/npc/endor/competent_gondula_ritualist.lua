competent_gondula_ritualist = Creature:new {
	objectName = "@mob/creature_names:competent_gundula_ritualist",
	socialGroup = "Condula Tribe",
	pvpFaction = "Condula Tribe",
	faction = "",
	level = 17,
	chanceHit = 0.32,
	damageMin = 150,
	damageMax = 170,
	baseXp = 1102,
	baseHAM = 3500,
	baseHAMmax = 4300,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
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

	templates = {"object/mobile/dulok_male.iff"},
	lootGroups = {},
	weapons = {"ewok_weapons"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(competent_gondula_ritualist, "competent_gondula_ritualist")