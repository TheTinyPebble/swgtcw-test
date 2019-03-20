local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodSMWholeTruth03Goto = GoToLocation:new {
	-- Task properties
	taskName = "wodSMWholeTruth03Goto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_whole_truth:task03_waypoint_name",
	spawnPoint = {x = 151, y = 4482},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodSMWholeTruth03Goto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_WHOLE_TRUTH_03)
	return 1
end

return wodSMWholeTruth03Goto
