desert_vesp = Creature:new {
	objectName = "@mob/creature_names:desert_vesp",
	socialGroup = "Vesp",
	pvpFaction = "",
	faction = "",
	level = 30,
	chanceHit = 0.390000,
	damageMin = 290,
	damageMax = 300,
	baseXp = 3005,
	baseHAM = 9300,
	armor = 0,
	resists = {0,0,0,100,75,-1,-1,-1,-1},
	meatType = "meat_reptil",
	meatAmount = 15,
	hideType = "hide_leathery",
	hideAmount = 6,
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
		{"strongpoison",""},
		{"stunattack","stunChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(desert_vesp, "desert_vesp")
