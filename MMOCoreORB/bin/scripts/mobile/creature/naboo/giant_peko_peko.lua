giant_peko_peko = Creature:new {
	templateType = NPCCREATURE,
	gameObjectType = 1024,
	objectName = "@mob/creature_names:giant_peko_peko",
	socialGroup = "Giant Peko Peko",
	pvpFaction = "",
	faction = "",
	level = 23,
	chanceHit = 0.350000,
	damageMin = 210,
	damageMax = 220,
	range = 0,
	baseXp = 2219,
	baseHAM = 6550,
	armor = 0,
	resists = {0,25,50,-1,-1,50,-1,-1,-1},
	meatType = "meat_avian",
	meatAmount = 155,
	hideType = "hide_wooly",
	hideAmount = 70,
	boneType = "bone_avian",
	boneAmount = 45,
	milk = 0.000000,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + HERD,
	diet = CARNIVORE,

	templates = {},
	weapons = {},
	attacks = {
		{"dizzyattack","dizzyChance=50"},
		{"stunattack","stunChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(giant_peko_peko, "giant_peko_peko")
