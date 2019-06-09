bocatt_piercer = Creature:new {
	customName = "a bocatt piercer",
	socialGroup = "bocatt",
	faction = "",
	level = 25,
	chanceHit = 0.37,
	damageMin = 270,
	damageMax = 360,
	baseXp = 2206,
	baseHAM = 6500,
	baseHAMmax = 8000,
	armor = 0,
	resists = {15,15,-1,-1,160,160,-1,-1,-1},
	meatType = "meat_reptilian",
	meatAmount = 100,
	hideType = "hide_leathery",
	hideAmount = 60,
	boneType = "bone_mammal",
	boneAmount = 35,
	milk = 0,
	tamingChance = 0,
	ferocity = 7,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + PACK + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/bocatt_hue.iff"},
	hues = { 0, 1, 2, 3, 4, 5, 6, 7 },
	controlDeviceTemplate = "",
	scale = 1.25,
	lootGroups = {
		{
			groups = {
				{group = "bocatt_unmounted_trophy", chance = 10000000},
			},
			lootChance = 10000000
		},
	},
	weapons = {"creature_spit_small_yellow"},
	conversationTemplate = "",
	attacks = {
		{"posturedownattack",""},
		{"stunattack",""},
		{"intimidationattack",""},
	}
}

CreatureTemplates:addCreatureTemplate(bocatt_piercer, "bocatt_piercer")
