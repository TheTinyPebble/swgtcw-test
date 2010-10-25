nocuous_kamurith = Creature:new {
	objectName = "@mob/creature_names:kamurith_nocuous",
	socialGroup = "Kamurith",
	pvpFaction = "",
	faction = "",
	level = 46,
	chanceHit = 0.480000,
	damageMin = 395,
	damageMax = 500,
	range = 0,
	baseXp = 4552,
	baseHAM = 10300,
	armor = 0,
	resists = {0,0,0,0,0,0,0,0,-1},
	meatType = "meat_carnivore",
	meatAmount = 90,
	hideType = "hide_leathery",
	hideAmount = 65,
	boneType = "bone_avian",
	boneAmount = 60,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = KILLER + PACK,
	diet = CARNIVORE,

	templates = {},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"dizzyattack","dizzyChance=50"},
		{"strongpoison",""}
	}
}

CreatureTemplates:addCreatureTemplate(nocuous_kamurith, "nocuous_kamurith")
