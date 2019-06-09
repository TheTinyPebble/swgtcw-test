kliknik_champion = Creature:new {
	customName = "a kliknik champion",
	socialGroup = "kliknik",
	faction = "",
	level = 42,
	chanceHit = 0.44,
	damageMin = 360,
	damageMax = 430,
	baseXp = 4097,
	baseHAM = 9000,
	baseHAMmax = 11000,
	armor = 0,
	resists = {155,145,150,150,150,-1,-1,-1,-1},
	meatType = "meat_carnivore",
	meatAmount = 7,
	hideType = "hide_scaley",
	hideAmount = 4,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/kliknik_hue.iff"},
	hues = { 8, 9, 10, 11, 12, 13, 14, 15 },
	controlDeviceTemplate = "",
	scale = 1.3,
	lootGroups = {
		{
			groups = {
				{group = "kliknik_unmounted_trophy", chance = 10000000},
			},
			lootChance = 10000000
		},
	},
	weapons = {"creature_spit_small_yellow"},
	conversationTemplate = "",
	attacks = {
		{"mildpoison",""},
		{"intimidationattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(kliknik_champion, "kliknik_champion")
