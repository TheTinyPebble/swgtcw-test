choku_jungle_terror = Creature:new {
	customName = "a choku jungle terror",
	socialGroup = "choku",
	faction = "",
	level = 24,
	chanceHit = 0.34,
	damageMin = 230,
	damageMax = 305,
	baseXp = 2003,
	baseHAM = 6000,
	baseHAMmax = 7500,
	armor = 0,
	resists = {115,15,15,15,15,15,15,-1,-1},
	meatType = "meat_avian",
	meatAmount = 10,
	hideType = "",
	hideAmount = 0,
	boneType = "bone_avian",
	boneAmount = 8,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + PACK + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/choku_hue.iff"},
	hues = { 0, 1, 2, 3, 4, 5, 6, 7 },
	controlDeviceTemplate = "",
	scale = 1.3,
	lootGroups = {
		{
			groups = {
				{group = "choku_unmounted_trophy", chance = 10000000},
			},
			lootChance = 10000000
		},
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"stunattack",""},
		{"intimidationattack",""},
	}
}

CreatureTemplates:addCreatureTemplate(choku_jungle_terror, "choku_jungle_terror")
