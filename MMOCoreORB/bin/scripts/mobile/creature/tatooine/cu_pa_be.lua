cu_pa_be = Creature:new {
	objectName = "cu pa be",
	socialGroup = "Cu Pa",
	pvpFaction = "",
	faction = "",
	level = 1,
	chanceHit = 0.200000,
	damageMin = 30,
	damageMax = 40,
	baseXp = 30,
	baseHAM = 50,
	baseHAMmax = 50,
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
	creatureBitmask = HERD,
	diet = HERBIVORE,

	templates = {"object/mobile/cu_pa_hue.iff"},
	lootgroups = {},
	weapons = {},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(cu_pa_be, "cu_pa_be")