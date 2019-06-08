finned_blaggart = Creature:new {
	customName = "finned blaggart",
	socialGroup = "snake",
	faction = "",
	level = 150,
	chanceHit = 30.0,
	damageMin = 1570,
	damageMax = 2250,
	baseXp = 28549,
	baseHAM = 110000,
	baseHAMmax = 121000,
	armor = 2,
	resists = {70,70,70,70,70,70,70,70,70},
	meatType = "meat_carnivore",
	meatAmount = 200,
	hideType = "hide_scaley",
	hideAmount = 150,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 30,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,
	scale = 1.8,

	templates = {"object/mobile/finned_blaggart.iff"},
	hues = {},
	lootGroups = {
		{
			groups = {
				{group = "finned_blaggart_trophy", chance = 10000000},
			},
			lootChance = 10000000
		},
	},
	weapons = {"creature_spit_small_toxicgreen"},
	conversationTemplate = "",
	attacks = {
		{"posturedownattack","stateAccuracyBonus=50"},
		{"intimidationattack","stateAccuracyBonus=50"},
		{"dizzyattack","stateAccuracyBonus=50"},
		{"strongpoison",""}
	}
}

CreatureTemplates:addCreatureTemplate(finned_blaggart, "finned_blaggart")
