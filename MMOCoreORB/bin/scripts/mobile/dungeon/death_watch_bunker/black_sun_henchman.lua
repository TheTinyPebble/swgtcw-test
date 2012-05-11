black_sun_henchman = Creature:new {
	objectName = "@mob/creature_names:mand_bunker_blksun_henchman",
	socialGroup = "death_watch",
	pvpFaction = "death_watch",
	faction = "",
	level = 76,
	chanceHit = 0.75,
	damageMin = 520,
	damageMax = 750,
	baseXp = 7207,
	baseHAM = 12000,
	baseHAMmax = 15000,
	armor = 1,
	resists = {35,35,50,25,45,60,25,30,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_black_sun_henchman.iff"},
	lootGroups = {
        {
			groups = {
				{group = "pistols", chance =   3100000},
				{group = "rifles", chance = 3100000},
				{group = "carbines", chance =  3100000},
				{group = "bounty_hunter_armor_looted",chance = 500000},
				{group = "jetpack_base", chance = 200000},
			},
			lootChance = 3500000
		}			
	},
	weapons = {"pirate_weapons_heavy"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(black_sun_henchman, "black_sun_henchman")