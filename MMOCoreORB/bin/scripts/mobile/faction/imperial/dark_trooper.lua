dark_trooper = Creature:new {
	objectName = "@mob/creature_names:dark_trooper",
	socialGroup = "imperial",
	pvpFaction = "imperial",
	faction = "imperial",
	level = 35,
	chanceHit = 0.4,
	damageMin = 305,
	damageMax = 320,
	baseXp = 3465,
	baseHAM = 9000,
	baseHAMmax = 10000,
	armor = 0,
	resists = {40,20,20,50,50,50,50,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE + OVERT,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/dark_trooper.iff"},
	lootGroups = {
		{
			groups = {
				{group = "holocron_dark", chance = 100000},
				{group = "rifles", chance = 3750000},
				{group = "pistols", chance = 3750000},
				{group = "clothing_attachments", chance = 1100000},
				{group = "armor_attachments", chance = 1100000}
			},
			lootChance = 4000000
		}
	},
	weapons = {"dark_trooper_weapons"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(dark_trooper, "dark_trooper")