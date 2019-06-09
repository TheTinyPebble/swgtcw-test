alpha_slice_hound = Creature:new {
	customName = "an alpha slice hound",
	socialGroup = "slice_hound",
	faction = "",
	level = 17,
	chanceHit = 0.34,
	damageMin = 180,
	damageMax = 220,
	baseXp = 931,
	baseHAM = 1500,
	baseHAMmax = 1900,
	armor = 0,
	resists = {105,115,0,0,0,0,0,-1,-1},
	meatType = "meat_carnivore",
	meatAmount = 65,
	hideType = "hide_bristley",
	hideAmount = 35,
	boneType = "bone_mammal",
	boneAmount = 30,
	milk = 0,
	tamingChance = 0,
	ferocity = 7,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + HERD + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/female_grassland_slice_hound.iff"},
	hues = { 24, 25, 26, 27, 28, 29, 30, 31 },
	controlDeviceTemplate = "",
	scale = 1.15,
	lootGroups = {
		{
			groups = {
				{group = "slice_hound_unmounted_trophy", chance = 10000000},
			},
			lootChance = 10000000
		},
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"intimidationattack",""},
		{"posturedownattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(alpha_slice_hound, "alpha_slice_hound")
