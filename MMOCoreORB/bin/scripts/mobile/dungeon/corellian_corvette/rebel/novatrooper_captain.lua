novatrooper_captain = Creature:new {
	objectName = "@mob/creature_names:clonetrooper_captain",
	randomNameType = NAME_SWAMPTROOPER,
	randomNameTag = true,
	socialGroup = "imperial",
	faction = "imperial",
	level = 142,
	chanceHit = 7,
	damageMin = 845,
	damageMax = 1400,
	baseXp = 13462,
	baseHAM = 68000,
	baseHAMmax = 83000,
	armor = 2,
	resists = {60,50,80,30,25,25,30,45,-1},
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
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_clonetrooper_blue_m.iff",
		     "object/mobile/dressed_clonetrooper_blue_nh_m.iff"},

	lootGroups = {
		{
			groups = {
				{group = "color_crystals", chance = 700000},
				{group = "junk", chance = 6200000},
				{group = "clothing_attachments", chance = 575000},
				{group = "armor_attachments", chance = 575000},
				{group = "imperial_officer_common", chance = 950000},
				{group = "wearables_scarce", chance = 1000000}
			}
		}
	},
	weapons = {"clonetrooper_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/stormtrooper",
	attacks = merge(riflemanmaster,carbineermaster,marksmanmaster,brawlermaster)
}

CreatureTemplates:addCreatureTemplate(novatrooper_captain, "novatrooper_captain")
