restuss_fisto_missions =
{
	{
		missionType = "assassinate",
		primarySpawns =
		{
			{ npcTemplate = "tusk_cat", npcName = "a Tusk Cat" }
		},
		secondarySpawns =
		{

		},
		itemSpawns =
		{

		},
		rewards =
		{
			{ rewardType = "credits", amount = 50 },
			{ rewardType = "faction", faction = "naboo", amount = 5 }
		}
	},
	{
		missionType = "escort",
		primarySpawns =
		{
			{ npcTemplate = "draya_korbinari_thief", npcName = "a Thief" }
		},
		secondarySpawns =
		{

		},
		itemSpawns =
		{

		},
		rewards =
		{
			{ rewardType = "credits", amount = 30 },
			{ rewardType = "faction", faction = "naboo", amount = 5 }
		}
	},
	{
		missionType = "confiscate",
		primarySpawns =
		{
			{ npcTemplate = "draya_korbinari_smuggler", npcName = "a Smuggler" }
		},
		secondarySpawns =
		{

		},
		itemSpawns =
		{
			{ itemTemplate = "object/tangible/mission/quest_item/draya_korbinari_q3_needed.iff", itemName = "" }
		},
		rewards =
		{
			{ rewardType = "credits", amount = 30 },
			{ rewardType = "faction", faction = "naboo", amount = 5 }
		}
	},
	{
		missionType = "assassinate",
		primarySpawns =
		{
			{ npcTemplate = "draya_korbinari_bounty_hunter", npcName = "a Bounty Hunter" }
		},
		secondarySpawns =
		{

		},
		itemSpawns =
		{

		},
		rewards =
		{
			{ rewardType = "credits", amount = 40 },
			{ rewardType = "faction", faction = "naboo", amount = 5 }
		}
	}
}

npcMapRestussFisto =
{
	{
		spawnData = { npcTemplate = "restuss_kit_fisto", x = 5233, z = 80, y = 5830, direction = 120, cellID = 0, position = STAND },
		worldPosition = { x = 5233, y = 5830 },
		npcNumber = 1,
		stfFile = "@static_npc/rori/rori_restuss_draya_korbinari",
		missions = restuss_fisto_missions
	},
}

RestussFisto = ThemeParkLogic:new {
	npcMap = npcMapRestussFisto,
	className = "RestussFisto",
	screenPlayState = "restuss_fisto_quest",
	planetName = "rori",
	distance = 500
}

registerScreenPlay("RestussFisto", true)

restuss_fisto_mission_giver_conv_handler = mission_giver_conv_handler:new {
	themePark = RestussFisto
}
restuss_fisto_mission_target_conv_handler = mission_target_conv_handler:new {
	themePark = RestussFisto
}
