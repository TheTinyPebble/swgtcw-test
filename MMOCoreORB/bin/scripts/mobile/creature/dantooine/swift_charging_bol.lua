swift_charging_bol = Creature:new {
	objectName = "@mob/creature_names:bol_swift_charger",
	socialGroup = "Bol",
	pvpFaction = "",
	faction = "",
	level = 34,
	chanceHit = 0.410000,
	damageMin = 310,
	damageMax = 330,
	baseXp = 3370,
	baseHAM = 9700,
	baseHAMmax = 9700,
	armor = 0,
	resists = {20,20,0,0,0,0,0,0,-1},
	meatType = "meat_herbivore",
	meatAmount = 0,
	hideType = "hide_leathery",
	hideAmount = 300,
	boneType = "bone_mammal",
	boneAmount = 180,
	milk = 0,
	tamingChance = 0.050000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + HERD,
	diet = CARNIVORE,

	templates = {"object/mobile/bol.iff"},
	lootgroups = {},
	weapons = {},
	attacks = {
		{"knockdownattack","knockdownChance=50"},
		{"stunattack","stunChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(swift_charging_bol, "swift_charging_bol")