giant_carrion_spat = Creature:new {
	objectName = "@mob/creature_names:giant_carrion_spat",
	socialGroup = "Carrion Spat",
	pvpFaction = "",
	faction = "",
	level = 18,
	chanceHit = 0.320000,
	damageMin = 160,
	damageMax = 170,
	baseXp = 1426,
	baseHAM = 3900,
	baseHAMmax = 3900,
	armor = 0,
	resists = {-1,25,0,45,45,-1,-1,-1,-1},
	meatType = "meat_avian",
	meatAmount = 350,
	hideType = "",
	hideAmount = 0,
	boneType = "bone_avian",
	boneAmount = 295,
	milk = 0,
	tamingChance = 0.250000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE,
	creatureBitmask = KILLER + STALKER + PACK,
	diet = CARNIVORE,

	templates = {"object/mobile/giant_carrion_spat.iff"},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"dizzyattack","dizzyChance=50"},
		{"stunattack","stunChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(giant_carrion_spat, "giant_carrion_spat")