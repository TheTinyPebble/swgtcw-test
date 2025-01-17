local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodKillOtherClanSMReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodKillOtherClanSMReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_kill_clan:task02_waypoint_name",
	spawnPoint = {x = 168, y = 4484},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodKillOtherClanSMReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

-- Event handler for the onSuccessfulSpawn.
-- The event will activate the quest.
-- @param pPlayer pointer to the creature object of the player.
function wodKillOtherClanSMReturnGoto:onSuccessfulSpawn(pPlayer)
	if (pPlayer == nil) then
		return
	end

end

function wodKillOtherClanSMReturnGoto:onLoggedIn(pPlayer)
	if (self:hasTaskStarted(pPlayer)) then
		return 0
	end
	self:start(pPlayer)
	return 0
end

return wodKillOtherClanSMReturnGoto
