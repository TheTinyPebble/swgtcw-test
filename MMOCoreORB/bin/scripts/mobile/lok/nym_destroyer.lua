nym_destroyer = Creature:new {
	objectName = "@mob/creature_names:nym_destroyer",
	socialGroup = "nym",
	pvpFaction = "nym",
	faction = "nym",
	level = 40,
	chanceHit = 0.43,
	damageMin = 355,
	damageMax = 420,
	baseXp = 4006,
	baseHAM = 9100,
	baseHAMmax = 11100,
	armor = 1,
	resists = {15,15,15,15,60,15,-1,-1,-1},
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

	templates = {"object/mobile/dressed_nym_destroyer_rod_m.iff",
				"object/mobile/dressed_nym_destroyer_hum_m.iff",
				"object/mobile/dressed_nym_destroyer_nikto_m.iff",
				"object/mobile/dressed_nym_destroyer_wee_m.iff"},
	lootGroups = {
	    {
			groups = {
				{group = "nyms_common", chance = 2500000},
				{group = "pistols", chance = 2500000},
				{group = "carbines", chance = 2500000},
				{group = "tailor_components", chance = 2500000}
			},
			lootChance = 6500000
		}
	},
	weapons = {"rebel_weapons_medium"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(nym_destroyer, "nym_destroyer")