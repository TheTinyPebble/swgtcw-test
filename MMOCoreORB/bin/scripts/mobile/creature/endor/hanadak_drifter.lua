hanadak_drifter = Creature:new {
	objectName = "@mob/creature_names:hanadak_drifter",
	socialGroup = "Hanadak",
	pvpFaction = "",
	faction = "",
	level = 28,
	chanceHit = 0.370000,
	damageMin = 260,
	damageMax = 270,
	baseXp = 2914,
	baseHAM = 9000,
	armor = 0,
	resists = {20,20,-1,60,60,60,-1,-1,-1},
	meatType = "meat_carnivore",
	meatAmount = 0,
	hideType = "hide_bristley",
	hideAmount = 35,
	boneType = "bone_mammal",
	boneAmount = 35,
	milk = 0,
	tamingChance = 0.250000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = KILLER + PACK + HERD,
	diet = CARNIVORE,

	templates = {},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"stunattack","stunChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(hanadak_drifter, "hanadak_drifter")
