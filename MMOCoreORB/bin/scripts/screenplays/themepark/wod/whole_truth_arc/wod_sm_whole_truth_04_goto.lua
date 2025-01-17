local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodSMWholeTruth04Goto = GoToLocation:new {
	-- Task properties
	taskName = "wodSMWholeTruth04Goto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_whole_truth:task04_waypoint_name",
	spawnPoint = {x = 1993, y = 1823},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodSMWholeTruth04Goto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_WHOLE_TRUTH_04)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_WHOLE_TRUTH_05)
	return 1
end

-- Event handler for the onSuccessfulSpawn.
-- The event will activate the quest.
-- @param pPlayer pointer to the creature object of the player.
function wodSMWholeTruth04Goto:onSuccessfulSpawn(pPlayer)
	if (pPlayer == nil) then
		return
	end

end

function wodSMWholeTruth04Goto:onLoggedIn(pPlayer)
	if (self:hasTaskStarted(pPlayer)) then
		return 0
	end
	self:start(pPlayer)
	return 0
end

return wodSMWholeTruth04Goto
