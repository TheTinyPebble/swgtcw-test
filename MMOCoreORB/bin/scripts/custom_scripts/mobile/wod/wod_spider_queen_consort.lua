wod_spider_queen_consort = Creature:new {
	customName = "Temporary Name: Spider Queen consort",
	socialGroup = "spider_queen",
	faction = "",
	level = 336,
	chanceHit = 30.0,
	damageMin = 2270,
	damageMax = 3250,
	baseXp = 28549,
	baseHAM = 210000,
	baseHAMmax = 251000,
	armor = 2,
	resists = {195,195,195,195,165,195,195,195,175},
	meatType = "meat_insect",
	meatAmount = 500,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 30,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,
	scale = 1,

	templates = {"object/mobile/spider_queen_consort.iff"},
	hues = {},
	lootGroups = {
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"creatureareacombo","stateAccuracyBonus=100"},
		{"creatureareaknockdown","stateAccuracyBonus=100"}
	}
}

CreatureTemplates:addCreatureTemplate(wod_spider_queen_consort, "wod_spider_queen_consort")
