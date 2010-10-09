ancient_reptilian_flier = Creature:new {
	templateType = NPCCREATURE,
	gameObjectType = 1024,
	objectName = "ancient reptilian flier",
	socialGroup = "Reptilian Flier",
	pvpFaction = "",
	faction = "",
	level = 25,
	chanceHit = 0.350000,
	damageMin = 230,
	damageMax = 240,
	range = 0,
	baseXp = 2543,
	baseHAM = 5550,
	armor = 0,
	resists = {20,30,0,50,50,-1,50,-1,-1},
	meatType = "meat_avian",
	meatAmount = 135,
	hideType = "hide_leathery",
	hideAmount = 90,
	boneType = "bone_avian",
	boneAmount = 85,
	milk = 0.000000,
	tamingChance = 0.250000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = PACK,
	diet = CARNIVORE,

	templates = {},
	weapons = {},
	attacks = {
		{"blindattack","blindChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(ancient_reptilian_flier, "ancient_reptilian_flier")
