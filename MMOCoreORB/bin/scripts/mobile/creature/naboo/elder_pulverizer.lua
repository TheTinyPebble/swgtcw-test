elder_pulverizer = Creature:new {
	objectName = "@mob/creature_names:bolle_bol_elder_pulverizer",
	socialGroup = "Bolle Bol",
	pvpFaction = "",
	faction = "",
	level = 30,
	chanceHit = 0.350000,
	damageMin = 315,
	damageMax = 340,
	baseXp = 3005,
	baseHAM = 9200,
	armor = 0,
	resists = {25,25,0,0,15,-1,15,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 450,
	hideType = "hide_leathery",
	hideAmount = 300,
	boneType = "bone_mammal",
	boneAmount = 180,
	milk = 0,
	tamingChance = 0.050000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = PACK + HERD,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"dizzyattack","dizzyChance=50"},
		{"knockdownattack","knockdownChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(elder_pulverizer, "elder_pulverizer")
