kreetle = Creature:new {
	objectName = "@mob/creature_names:kreetle",
	socialGroup = "self",
	pvpFaction = "",
	faction = "",
	level = 3,
	chanceHit = 0.230000,
	damageMin = 35,
	damageMax = 45,
	baseXp = 45,
	baseHAM = 100,
	baseHAMmax = 100,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
	meatType = "meat_insect",
	meatAmount = 1,
	hideType = "hide_scaley",
	hideAmount = 2,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.250000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE,
	creatureBitmask = HERD,
	diet = CARNIVORE,

	templates = {"object/mobile/kreetle.iff"},
	lootgroups = {},
	weapons = {},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(kreetle, "kreetle")