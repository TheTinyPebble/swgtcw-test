nyms_guard = Creature:new {
	objectName = "Nym's guard",
	socialGroup = "Nym",
	pvpFaction = "Nym",
	faction = "",
	level = 9,
	chanceHit = 0.270000,
	damageMin = 80,
	damageMax = 90,
	baseXp = 356,
	baseHAM = 675-825,
	armor = 0,
	resists = {0,0,0,0,0,0,15,-1,-1},
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
	creatureBitmask = PACK + KILLER,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {"pirate_weapons_medium"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(nyms_guard, "nyms_guard")