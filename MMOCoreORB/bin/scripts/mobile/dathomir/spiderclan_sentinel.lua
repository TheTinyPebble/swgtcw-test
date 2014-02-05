spiderclan_sentinel = Creature:new {
	objectName = "@mob/creature_names:spider_nightsister_sentinel",
	socialGroup = "spider_nightsister",
	pvpFaction = "spider_nightsister",
	faction = "spider_nightsister",
	level = 92,
	chanceHit = 0.8,
	damageMin = 545,
	damageMax = 800,
	baseXp = 8778,
	baseHAM = 21000,
	baseHAMmax = 26000,
	armor = 1,
	resists = {55,100,45,60,100,100,35,100,-1},
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
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_dathomir_spider_nightsister_sentinel.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 1500000},
				{group = "crystals_quality", chance = 500000},
				{group = "color_crystals", chance = 500000},
				{group = "armor_attachments", chance = 400000},
				{group = "clothing_attachments", chance = 400000},
				{group = "melee_weapons", chance = 3100000},
				{group = "pistols", chance = 1200000},
				{group = "rifles", chance = 1200000},
				{group = "carbines", chance = 1200000},
			},
			lootChance = 2800000
		}			
	},
	weapons = {"mixed_force_weapons"},
	conversationTemplate = "",
	attacks = merge(brawlermaster,pikemanmaster,forcewielder)
}

CreatureTemplates:addCreatureTemplate(spiderclan_sentinel, "spiderclan_sentinel")
