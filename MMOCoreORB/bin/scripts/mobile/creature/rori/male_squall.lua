male_squall = Creature:new {
	templateType = NPCCREATURE,
	gameObjectType = 1024,
	objectName = "@mob/creature_names:squall_male",
	socialGroup = "Squall",
	pvpFaction = "",
	faction = "",
	level = 11,
	chanceHit = 0.290000,
	damageMin = 120,
	damageMax = 130,
	range = 0,
	baseXp = 356,
	baseHAM = 1100,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 10,
	hideType = "hide_bristley",
	hideAmount = 15,
	boneType = "bone_mammal",
	boneAmount = 10,
	milk = 0.000000,
	tamingChance = 0.250000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = HERD,
	diet = CARNIVORE,

	templates = {},
	weapons = {},
	attacks = {
		{"stunattack","stunChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(male_squall, "male_squall")
