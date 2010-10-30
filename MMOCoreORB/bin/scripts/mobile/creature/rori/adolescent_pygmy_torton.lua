adolescent_pygmy_torton = Creature:new {
	objectName = "@mob/creature_names:torton_pygmy_adolescent",
	socialGroup = "Torton",
	pvpFaction = "",
	faction = "",
	level = 14,
	chanceHit = 0.300000,
	damageMin = 160,
	damageMax = 170,
	baseXp = 714,
	baseHAM = 1100,
	baseHAMmax = 1100,
	armor = 0,
	resists = {10,10,0,0,0,-1,0,50,-1},
	meatType = "meat_carnivore",
	meatAmount = 500,
	hideType = "hide_wooly",
	hideAmount = 300,
	boneType = "bone_mammal",
	boneAmount = 500,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE,
	creatureBitmask = PACK + HERD,
	diet = HERBIVORE,

	templates = {"object/mobile/torton.iff"},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"knockdownattack","knockdownChance=50"},
		{"dizzyattack","dizzyChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(adolescent_pygmy_torton, "adolescent_pygmy_torton")