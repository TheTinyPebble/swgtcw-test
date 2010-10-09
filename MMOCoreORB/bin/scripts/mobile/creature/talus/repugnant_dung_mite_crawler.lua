repugnant_dung_mite_crawler = Creature:new {
	templateType = NPCCREATURE,
	gameObjectType = 1024,
	objectName = "@mob/creature_names:dung_mite_repugnant_crawler",
	socialGroup = "Decay Mite",
	pvpFaction = "",
	faction = "",
	level = 7,
	chanceHit = 0.260000,
	damageMin = 80,
	damageMax = 90,
	range = 0,
	baseXp = 187,
	baseHAM = 150,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
	meatType = "meat_insect",
	meatAmount = 9,
	hideType = "hide_scaley",
	hideAmount = 6,
	boneType = "bone_",
	boneAmount = 0,
	milk = 0.000000,
	tamingChance = 0.050000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = PACK + HERD,
	diet = CARNIVORE,

	templates = {},
	weapons = {},
	attacks = {
		{"dizzyattack","dizzyChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(repugnant_dung_mite_crawler, "repugnant_dung_mite_crawler")
