fbase_stormtrooper_medic_hard = Creature:new {
	objectName = "@mob/creature_names:fbase_stormtrooper_medic_hard",
	randomNameType = NAME_SWAMPTROOPER,
	randomNameTag = true,
	socialGroup = "imperial",
	faction = "imperial",
	level = 72,
	chanceHit = 0.72,
	damageMin = 505,
	damageMax = 720,
	baseXp = 7200,
	baseHAM = 13500,
	baseHAMmax = 20000,
	armor = 1,
	resists = {110,110,140,25,25,25,25,-1,-1},
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
	creatureBitmask = PACK + KILLER + HEALER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,
	scale = 1.05,

	templates = {"object/mobile/dressed_clonetrooper_m.iff",
		     "object/mobile/dressed_clonetrooper_blue_m.iff",
		     "object/mobile/dressed_clonetrooper_blue_nh_m.iff"
	},
	lootGroups = {
		{
			groups = {
				{group = "color_crystals", chance = 100000},
				{group = "junk", chance = 6000000},
				{group = "weapons_all", chance = 1200000},
				{group = "armor_all", chance = 1200000},
				{group = "clothing_attachments", chance = 150000},
				{group = "armor_attachments", chance = 150000},
				{group = "stormtrooper_common", chance = 200000},
				{group = "wearables_all", chance = 1000000}
			}
		}
	},
	weapons = {"clonetrooper_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/stormtrooper",
	attacks = merge(marksmanmaster,brawlermaster,carbineermid,riflemanmid)
}

CreatureTemplates:addCreatureTemplate(fbase_stormtrooper_medic_hard, "fbase_stormtrooper_medic_hard")
