scavenger_rat = Creature:new {
	objectName = "@mob/creature_names:scavenger_rat",
	socialGroup = "self",
	pvpFaction = "",
	faction = "",
	level = 8,
	chanceHit = 0.270000,
	damageMin = 70,
	damageMax = 75,
	baseXp = 187,
	baseHAM = 450,
	baseHAMmax = 450,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
	meatType = "meat_wild",
	meatAmount = 4,
	hideType = "hide_leathery",
	hideAmount = 3,
	boneType = "bone_mammal",
	boneAmount = 2,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = NONE,
	diet = CARNIVORE,

	templates = {"object/mobile/womp_rat.iff"},
	lootgroups = {},
	weapons = {},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(scavenger_rat, "scavenger_rat")