rebel_recruiter = Creature:new {
	objectName = "@mob/creature_names:rebel_recruiter",
	socialGroup = "Rebel",
	pvpFaction = "Rebel",
	faction = "",
	level = 20,
	chanceHit = 0.330000,
	damageMin = 190,
	damageMax = 200,
	baseXp = 1426,
	baseHAM = 5000-6100,
	armor = 0,
	resists = {0,0,0,40,-1,40,-1,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = NONE,
	creatureBitmask = NONE,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {""},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(rebel_recruiter, "rebel_recruiter")