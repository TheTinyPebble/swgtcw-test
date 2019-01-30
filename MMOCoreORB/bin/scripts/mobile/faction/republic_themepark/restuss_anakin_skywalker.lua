restuss_anakin_skywalker = Creature:new {
	objectName = "@mob/creature_names:theme_anakin_skywalker",
	socialGroup = "imperial",
	faction = "imperial",
	level = 100,
	chanceHit = 1,
	damageMin = 645,
	damageMax = 1000,
	baseXp = 9429,
	baseHAM = 24000,
	baseHAMmax = 30000,
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
	pvpBitmask = NONE,
	creatureBitmask = PACK,
	--optionsBitmask = INVULNERABLE + CONVERSABLE + INTERESTING,
	optionsBitmask = INVULNERABLE + INTERESTING,
	diet = HERBIVORE,

	templates = {"object/mobile/anakin_robe.iff"},
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	--conversationTemplate = "restussanakinGiverConvoTemplate",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(restuss_anakin_skywalker, "restuss_anakin_skywalker")
