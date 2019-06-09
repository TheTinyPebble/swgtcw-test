zucca_boar_devourer = Creature:new {
	customName = "a zucca boar devourer",
	socialGroup = "boar",
	faction = "",
	level = 55,
	chanceHit = 0.55,
	damageMin = 455,
	damageMax = 600,
	baseXp = 5116,
	baseHAM = 10000,
	baseHAMmax = 12000,
	armor = 1,
	resists = {115,145,115,5,5,5,5,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 90,
	hideType = "hide_leathery",
	hideAmount = 80,
	boneType = "bone_mammal",
	boneAmount = 75,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/zucca_boar_hue.iff"},
	hues = { 16, 17, 18, 19, 20, 21, 22, 23 },
	controlDeviceTemplate = "",
	scale = 1.3,
	lootGroups = {
		{
			groups = {
				{group = "zucca_boar_unmounted_trophy", chance = 10000000},
			},
			lootChance = 10000000
		},
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"intimidationattack",""},
		{"stunattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(wild_dune_boar, "wild_dune_boar")
