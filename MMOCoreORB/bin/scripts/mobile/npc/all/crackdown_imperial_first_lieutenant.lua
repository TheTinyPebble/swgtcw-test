crackdown_imperial_first_lieutenant = Creature:new {
	objectName = "@mob/creature_names:crackdown_imperial_first_lieutenant",
	socialGroup = "Imperial",
	pvpFaction = "Imperial",
	faction = "",
	level = 1,
	chanceHit = 0.330000,
	damageMin = 190,
	damageMax = 200,
	baseXp = 45,
	baseHAM = 5000-6100,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
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
	weapons = {"imperial_weapons_medium"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(crackdown_imperial_first_lieutenant, "crackdown_imperial_first_lieutenant")