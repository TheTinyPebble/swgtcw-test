nitra_vendallan_missions =
{
	{
		missionType = "escort",
		primarySpawns =
		{
			{ npcTemplate = "nitra_vendallan_imp", npcName = "Drenn Biktor (a Republic Non-Comm defector)" } 
		},
		secondarySpawns = {},
		itemSpawns = {},
		rewards =
		{
			{ rewardType = "faction", faction = "rebel", amount = 100 },
		}
	},
	{
		missionType = "escort",
		primarySpawns =
		{
			{ npcTemplate = "nitra_vendallan_imp2", npcName = "Vil Sembian" }
		},
		secondarySpawns = {},
		itemSpawns = {},
		rewards =
		{
			{ rewardType = "faction", faction = "rebel", amount = 250 },
		}
	},
}

npcMapNitraVendallan =
{
	{
		spawnData = { npcTemplate = "nitra_vendallan", x = -2.95305, z = 0.40827, y = -9.30713, direction = 12.2342, cellID = 1213345, position = STAND },
		worldPosition = { x = 134.7, y = -5347.1 },
		npcNumber = 1,
		stfFile = "@static_npc/tatooine/nitra_vendallan",
		missions = nitra_vendallan_missions
	},
}

NitraVendallan = ThemeParkLogic:new {
	npcMap = npcMapNitraVendallan,
	className = "NitraVendallan",
	screenPlayState = "nitra_vendallan_quest",
	planetName = "tatooine",
	distance = 1000,
	faction = FACTIONREBEL
}

registerScreenPlay("NitraVendallan", true)

nitra_vendallan_mission_giver_conv_handler = mission_giver_conv_handler:new {
	themePark = NitraVendallan
}
nitra_vendallan_mission_target_conv_handler = mission_target_conv_handler:new {
	themePark = NitraVendallan
}
