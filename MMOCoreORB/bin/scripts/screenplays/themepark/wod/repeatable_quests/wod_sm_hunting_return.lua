local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodHuntingSMReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodHuntingSMReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_hunting:task02_waypoint_name",
	spawnPoint = {x = 139, y = 4489},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodHuntingSMReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodHuntingSMReturnGoto