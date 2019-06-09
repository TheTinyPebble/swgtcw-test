verne_matriarch = Creature:new {
	customName = "a verne matriarch",
	socialGroup = "verne",
	faction = "",
	level = 22,
	chanceHit = 0.34,
	damageMin = 220,
	damageMax = 280,
	baseXp = 1526,
	baseHAM = 4500,
	baseHAMmax = 5500,
	armor = 0,
	resists = {10,10,10,-1,-1,135,135,-1,-1},
	meatType = "meat_wild",
	meatAmount = 110,
	hideType = "hide_leathery",
	hideAmount = 95,
	boneType = "bone_mammal",
	boneAmount = 85,
	milkType = "milk_wild",
	milk = 85,
	tamingChance = 0.25,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/verne_hue.iff"},
	hues = { 8, 9, 10, 11, 12, 13, 14, 15 },
	controlDeviceTemplate = "",
	scale = 1.1,
	lootGroups = {
		{
			groups = {
				{group = "verne_unmounted_trophy", chance = 10000000},
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

CreatureTemplates:addCreatureTemplate(verne_matriarch, "verne_matriarch")
