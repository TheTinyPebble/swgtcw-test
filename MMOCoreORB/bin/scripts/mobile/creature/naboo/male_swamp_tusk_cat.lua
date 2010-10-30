male_swamp_tusk_cat = Creature:new {
	objectName = "@mob/creature_names:male_swamp_tusk_cat",
	socialGroup = "Swamp Tusk C.",
	pvpFaction = "",
	faction = "",
	level = 17,
	chanceHit = 0.310000,
	damageMin = 170,
	damageMax = 180,
	baseXp = 1102,
	baseHAM = 3900,
	baseHAMmax = 3900,
	armor = 0,
	resists = {0,0,0,-1,35,-1,35,-1,-1},
	meatType = "meat_carnivore",
	meatAmount = 70,
	hideType = "hide_bristley",
	hideAmount = 40,
	boneType = "bone_mammal",
	boneAmount = 35,
	milk = 0,
	tamingChance = 0.250000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = KILLER + STALKER,
	diet = CARNIVORE,

	templates = {"object/mobile/tusk_cat.iff"},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"blindattack","blindChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(male_swamp_tusk_cat, "male_swamp_tusk_cat")