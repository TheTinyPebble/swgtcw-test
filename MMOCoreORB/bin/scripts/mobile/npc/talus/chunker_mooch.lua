chunker_mooch = Creature:new {
	objectName = "@mob/creature_names:chunker_mooch",
	socialGroup = "Chunker Gang",
	pvpFaction = "",
	faction = "",
	level = 7,
	chanceHit = 0.260000,
	damageMin = 55,
	damageMax = 65,
	baseXp = 187,
	baseHAM = 270,
	baseHAMmax = 330,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK,
	diet = HERBIVORE,

	templates = {},
	lootGroups = {
	    {
	        groups = {
				{group = "junk", chance = 2000000},
				{group = "rifles", chance = 2000000},
				{group = "melee_knife", chance = 2000000},
				{group = "pistols", chance = 2000000},
				{group = "carbines", chance = 2000000}
	    	},
			lootChance = 5000000
		}	
	},
	weapons = {"pirate_weapons_light"},
	attacks = {}
}

CreatureTemplates:addCreatureTemplate(chunker_mooch, "chunker_mooch")