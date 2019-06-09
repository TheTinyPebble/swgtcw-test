gurreck_brute = Creature:new {
	customName = "a gurreck brute",
	socialGroup = "gurreck",
	faction = "",
	level = 55,
	chanceHit = 0.55,
	damageMin = 535,
	damageMax = 685,
	baseXp = 5025,
	baseHAM = 11000,
	baseHAMmax = 13000,
	armor = 1,
	resists = {135,135,-1,155,155,-1,155,-1,-1},
	meatType = "meat_carnivore",
	meatAmount = 75,
	hideType = "hide_wooly",
	hideAmount = 45,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/gurreck_hue.iff"},
	hues = { 24, 25, 26, 27, 28, 29, 30, 31 },
	controlDeviceTemplate = "",
	scale = 1.15,
	lootGroups = {
		{
			groups = {
				{group = "gurreck_unmounted_trophy", chance = 10000000},
			},
			lootChance = 10000000
		},
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"posturedownattack",""},
		{"intimidationattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(gurreck_brute, "gurreck_brute")
