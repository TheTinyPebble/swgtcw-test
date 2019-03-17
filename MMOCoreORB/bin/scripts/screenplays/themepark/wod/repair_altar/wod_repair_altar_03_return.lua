local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodNSRepairAltar03ReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodNSRepairAltar03ReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_repair_altar_03:task03_waypoint_name",
	spawnPoint = {x = -4002, y = -58},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodNSRepairAltar03ReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_03_03)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_03_04)
	self:finish(pPlayer)
	return 1
end

return wodNSRepairAltar03ReturnGoto

wodSMRepairAltar03ReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodSMRepairAltar03ReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_repair_altar_03:task03_waypoint_name",
	spawnPoint = {x = 156, y = 4527},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodSMRepairAltar03ReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_03_03)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_03_04)
	self:finish(pPlayer)
	return 1
end

return wodSMRepairAltar03ReturnGoto