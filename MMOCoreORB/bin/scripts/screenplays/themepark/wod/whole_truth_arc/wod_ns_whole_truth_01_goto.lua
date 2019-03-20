local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodNSWholeTruth01Goto = GoToLocation:new {
	-- Task properties
	taskName = "wodNSWholeTruth01Goto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_whole_truth:task01_waypoint_name",
	spawnPoint = {x = -4227, y = -2089},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodNSWholeTruth01Goto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_01)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_02)
	wodWholeTruthArc:startEliminateQuest(pPlayer)
	return 1
end

return wodNSWholeTruth01Goto
