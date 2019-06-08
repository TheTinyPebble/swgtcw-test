bane_back_spider = Creature:new {
	customName = "bane back spider",
	socialGroup = "spider",
	faction = "",
	level = 150,
	chanceHit = 30.0,
	damageMin = 1570,
	damageMax = 2250,
	baseXp = 28549,
	baseHAM = 110000,
	baseHAMmax = 121000,
	armor = 2,
	resists = {175,175,175,165,65,55,65,65,65},
	meatType = "meat_insect",
	meatAmount = 200,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 30,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,
	scale = 2,

	templates = {"object/mobile/bane_back_spider.iff"},
	hues = {},
	lootGroups = {
		{
			groups = {
				{group = "bane_back_spider_trophy", chance = 10000000},
			},
			lootChance = 10000000
		},
	},
	weapons = {"creature_spit_small_yellow"},
	conversationTemplate = "",
	attacks = {
		{"knockdownattack","stateAccuracyBonus=100"},
		{"dizzyattack","stateAccuracyBonus=50"},
		{"strongpoison",""}
	}
}

CreatureTemplates:addCreatureTemplate(bane_back_spider, "bane_back_spider")
