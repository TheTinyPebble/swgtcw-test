fbase_rebel_soldier_hard = Creature:new {
	objectName = "@mob/creature_names:fbase_cis_soldier_hard",
	socialGroup = "rebel",
	faction = "rebel",
	level = 80,
	chanceHit = 0.8,
	damageMin = 545,
	damageMax = 800,
	baseXp = 8000,
	baseHAM = 15500,
	baseHAMmax = 22500,
	armor = 1,
	resists = {30,30,30,130,30,130,-1,-1,-1},
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
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {
		"object/mobile/battle_droid.iff"
	},
	lootGroups = {
		{
			groups = {
				{group = "color_crystals", chance = 200000},
				{group = "junk", chance = 6000000},
				{group = "weapons_all", chance = 1250000},
				{group = "armor_all", chance = 1250000},
				{group = "clothing_attachments", chance = 150000},
				{group = "armor_attachments", chance = 150000},
				{group = "wearables_all", chance = 1000000}
			}
		}
	},
	weapons = {"rebel_weapons_medium"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/military",
	attacks = merge(marksmanmaster,brawlermaster,carbineermid,teraskasimid)
}

CreatureTemplates:addCreatureTemplate(fbase_rebel_soldier_hard, "fbase_rebel_soldier_hard")
