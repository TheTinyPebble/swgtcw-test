ferine_razorfang = Creature:new {
	templateType = NPCCREATURE,
	gameObjectType = 1024,
	objectName = "@mob/creature_names:kima_ferine_razorfang",
	socialGroup = "Kima",
	pvpFaction = "",
	faction = "",
	level = 21,
	chanceHit = 0.320000,
	damageMin = 210,
	damageMax = 220,
	range = 0,
	baseXp = 2006,
	baseHAM = 3900,
	armor = 0,
	resists = {20,20,0,0,0,0,0,0,-1},
	meatType = "meat_herbivore",
	meatAmount = 7,
	hideType = "hide_bristley",
	hideAmount = 8,
	boneType = "bone_mammal",
	boneAmount = 7,
	milk = 0,
	tamingChance = 0.050000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = KILLER + PACK,
	diet = CARNIVORE,

	templates = {},
	weapons = {},
	attacks = {
		{"blindattack","blindChance=50"},
		{"intimidationattack","intimidationChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(ferine_razorfang, "ferine_razorfang")
