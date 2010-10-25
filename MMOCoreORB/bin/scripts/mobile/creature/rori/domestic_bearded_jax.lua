domestic_bearded_jax = Creature:new {
	objectName = "@mob/creature_names:domestic_bearded_jax",
	socialGroup = "Narmle",
	pvpFaction = "",
	faction = "",
	level = 5,
	chanceHit = 0.250000,
	damageMin = 45,
	damageMax = 50,
	range = 0,
	baseXp = 85,
	baseHAM = 150,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
	meatType = "meat_domest",
	meatAmount = 11,
	hideType = "hide_bristley",
	hideAmount = 16,
	boneType = "bone_mammal",
	boneAmount = 11,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = STALKER + HERD,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(domestic_bearded_jax, "domestic_bearded_jax")
