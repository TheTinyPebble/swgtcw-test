local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodLeftBehindReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodLeftBehindReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_left_behind:task03_waypoint_name",
	spawnPoint = {x = -3177, y = 3184},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodLeftBehindReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodLeftBehindReturnGoto