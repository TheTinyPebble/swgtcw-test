local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodNSRepairAltar01ReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodNSRepairAltar01ReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_repair_altar_01:task03_waypoint_name",
	spawnPoint = {x = -4002, y = -58},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodNSRepairAltar01ReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_01_03)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_01_04)
	self:finish(pPlayer)
	return 1
end

return wodNSRepairAltar01ReturnGoto

wodSMRepairAltar01ReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodSMRepairAltar01ReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_repair_altar_01:task03_waypoint_name",
	spawnPoint = {x = 156, y = 4527},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodSMRepairAltar01ReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_01_03)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_01_04)
	self:finish(pPlayer)
	return 1
end

return wodSMRepairAltar01ReturnGoto