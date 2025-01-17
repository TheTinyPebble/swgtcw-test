gramm_rile_missions =
	{
		{
			missionType = "escort",
			primarySpawns =
			{
				{ npcTemplate = "gramm_surveyor", npcName = "a Surveyor" }
			},
			secondarySpawns = {},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 2000 },
			}
		},
		{
			missionType = "escort",
			primarySpawns =
			{
				{ npcTemplate = "gramm_surveyor", npcName = "a Farmer" }
			},
			secondarySpawns =	{},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 5000 },
			}
		},
		{
			missionType = "escort",
			primarySpawns =
			{
				{ npcTemplate = "gramm_businessman", npcName = "a Businessman" }
			},
			secondarySpawns =	{},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 7500 },
			}
		},
		{
			missionType = "escort",
			primarySpawns =
			{
				{ npcTemplate = "chastina_rile", npcName = "Chastina Rile" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "tusken_raider", npcName = "", dead = "true" },
				{ npcTemplate = "tusken_raider", npcName = "", dead = "true" },
				{ npcTemplate = "tusken_raider", npcName = "", dead = "true" },
				{ npcTemplate = "tusken_raider", npcName = "", dead = "true" },
				{ npcTemplate = "tusken_raider", npcName = "", dead = "true" },
				{ npcTemplate = "tusken_raider", npcName = "", dead = "true" },
				{ npcTemplate = "tusken_raider", npcName = "", dead = "true" },
				{ npcTemplate = "tusken_raider", npcName = "", dead = "true" },
				{ npcTemplate = "tusken_raider", npcName = "", dead = "true" },
				{ npcTemplate = "tusken_raider", npcName = "", dead = "true" },
				{ npcTemplate = "tusken_raider", npcName = "", dead = "true" },
				{ npcTemplate = "tusken_raider", npcName = "", dead = "true" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 12000 },
			}
		}
	}

npcMapGrammRile =
	{
		{
			spawnData = { npcTemplate = "gramm_rile", x = 3887.3, z = 33, y = 2348.6, direction = 300, cellID = 0, position = STAND },
			worldPosition = { x = 3887, y = 2347 },
			npcNumber = 1,
			stfFile = "@static_npc/tatooine/gramm_rile",
			missions = gramm_rile_missions
		},
	}

GrammRile = ThemeParkLogic:new {
	npcMap = npcMapGrammRile,
	className = "GrammRile",
	screenPlayState = "gramm_rile_quest",
	planetName = "tatooine",
	distance = 600
}

registerScreenPlay("GrammRile", true)

gramm_rile_mission_giver_conv_handler = mission_giver_conv_handler:new {
	themePark = GrammRile
}
gramm_rile_mission_target_conv_handler = mission_target_conv_handler:new {
	themePark = GrammRile
}
