crackdown_imperial_exterminator = Creature:new {
	objectName = "@mob/creature_names:crackdown_imperial_exterminator",
	socialGroup = "Imperial",
	pvpFaction = "Imperial",
	faction = "",
	level = 1,
	chanceHit = 0.370000,
	damageMin = 290,
	damageMax = 300,
	baseXp = 45,
	baseHAM = 7700-9400,
	armor = 0,
	resists = {0,0,0,-1,30,-1,30,-1,-1},
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
	weapons = {"imperial_weapons_heavy"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(crackdown_imperial_exterminator, "crackdown_imperial_exterminator")