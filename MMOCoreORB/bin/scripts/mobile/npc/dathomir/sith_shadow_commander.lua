sith_shadow_commander = Creature:new {
	objectName = "@mob/creature_names:Sith_Shadow_commander",
	socialGroup = "Sith Shadow",
	pvpFaction = "Sith Shadow",
	faction = "",
	level = 69,
	chanceHit = 0.6,
	damageMin = 495,
	damageMax = 700,
	baseXp = 6655,
	baseHAM = 11000,
	baseHAMmax = 13500,
	armor = 0,
	resists = {60,60,50,65,65,50,60,60,-1},
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
	creatureBitmask = KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_sith_shadow_hum_m_01.iff"},
	lootgroups = {},
	weapons = {"pirate_weapons_heavy"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(sith_shadow_commander, "sith_shadow_commander")