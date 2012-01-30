narmle_militia_commander = Creature:new {
	objectName = "@mob/creature_names:narmle_commander",
	socialGroup = "Narmle",
	pvpFaction = "Narmle",
	faction = "",
	level = 25,
	chanceHit = 0.35,
	damageMin = 220,
	damageMax = 230,
	baseXp = 2543,
	baseHAM = 6300,
	baseHAMmax = 7700,
	armor = 0,
	resists = {30,30,0,60,-1,-1,0,-1,-1},
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
	creatureBitmask = PACK + HERD,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_narmle_commander_rodian_female_01.iff"},
	lootGroups = {},
	weapons = {"rebel_weapons_heavy"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(narmle_militia_commander, "narmle_militia_commander")