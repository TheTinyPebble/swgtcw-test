local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodSister1ReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodSister1ReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sister1:task05_waypoint_name",
	spawnPoint = {x = -6895, y = -4853},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodSister1ReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

-- Event handler for the onSuccessfulSpawn.
-- The event will activate the quest.
-- @param pPlayer pointer to the creature object of the player.
function wodSister1ReturnGoto:onSuccessfulSpawn(pPlayer)
	if (pPlayer == nil) then
		return
	end

end

function wodSister1ReturnGoto:onLoggedIn(pPlayer)
	if (self:hasTaskStarted(pPlayer)) then
		return 0
	end
	self:start(pPlayer)
	return 0
end

return wodSister1ReturnGoto
