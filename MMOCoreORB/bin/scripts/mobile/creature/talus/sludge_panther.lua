sludge_panther = Creature:new {
	objectName = "@mob/creature_names:sludge_panther",
	socialGroup = "Sludge Panther",
	pvpFaction = "",
	faction = "",
	level = 16,
	chanceHit = 0.310000,
	damageMin = 170,
	damageMax = 180,
	range = 0,
	baseXp = 1102,
	baseHAM = 3200,
	armor = 0,
	resists = {15,0,0,-1,-1,-1,-1,-1,-1},
	meatType = "meat_carnivore",
	meatAmount = 24,
	hideType = "hide_leathery",
	hideAmount = 30,
	boneType = "bone_mammal",
	boneAmount = 31,
	milk = 0,
	tamingChance = 0.250000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = KILLER + STALKER + PACK,
	diet = CARNIVORE,

	templates = {},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"stunattack","stunChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(sludge_panther, "sludge_panther")
