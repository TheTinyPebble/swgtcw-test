painted_spat = Creature:new {
	customName = "painted spat",
	socialGroup = "carrion_spat",
	faction = "",
	level = 150,
	chanceHit = 30.0,
	damageMin = 1570,
	damageMax = 2250,
	baseXp = 28549,
	baseHAM = 110000,
	baseHAMmax = 121000,
	armor = 2,
	resists = {65,65,65,175,175,65,65,65,65},
	meatType = "meat_avian",
	meatAmount = 360,
	hideType = "",
	hideAmount = 0,
	boneType = "bone_avian",
	boneAmount = 280,
	milk = 0,
	tamingChance = 0,
	ferocity = 30,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,
	scale = 1.5,

	templates = {"object/mobile/painted_spat.iff"},
	hues = {},
	lootGroups = {
		{
			groups = {
				{group = "painted_spat_trophy", chance = 10000000},
			},
			lootChance = 10000000
		},
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"intimidationattack","stateAccuracyBonus=70"},
		{"stunattack","stateAccuracyBonus=70"},
		{"blindattack","stateAccuracyBonus=70"}
	}
}

CreatureTemplates:addCreatureTemplate(painted_spat, "painted_spat")
