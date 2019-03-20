local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodNSWholeTruth04Goto = GoToLocation:new {
	-- Task properties
	taskName = "wodNSWholeTruth04Goto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_whole_truth:task04_waypoint_name",
	spawnPoint = {x = 1823, y = 1993},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodNSWholeTruth04Goto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_03)
	return 1
end

return wodNSWholeTruth04Goto
