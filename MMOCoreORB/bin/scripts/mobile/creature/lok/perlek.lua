perlek = Creature:new {
	objectName = "@monster_name:perlek",
	socialGroup = "Perlek",
	pvpFaction = "",
	faction = "",
	level = 14,
	chanceHit = 0.300000,
	damageMin = 140,
	damageMax = 150,
	range = 25,
	baseXp = 714,
	baseHAM = 1700,
	armor = 0,
	resists = {5,25,0,0,0,0,0,-1,-1},
	meatType = "meat_avian",
	meatAmount = 250,
	hideType = "hide_leathery",
	hideAmount = 100,
	boneType = "bone_avian",
	boneAmount = 175,
	milk = 0,
	tamingChance = 0.250000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = STALKER + PACK,
	diet = CARNIVORE,

	templates = {},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"intimidationattack","intimidationChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(perlek, "perlek")
