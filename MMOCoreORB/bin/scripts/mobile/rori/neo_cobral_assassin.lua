neo_cobral_assassin = Creature:new {
	objectName = "@mob/creature_names:cobral_assassin",
	socialGroup = "cobral",
	pvpFaction = "cobral",
	faction = "cobral",
	level = 25,
	chanceHit = 0.36,
	damageMin = 300,
	damageMax = 310,
	baseXp = 2637,
	baseHAM = 5900,
	baseHAMmax = 7200,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dressed_cobral_assassin_twk_female_01.iff",
		"object/mobile/dressed_cobral_assassin_twk_male_01.iff"},
	lootGroups = {
	    {
			groups = {
				{group = "junk", chance = 5000000},
				{group = "tailor_components", chance = 500000},
				{group = "loot_kits", chance = 4500000}
			},
			lootChance = 5500000
		}					
	},
	weapons = {"pirate_weapons_medium"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(neo_cobral_assassin, "neo_cobral_assassin")