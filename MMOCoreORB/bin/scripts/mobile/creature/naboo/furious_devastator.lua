furious_devastator = Creature:new {
	objectName = "@mob/creature_names:fambaa_furious_devastator",
	socialGroup = "Fambaa",
	pvpFaction = "",
	faction = "",
	level = 38,
	chanceHit = 0.400000,
	damageMin = 375,
	damageMax = 460,
	baseXp = 3824,
	baseHAM = 9600,
	armor = 0,
	resists = {25,45,-1,-1,60,60,-1,0,-1},
	meatType = "meat_reptilian",
	meatAmount = 1250,
	hideType = "hide_leathery",
	hideAmount = 750,
	boneType = "bone_mammal",
	boneAmount = 675,
	milk = 0,
	tamingChance = 0.050000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = KILLER + PACK + HERD,
	diet = CARNIVORE,

	templates = {},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"intimidationattack","intimidationChance=50"},
		{"posturedownattack","postureDownChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(furious_devastator, "furious_devastator")
