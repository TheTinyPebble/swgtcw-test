enraged_rancor = Creature:new {
	templateType = NPCCREATURE,
	gameObjectType = 1024,
	objectName = "@mob/creature_names:enraged_rancor",
	socialGroup = "Rancor",
	pvpFaction = "",
	faction = "",
	level = 80,
	chanceHit = 0.750000,
	damageMin = 570,
	damageMax = 850,
	range = 0,
	baseXp = 7668,
	baseHAM = 13500,
	armor = 0,
	resists = {0,60,0,100,100,100,0,0,-1},
	meatType = "meat_carnivore",
	meatAmount = 950,
	hideType = "hide_leathery",
	hideAmount = 878,
	boneType = "bone_mammal",
	boneAmount = 778,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = KILLER + PACK,
	diet = CARNIVORE,

	templates = {},
	weapons = {},
	attacks = {
		{"knockdownattack","knockdownChance=50"},
		{"creatureareaattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(enraged_rancor, "enraged_rancor")
