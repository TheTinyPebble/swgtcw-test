easter_durni = Creature:new {
	customName = "Easter durni",
	socialGroup = "durni",
	faction = "",
	level = 157,
	chanceHit = 92.5,
	damageMin = 935,
	damageMax = 1580,
	baseXp = 14884,
	baseHAM = 96000,
	baseHAMmax = 118000,
	armor = 2,
	resists = {130,145,155,155,145,30,30,30,45},
	meatType = "meat_herbivore",
	meatAmount = 5,
	hideType = "hide_wooly",
	hideAmount = 3,
	boneType = "bone_mammal",
	boneAmount = 2,
	milk = 0,
	tamingChance = 0.25,
	ferocity = 0,
	scale = 2,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = NONE,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/durni.iff"},
	controlDeviceTemplate = "object/intangible/pet/durni_hue.iff",
	lootGroups = {
		{
			groups = {
				{group = "event_token", chance = 9900000},
				{group = "durni_reward", chance = 100000},
			},
			lootChance = 2000000
		}
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(easter_durni, "easter_durni")
