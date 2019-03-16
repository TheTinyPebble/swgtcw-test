local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodOutcast5GoTo = GoToLocation:new {
	-- Task properties
	taskName = "wodOutcast5GoTo",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_outcast_5:task01_waypoint_name",
	spawnPoint = {x = 1125, y = -1022},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodOutcast5GoTo:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodOutcast5GoTo