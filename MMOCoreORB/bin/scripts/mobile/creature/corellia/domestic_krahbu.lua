domestic_krahbu = Creature:new {
	objectName = "@mob/creature_names:domestic_krahbu",
	socialGroup = "self",
	pvpFaction = "",
	faction = "",
	level = 7,
	chanceHit = 0.260000,
	damageMin = 50,
	damageMax = 55,
	baseXp = 147,
	baseHAM = 450,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 230,
	hideType = "hide_bristley",
	hideAmount = 160,
	boneType = "bone_mammal",
	boneAmount = 145,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = HERD,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(domestic_krahbu, "domestic_krahbu")
