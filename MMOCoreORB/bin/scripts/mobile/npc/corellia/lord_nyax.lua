lord_nyax = Creature:new {
	objectName = "@mob/creature_names:lord_nyax",
	socialGroup = "Lord Nyax",
	pvpFaction = "Lord Nyax",
	faction = "",
	level = 129,
	chanceHit = 4.9,
	damageMin = 775,
	damageMax = 1260,
	baseXp = 12235,
	baseHAM = 51000,
	baseHAMmax = 62000,
	armor = 0,
	resists = {80,45,40,20,50,100,10,15,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE,
	creatureBitmask = PACK + KILLER + STALKER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_lord_nyax.iff"},
	lootgroups = {},
	weapons = {"nyax's_weapons"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(lord_nyax, "lord_nyax")