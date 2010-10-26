adept_jinda_shaman = Creature:new {
	objectName = "@mob/creature_names:adept_jinda_shaman",
	socialGroup = "Jinda Tribe",
	pvpFaction = "Jinda Tribe",
	faction = "",
	level = 32,
	chanceHit = 0.390000,
	damageMin = 325,
	damageMax = 360,
	baseXp = 3188,
	baseHAM = 8400-10200,
	armor = 0,
	resists = {0,0,0,0,0,0,0,0,-1},
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

CreatureTemplates:addCreatureTemplate(adept_jinda_shaman, "adept_jinda_shaman")