skilled_jinda_worker = Creature:new {
	objectName = "@mob/creature_names:skilled_jinda_worker",
	socialGroup = "Jinda Tribe",
	pvpFaction = "Jinda Tribe",
	faction = "",
	level = 29,
	chanceHit = 0.390000,
	damageMin = 290,
	damageMax = 300,
	baseXp = 2914,
	baseHAM = 8400-10200,
	armor = 0,
	resists = {-1,50,-1,0,0,70,0,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {""},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(skilled_jinda_worker, "skilled_jinda_worker")