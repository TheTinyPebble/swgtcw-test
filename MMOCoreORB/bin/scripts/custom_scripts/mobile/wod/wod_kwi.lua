wod_kwi = Creature:new {
	customName = "Temporary Name: WOD Kwi",
	socialGroup = "kwi",
	faction = "",
	level = 141,
	chanceHit = 6.25,
	damageMin = 945,
	damageMax = 1600,
	baseXp = 13367,
	baseHAM = 62000,
	baseHAMmax = 75000,
	armor = 2,
	resists = {20,20,20,20,20,20,20,20,20},
	meatType = "meat_carnivore",
	meatAmount = 50,
	hideType = "hide_leathery",
	hideAmount = 40,
	boneType = "bone_avian",
	boneAmount = 35,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/wod_kwi.iff"},
	hues = {},
	scale = 1.35,
	lootGroups = {},
	weapons = {"creature_spit_small_yellow"},
	conversationTemplate = "",
	attacks = {
		{"stunattack",""},
		{"blindattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(wod_kwi, "wod_kwi")
