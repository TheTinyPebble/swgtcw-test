spiketail_blurrg = Creature:new {
	customName = "spiketail blurrg",
	socialGroup = "blurrg",
	faction = "",
	level = 150,
	chanceHit = 30.0,
	damageMin = 1570,
	damageMax = 2250,
	baseXp = 28549,
	baseHAM = 110000,
	baseHAMmax = 121000,
	armor = 2,
	resists = {170,170,170,170,170,170,170,170,170},
	meatType = "meat_carnivore",
	meatAmount = 200,
	hideType = "hide_leathery",
	hideAmount = 180,
	boneType = "bone_avian",
	boneAmount = 150,
	milk = 0,
	tamingChance = 0,
	ferocity = 30,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,
	scale = 1.7,

	templates = {"object/mobile/spiketail_blurrg.iff"},
	hues = {},
	lootGroups = {
		{
			groups = {
				{group = "spiketail_blurrg_trophy", chance = 10000000},
			},
			lootChance = 10000000
		},
	},
	weapons = {"creature_spit_small_yellow"},
	conversationTemplate = "",
	attacks = {
		{"intimidationattack","stateAccuracyBonus=70"},
		{"stunattack","stateAccuracyBonus=70"},
		{"blindattack","stateAccuracyBonus=70"}
	}
}

CreatureTemplates:addCreatureTemplate(spiketail_blurrg, "spiketail_blurrg")
