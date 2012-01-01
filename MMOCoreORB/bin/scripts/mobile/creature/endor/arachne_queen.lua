arachne_queen = Creature:new {
	objectName = "@mob/creature_names:arachne_queen",
	socialGroup = "Arachne",
	pvpFaction = "",
	faction = "",
	level = 63,
	chanceHit = 0.6,
	damageMin = 445,
	damageMax = 600,
	baseXp = 6105,
	baseHAM = 11000,
	baseHAMmax = 14000,
	armor = 1,
	resists = {25,25,15,15,15,15,15,0,0},
	meatType = "meat_insect",
	meatAmount = 60,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE,
	creatureBitmask = PACK + HERD + KILLER,
	optionsBitmask = 128,
	diet = CARNIVORE,

	templates = {"object/mobile/queen_arachne.iff"},
	lootgroups = {},
	weapons = {"creature_spit_small_green","creature_spit_small_green"},
	conversationTemplate = "",
	attacks = {
		{"creatureareapoison",""},
		{"strongpoison",""}
	}
}

CreatureTemplates:addCreatureTemplate(arachne_queen, "arachne_queen")