giant_worrt = Creature:new {
	templateType = NPCCREATURE,
	gameObjectType = 1024,
	objectName = "@mob/creature_names:giant_worrt",
	socialGroup = "Worrt",
	pvpFaction = "",
	faction = "",
	level = 13,
	chanceHit = 0.300000,
	damageMin = 140,
	damageMax = 150,
	range = 0,
	baseXp = 514,
	baseHAM = 1700,
	armor = 0,
	resists = {0,0,0,0,0,10,0,-1,-1},
	meatType = "meat_reptilian",
	meatAmount = 9,
	hideType = "hide_leathery",
	hideAmount = 9,
	boneType = "bone_mammal",
	boneAmount = 4,
	milk = 0,
	tamingChance = 0.250000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = NONE,
	diet = CARNIVORE,

	templates = {},
	weapons = {},
	attacks = {
		{"stunattack","stunChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(giant_worrt, "giant_worrt")
