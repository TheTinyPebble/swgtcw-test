corsec_special_ops_comissioner = Creature:new {
	objectName = "@mob/creature_names:CorSec_Special Ops_Comissioner",
	socialGroup = "Corsec [aggro]",
	pvpFaction = "Corsec [aggro]",
	faction = "",
	level = 226,
	chanceHit = 19.75,
	damageMin = 1270,
	damageMax = 2250,
	baseXp = 21533,
	baseHAM = 208000,
	baseHAMmax = 254000,
	armor = 0,
	resists = {85,85,30,0,80,30,0,35,-1},
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
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {"ranged_weapons"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(corsec_special_ops_comissioner, "corsec_special_ops_comissioner")