domesticated_brackaset = Creature:new {
	objectName = "@mob/creature_names:domesticated_brackaset",
	socialGroup = "self",
	pvpFaction = "",
	faction = "",
	level = 23,
	chanceHit = 0.350000,
	damageMin = 170,
	damageMax = 180,
	range = 0,
	baseXp = 2006,
	baseHAM = 8550,
	armor = 0,
	resists = {15,15,0,0,-1,0,0,-1,-1},
	meatType = "meat_wild",
	meatAmount = 100,
	hideType = "hide_leathery",
	hideAmount = 90,
	boneType = "bone_mammal",
	boneAmount = 80,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = NONE,
	diet = HERBIVORE,

	templates = {},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"intimidationattack","intimidationChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(domesticated_brackaset, "domesticated_brackaset")
