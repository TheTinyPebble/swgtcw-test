--Automatically generated by SWGEmu Spawn Tool v0.12 loot editor.

armor_battle_belt = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Kamino Assault Belt",
	directObjectTemplate = "object/tangible/wearables/armor/sep_battle_theme/armor_sep_theme_belt.iff",
	craftingValues = {
		{"armor_rating",1,1,0},
	        {"armor_effectiveness",50,50,0},
					{"energyeffectiveness",10,10,0},
					{"kineticeffectiveness",10,10,0},
					{"blasteffectiveness",10,10,0},
	        {"armor_integrity",45000,45000,0},
	        {"armor_health_encumbrance",100,100,0},
	        {"armor_action_encumbrance",100,100,0},
	        {"armor_mind_encumbrance",300,300,0},
	},
	customizationStringNames = {},
	customizationValues = {},
	skillMods = {{"blind_defense", 5}}
}

addLootItemTemplate("armor_battle_belt", armor_battle_belt)
