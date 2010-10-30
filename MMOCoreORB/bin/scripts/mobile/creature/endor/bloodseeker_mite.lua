bloodseeker_mite = Creature:new {
	objectName = "@mob/creature_names:bloodseeker_mite",
	socialGroup = "Bloodseeker",
	pvpFaction = "",
	faction = "",
	level = 31,
	chanceHit = 0.390000,
	damageMin = 325,
	damageMax = 360,
	baseXp = 3097,
	baseHAM = 8550,
	baseHAMmax = 8550,
	armor = 0,
	resists = {-1,40,-1,100,-1,100,100,-1,-1},
	meatType = "meat_insect",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.250000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK,
	diet = CARNIVORE,

	templates = {"object/mobile/bloodseeker_mite.iff"},
	lootgroups = {},
	weapons = {"creature_spit_small_red"},
	attacks = {
		{"dizzyattack","dizzyChance=50"},
		{"posturedownattack","postureDownChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(bloodseeker_mite, "bloodseeker_mite")