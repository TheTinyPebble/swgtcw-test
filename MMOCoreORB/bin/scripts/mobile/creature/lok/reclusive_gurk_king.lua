reclusive_gurk_king = Creature:new {
	templateType = NPCCREATURE,
	gameObjectType = 1024,
	objectName = "@mob/creature_names:recluse_gurk_king",
	socialGroup = "Gurk",
	pvpFaction = "",
	faction = "",
	level = 45,
	chanceHit = 0.470000,
	damageMin = 370,
	damageMax = 450,
	range = 0,
	baseXp = 4461,
	baseHAM = 10800,
	armor = 0,
	resists = {35,35,0,-1,0,0,-1,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 0,
	hideType = "hide_leathery",
	hideAmount = 275,
	boneType = "bone_mammal",
	boneAmount = 300,
	milk = 0.000000,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE,
	creatureBitmask = KILLER + PACK + HERD,
	diet = CARNIVORE,

	templates = {},
	weapons = {},
	attacks = {
		{"posturedownattack","postureDownChance=50"},
		{"blindattack","blindChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(reclusive_gurk_king, "reclusive_gurk_king")
