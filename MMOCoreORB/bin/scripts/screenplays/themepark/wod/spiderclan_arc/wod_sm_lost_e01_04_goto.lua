local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodSMLostE0104Goto = GoToLocation:new {
	-- Task properties
	taskName = "wodSMLostE0104Goto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_lost_e01:task04_waypoint_name",
	spawnPoint = {x = -1217, y = 6261},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodSMLostE0104Goto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E01_04)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E01_05)
	wodSMLostE0105Goto:start(pPlayer)
	return 1
end

-- Event handler for the onSuccessfulSpawn.
-- The event will activate the quest.
-- @param pPlayer pointer to the creature object of the player.
function wodSMLostE0104Goto:onSuccessfulSpawn(pPlayer)
	if (pPlayer == nil) then
		return
	end

end

function wodSMLostE0104Goto:onLoggedIn(pPlayer)
	if (self:hasTaskStarted(pPlayer)) then
		return 0
	end
	self:start(pPlayer)
	return 0
end

-- Event handler for the onSuccessfulSpawn.
-- The event will activate the quest.
-- @param pPlayer pointer to the creature object of the player.
function wodSMLostE0104Goto:onSuccessfulSpawn(pPlayer)
	if (pPlayer == nil) then
		return
	end

	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E01_04)
end

return wodSMLostE0104Goto
