gadsle_distombe = Creature:new {
	objectName = "@mob/creature_names:gadsle_distombe",
	socialGroup = "Sith Shadow",
	pvpFaction = "Sith Shadow",
	faction = "",
	level = 87,
	chanceHit = 0.750000,
	damageMin = 620,
	damageMax = 950,
	baseXp = 8315,
	baseHAM = 12400,
	baseHAMmax = 15200,
	armor = 0,
	resists = {70,70,70,70,70,70,70,70,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE + AGGRESSIVE,
	creatureBitmask = PACK + KILLER,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {"mixed_force_weapons"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(gadsle_distombe, "gadsle_distombe")