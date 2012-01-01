sharnaff_be = Creature:new {
	objectName = "@mob/creature_names:sharnaff_be",
	socialGroup = "Sharnaff",
	pvpFaction = "",
	faction = "",
	level = 1,
	chanceHit = 0.2,
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
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = NONE,
	optionsBitmask = 128,
	diet = CARNIVORE,

	templates = {"object/mobile/sharnaff_hue.iff"},
	lootgroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(sharnaff_be, "sharnaff_be")