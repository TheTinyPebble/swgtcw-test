local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodNSRepairAltar02ReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodNSRepairAltar02ReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_repair_altar_02:task03_waypoint_name",
	spawnPoint = {x = -4002, y = -58},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodNSRepairAltar02ReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_02_03)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_02_04)
	self:finish(pPlayer)
	return 1
end

return wodNSRepairAltar02ReturnGoto

wodSMRepairAltar02ReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodSMRepairAltar02ReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_repair_altar_02:task03_waypoint_name",
	spawnPoint = {x = 156, y = 4527},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodSMRepairAltar02ReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_02_03)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_02_04)
	self:finish(pPlayer)
	return 1
end

return wodSMRepairAltar02ReturnGoto