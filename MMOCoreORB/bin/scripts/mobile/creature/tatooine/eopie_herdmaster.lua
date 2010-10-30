eopie_herdmaster = Creature:new {
	objectName = "@mob/creature_names:eopie_herdmaster",
	socialGroup = "Eopie",
	pvpFaction = "",
	faction = "",
	level = 9,
	chanceHit = 0.270000,
	damageMin = 55,
	damageMax = 65,
	baseXp = 292,
	baseHAM = 900,
	baseHAMmax = 900,
	armor = 0,
	resists = {0,0,0,10,10,0,0,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 315,
	hideType = "hide_leathery",
	hideAmount = 250,
	boneType = "bone_mammal",
	boneAmount = 150,
	milk = 0,
	tamingChance = 0.050000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE,
	creatureBitmask = PACK + HERD,
	diet = HERBIVORE,

	templates = {"object/mobile/eopie.iff"},
	lootgroups = {},
	weapons = {},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(eopie_herdmaster, "eopie_herdmaster")