fbase_imperial_colonel = Creature:new {
	objectName = "@mob/creature_names:rep_jedi_knight",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "imperial",
	faction = "imperial",
	level = 90,
	chanceHit = 0.9,
	damageMin = 600,
	damageMax = 900,
	baseXp = 9000,
	baseHAM = 18700,
	baseHAMmax = 20700,
	armor = 2,
	resists = {30,30,30,30,30,30,30,30,30},
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
		"object/mobile/dressed_jedi_knight_01.iff",--knight robe, blonde
		"object/mobile/dressed_jedi_knight_02.iff", --dathomirian
		"object/mobile/dressed_neja_bertolo.iff", --twilek grey robes
		"object/mobile/dressed_jedi_knight_03.iff", --elder robe
		"object/mobile/dressed_jedi_knight_04.iff", --elder robe
		"object/mobile/dressed_jedi_knight_05.iff", --knight robe --mohawk/red
		"object/mobile/dressed_jedi_knight_06.iff", --knight robe --mohawk/red
		"object/mobile/dressed_jedi_trainer_twilek_female_01.iff", --female twilek cloak
		"object/mobile/dressed_jedi_trainer_nikto_male_01.iff", --nikto male
		"object/mobile/dressed_jedi_trainer_old_human_male_01.iff", --old human male, dark skin
		"object/mobile/dressed_jedi_trainer_chiss_male_01.iff", --chiss
		"object/mobile/kit_fisto_cloak.iff", --nautolan
		"object/mobile/dressed_tiberus_anderlock.iff" --old human male, white
		},
	lootGroups = {
		{
			groups = {
				{group = "color_crystals", chance = 100000},
				{group = "junk", chance = 6000000},
				{group = "weapons_all", chance = 1100000},
				{group = "armor_all", chance = 1100000},
				{group = "clothing_attachments", chance = 150000},
				{group = "armor_attachments", chance = 150000},
				{group = "imperial_officer_common", chance = 400000},
				{group = "wearables_all", chance = 1000000}
			}
		}
	},
	weapons = {"light_jedi_weapons_basic"},
	conversationTemplate = "imperialRecruiterConvoTemplate",
	attacks = merge(lightsabermaster,forcepowermaster)
}

CreatureTemplates:addCreatureTemplate(fbase_imperial_colonel, "fbase_imperial_colonel")
