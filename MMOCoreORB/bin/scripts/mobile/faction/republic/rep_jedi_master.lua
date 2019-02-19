rep_jedi_master = Creature:new {
	objectName = "@mob/creature_names:rep_jedi_master",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "self",
	faction = "imperial",
	level = 300,
	chanceHit = 27.25,
	damageMin = 1645,
	damageMax = 3000,
	baseXp = 25266,
	baseHAM = 151060,
	baseHAMmax = 185020,
	armor = 3,
	resists = {90,90,90,90,90,90,90,90,45},
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
	optionsBitmask = AIENABLED + CONVERSABLE,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dressed_jedi_trainer_old_human_male_01.iff", --old human male
		"object/mobile/dressed_jedi_trainer_chiss_male_01.iff", --chiss
		"object/mobile/kit_fisto_cloak.iff" --nautolan
		},

		lootGroups = {
			{
				groups = {
					{group = "power_crystals", chance = 800000},
					{group = "color_crystals", chance = 700000},
					{group = "holocron_light", chance = 4000000},
					{group = "melee_weapons", chance = 1000000},
					{group = "armor_attachments", chance = 1000000},
					{group = "clothing_attachments", chance = 1000000},
					{group = "wearables_all", chance = 1400000},
					{group = "force_hunter_rare", chance = 100000}
				}
			}
		},
	weapons = {"light_jedi_weapons_basic"},
	conversationTemplate = "imperialRecruiterConvoTemplate",
	attacks = merge(lightsabermaster,forcepowermaster)
}

CreatureTemplates:addCreatureTemplate(rep_jedi_master, "rep_jedi_master")
