rtp_stormtrooper_elite_85 = Creature:new {
	objectName = "@mob/creature_names:rtp_stormtrooper_elite_85",
	socialGroup = "imperial",
	pvpFaction = "imperial",
	faction = "imperial",
	level = 1,
	chanceHit = 0.38,
	damageMin = 280,
	damageMax = 290,
	baseXp = 45,
	baseHAM = 8300,
	baseHAMmax = 10100,
	armor = 0,
	resists = {0,0,0,30,-1,30,-1,-1,-1},
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
	creatureBitmask = PACK + KILLER + STALKER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_stormtrooper_m.iff"},
	lootGroups = {
		{
			groups = {
				{group = "color_crystals", chance = 200000},
				{group = "junk", chance = 3600000},
				{group = "rifles", chance = 2000000},
				{group = "pistols", chance = 2000000},
				{group = "clothing_attachments", chance = 1100000},
				{group = "armor_attachments", chance = 1100000}
			},
			lootChance = 4000000
		}			
	},
	weapons = {"stormtrooper_weapons"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(rtp_stormtrooper_elite_85, "rtp_stormtrooper_elite_85")