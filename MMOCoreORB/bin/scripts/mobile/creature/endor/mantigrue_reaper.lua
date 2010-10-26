mantigrue_reaper = Creature:new {
	objectName = "@mob/creature_names:mantigrue_reaper",
	socialGroup = "Mantigrue",
	pvpFaction = "",
	faction = "",
	level = 50,
	chanceHit = 0.470000,
	damageMin = 370,
	damageMax = 450,
	baseXp = 4825,
	baseHAM = 10800,
	armor = 0,
	resists = {40,40,70,0,70,70,70,70,-1},
	meatType = "meat_carnivore",
	meatAmount = 0,
	hideType = "hide_wooly",
	hideAmount = 0,
	boneType = "bone_",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = PACK,
	diet = CARNIVORE,

	templates = {},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"intimidationattack","intimidationChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(mantigrue_reaper, "mantigrue_reaper")
