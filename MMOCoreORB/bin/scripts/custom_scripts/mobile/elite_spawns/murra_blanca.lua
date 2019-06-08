murra_blanca = Creature:new {
	customName = "murra blanca kahmurra",
	socialGroup = "kahmurra",
	faction = "",
	level = 150,
	chanceHit = 30.0,
	damageMin = 1570,
	damageMax = 2250,
	baseXp = 28549,
	baseHAM = 110000,
	baseHAMmax = 121000,
	armor = 2,
	resists = {65,65,65,175,175,175,175,175,65},
	meatType = "meat_herbivore",
	meatAmount = 200,
	hideType = "hide_bristley",
	hideAmount = 150,
	boneType = "bone_mammal",
	boneAmount = 180,
	milk = 0,
	tamingChance = 0,
	ferocity = 30,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,
	scale = 1.5,

	templates = {"object/mobile/murra_blanca.iff"},
	hues = {},
	lootGroups = {
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"intimidationattack","stateAccuracyBonus=70"},
		{"stunattack","stateAccuracyBonus=70"},
		{"blindattack","stateAccuracyBonus=70"}
	}
}

CreatureTemplates:addCreatureTemplate(murra_blanca, "murra_blanca")
