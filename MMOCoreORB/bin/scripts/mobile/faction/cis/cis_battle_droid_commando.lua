cis_battle_droid_commando = Creature:new {
	objectName = "@mob/creature_names:cis_battle_droid",
	customName = "A Battle Droid Commando",
	socialGroup = "rebel",
	faction = "rebel",
	level = 30,
	chanceHit = 0.36,
	damageMin = 270,
	damageMax = 280,
	baseXp = 2637,
	baseHAM = 7200,
	baseHAMmax = 8800,
	armor = 0,
	resists = {30,30,40,30,30,30,30,30,-1},
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
		"object/mobile/death_watch_battle_droid.iff"
		},
	lootGroups = {
		{
			groups = {
				{group = "color_crystals", chance = 100000},
				{group = "junk", chance = 3600000},
				{group = "rifles", chance = 1200000},
				{group = "pistols", chance = 1200000},
				{group = "melee_weapons", chance = 1200000},
				{group = "carbines", chance = 1200000},
				{group = "clothing_attachments", chance = 250000},
				{group = "armor_attachments", chance = 250000},
				{group = "wearables_common", chance = 1000000}
			}
		}
	},
	weapons = {"rebel_weapons_heavy"},
	defaultAttack = "defaultdroidrangedattack",
	conversationTemplate = "",
	reactionStf = "@npc_reaction/battle_droid",
	personalityStf = "@hireling/hireling_military",
	attacks = merge(commandomaster,marksmanmaster,brawlermaster,pistoleermaster)
}

CreatureTemplates:addCreatureTemplate(cis_battle_droid_commando, "cis_battle_droid_commando")
