fierce_huurton = Creature:new {
	templateType = NPCCREATURE,
	gameObjectType = 1024,
	objectName = "@mob/creature_names:warren_huurton_fierce",
	socialGroup = "Warren Huurton ",
	pvpFaction = "",
	faction = "",
	level = 22,
	chanceHit = 0.340000,
	damageMin = 220,
	damageMax = 230,
	range = 0,
	baseXp = 2006,
	baseHAM = 6000,
	armor = 0,
	resists = {20,20,0,0,-1,0,-1,-1,-1},
	meatType = "meat_",
	meatAmount = 0,
	hideType = "hide_wooly",
	hideAmount = 0,
	boneType = "bone_mammal",
	boneAmount = 25,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = KILLER,
	diet = CARNIVORE,

	templates = {},
	weapons = {},
	attacks = {
		{"stunattack","stunChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(fierce_huurton, "fierce_huurton")
