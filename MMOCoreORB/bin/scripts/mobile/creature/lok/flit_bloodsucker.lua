flit_bloodsucker = Creature:new {
	templateType = NPCCREATURE,
	gameObjectType = 1024,
	objectName = "@mob/creature_names:flit_bloodsucker",
	socialGroup = "Flit",
	pvpFaction = "",
	faction = "",
	level = 9,
	chanceHit = 0.270000,
	damageMin = 80,
	damageMax = 90,
	range = 0,
	baseXp = 292,
	baseHAM = 750,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
	meatType = "meat_avian",
	meatAmount = 9,
	hideType = "hide_",
	hideAmount = 0,
	boneType = "bone_avian",
	boneAmount = 10,
	milk = 0.000000,
	tamingChance = 0.250000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = PACK,
	diet = CARNIVORE,

	templates = {},
	weapons = {},
	attacks = {
		{"intimidationattack","intimidationChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(flit_bloodsucker, "flit_bloodsucker")
