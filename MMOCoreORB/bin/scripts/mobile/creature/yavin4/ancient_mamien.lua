ancient_mamien = Creature:new {
	templateType = NPCCREATURE,
	gameObjectType = 1024,
	objectName = "@mob/creature_names:mamien_ancient",
	socialGroup = "Mamien",
	pvpFaction = "",
	faction = "",
	level = 24,
	chanceHit = 0.340000,
	damageMin = 200,
	damageMax = 210,
	range = 0,
	baseXp = 2543,
	baseHAM = 7000,
	armor = 0,
	resists = {20,35,0,0,0,0,0,-1,-1},
	meatType = "meat_wild",
	meatAmount = 20,
	hideType = "hide_wooly",
	hideAmount = 20,
	boneType = "bone_mammal",
	boneAmount = 20,
	milk = 0.000000,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = KILLER + PACK + HERD,
	diet = CARNIVORE,

	templates = {},
	weapons = {},
	attacks = {
		{"dizzyattack","dizzyChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(ancient_mamien, "ancient_mamien")
