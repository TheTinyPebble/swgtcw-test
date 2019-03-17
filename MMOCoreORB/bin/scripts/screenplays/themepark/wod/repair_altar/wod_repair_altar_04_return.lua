local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodNSRepairAltar04ReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodNSRepairAltar04ReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_repair_altar_04:task03_waypoint_name",
	spawnPoint = {x = -4002, y = -58},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodNSRepairAltar04ReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_04_03)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_04_04)
	self:finish(pPlayer)
	return 1
end

return wodNSRepairAltar04ReturnGoto

wodSMRepairAltar04ReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodSMRepairAltar04ReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_repair_altar_04:task03_waypoint_name",
	spawnPoint = {x = 156, y = 4527},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodSMRepairAltar04ReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_04_03)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_04_04)
	self:finish(pPlayer)
	return 1
end

return wodSMRepairAltar04ReturnGoto