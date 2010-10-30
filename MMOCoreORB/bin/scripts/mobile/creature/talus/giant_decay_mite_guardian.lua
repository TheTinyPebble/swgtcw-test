giant_decay_mite_guardian = Creature:new {
	objectName = "@mob/creature_names:giant_decay_mite_royal_guardian",
	socialGroup = "Decay Mite",
	pvpFaction = "",
	faction = "",
	level = 24,
	chanceHit = 0.330000,
	damageMin = 220,
	damageMax = 230,
	baseXp = 2443,
	baseHAM = 7000,
	baseHAMmax = 7000,
	armor = 0,
	resists = {30,30,0,0,0,-1,-1,-1,-1},
	meatType = "meat_insect",
	meatAmount = 22,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE,
	creatureBitmask = PACK,
	diet = CARNIVORE,

	templates = {"object/mobile/decay_mite.iff"},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"intimidationattack","intimidationChance=50"},
		{"mildpoison",""}
	}
}

CreatureTemplates:addCreatureTemplate(giant_decay_mite_guardian, "giant_decay_mite_guardian")