sandy_spined_snake = Creature:new {
	objectName = "@mob/creature_names:sandy_spined_snake",
	socialGroup = "Spinesnake",
	pvpFaction = "",
	faction = "",
	level = 13,
	chanceHit = 0.300000,
	damageMin = 160,
	damageMax = 170,
	baseXp = 714,
	baseHAM = 1300,
	baseHAMmax = 1300,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
	meatType = "meat_reptilian",
	meatAmount = 8,
	hideType = "hide_leathery",
	hideAmount = 3,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.250000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE,
	creatureBitmask = KILLER + PACK,
	diet = CARNIVORE,

	templates = {"object/mobile/spined_snake.iff"},
	lootgroups = {},
	weapons = {"creature_spit_small_toxicgreen"},
	attacks = {
		{"stunattack","stunChance=50"},
		{"mediumpoison",""}
	}
}

CreatureTemplates:addCreatureTemplate(sandy_spined_snake, "sandy_spined_snake")