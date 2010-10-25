giant_dalyrake = Creature:new {
	objectName = "@mob/creature_names:giant_dalyrake",
	socialGroup = "Dalyrake",
	pvpFaction = "",
	faction = "",
	level = 18,
	chanceHit = 0.320000,
	damageMin = 170,
	damageMax = 180,
	range = 0,
	baseXp = 1257,
	baseHAM = 2700,
	armor = 0,
	resists = {0,0,0,-1,35,35,-1,-1,-1},
	meatType = "meat_insect",
	meatAmount = 60,
	hideType = "hide_scaley",
	hideAmount = 90,
	boneType = "bone_",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.250000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = PACK,
	diet = CARNIVORE,

	templates = {},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"mildpoison",""},
		{"dizzyattack","dizzyChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(giant_dalyrake, "giant_dalyrake")
