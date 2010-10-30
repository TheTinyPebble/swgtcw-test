giant_cavern_spider_recluse = Creature:new {
	objectName = "@mob/creature_names:cave_gaping_spider_recluse_giant",
	socialGroup = "Spider Nightsister",
	pvpFaction = "",
	faction = "",
	level = 116,
	chanceHit = 3.100000,
	damageMin = 775,
	damageMax = 1260,
	baseXp = 11015,
	baseHAM = 33500,
	baseHAMmax = 33500,
	armor = 0,
	resists = {60,60,60,0,0,0,0,0,-1},
	meatType = "meat_insect",
	meatAmount = 80,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE,
	creatureBitmask = KILLER + STALKER + PACK,
	diet = CARNIVORE,

	templates = {"object/mobile/gaping_spider_recluse.iff"},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"creatureareacombo",""},
		{"strongpoison",""}
	}
}

CreatureTemplates:addCreatureTemplate(giant_cavern_spider_recluse, "giant_cavern_spider_recluse")