crackdown_comm_operator = Creature:new {
	objectName = "@mob/creature_names:crackdown_comm_operator",
	socialGroup = "Imperial",
	pvpFaction = "Imperial",
	faction = "",
	level = 1,
	chanceHit = 0.3,
	damageMin = 150,
	damageMax = 160,
	baseXp = 40,
	baseHAM = 2000,
	baseHAMmax = 2400,
	armor = 0,
	resists = {0,0,0,0,0,0,0,0,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_imperial_officer_m.iff"},
	lootgroups = {},
	weapons = {"imperial_weapons_light"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(crackdown_comm_operator, "crackdown_comm_operator")