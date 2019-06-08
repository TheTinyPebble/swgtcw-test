scorpion_kliknik = Creature:new {
	customName = "scorpion kliknik",
	socialGroup = "kliknik",
	faction = "",
	level = 150,
	chanceHit = 30.0,
	damageMin = 1570,
	damageMax = 2250,
	baseXp = 28549,
	baseHAM = 110000,
	baseHAMmax = 121000,
	armor = 2,
	resists = {175,175,165,175,175,65,65,65,65},
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
	scale = 1.5,

	templates = {"object/mobile/scorpion_kliknik.iff"},
	hues = {},
	lootGroups = {
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"posturedownattack","stateAccuracyBonus=50"},
		{"intimidationattack","stateAccuracyBonus=50"},
		{"dizzyattack","stateAccuracyBonus=50"},
		{"strongpoison",""}
	}
}

CreatureTemplates:addCreatureTemplate(scorpion_kliknik, "scorpion_kliknik")
