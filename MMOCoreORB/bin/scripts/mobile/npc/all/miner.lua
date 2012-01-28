miner = Creature:new {
	objectName = "@mob/creature_names:miner",
	socialGroup = "Townsperson",
	pvpFaction = "Townsperson",
	faction = "",
	level = 5,
	chanceHit = 0.25,
	damageMin = 45,
	damageMax = 50,
	baseXp = 85,
	baseHAM = 135,
	baseHAMmax = 165,
	armor = 0,
	resists = {25,25,25,25,25,25,25,-1,-1},
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
	creatureBitmask = NONE,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_garyn_vigo_bith_male_01.iff", "object/mobile/dressed_smuggler_trainer_01.iff"},--these need to be replaced by custom outfitted humans/bith
	lootgroups = {},
	weapons = {"rebel_weapons_light"},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(miner, "miner")