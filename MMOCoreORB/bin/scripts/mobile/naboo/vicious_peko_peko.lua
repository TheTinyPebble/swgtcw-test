vicious_peko_peko = Creature:new {
	custom_name = "a vicious peko peko",
	socialGroup = "peko",
	faction = "",
	level = 28,
	chanceHit = 0.35,
	damageMin = 285,
	damageMax = 370,
	baseXp = 2419,
	baseHAM = 5900,
	baseHAMmax = 7200,
	armor = 0,
	resists = {15,130,155,-1,-1,155,-1,-1,-1},
	meatType = "meat_avian",
	meatAmount = 155,
	hideType = "hide_wooly",
	hideAmount = 70,
	boneType = "bone_avian",
	boneAmount = 45,
	milk = 0,
	tamingChance = 0,
	ferocity = 8,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/giant_peko_peko.iff"},
	hues = { 0, 1, 2, 3, 4, 5, 6, 7 },
	scale = 1.55,
	lootGroups = {
		{
			groups = {
				{group = "peko_peko_unmounted_trophy", chance = 10000000},
			},
			lootChance = 10000000
		},
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"dizzyattack",""},
		{"stunattack",""},
		{"intimidationattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(vicious_peko_peko, "vicious_peko_peko")
