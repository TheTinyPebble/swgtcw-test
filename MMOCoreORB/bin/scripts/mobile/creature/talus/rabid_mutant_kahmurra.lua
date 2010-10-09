rabid_mutant_kahmurra = Creature:new {
	templateType = NPCCREATURE,
	gameObjectType = 1024,
	objectName = "@mob/creature_names:rabid_mutant_kahmurra",
	socialGroup = "Kahmurra",
	pvpFaction = "",
	faction = "",
	level = 41,
	chanceHit = 0.440000,
	damageMin = 345,
	damageMax = 400,
	range = 0,
	baseXp = 4097,
	baseHAM = 10300,
	armor = 0,
	resists = {0,0,0,45,45,45,45,35,-1},
	meatType = "meat_herbivore",
	meatAmount = 50,
	hideType = "hide_bristley",
	hideAmount = 30,
	boneType = "bone_mammal",
	boneAmount = 35,
	milk = 0.000000,
	tamingChance = 0.150000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = KILLER + PACK,
	diet = CARNIVORE,

	templates = {},
	weapons = {},
	attacks = {
		{"strongdisease",""},
		{"stunattack","stunChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(rabid_mutant_kahmurra, "rabid_mutant_kahmurra")
