local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodOutcast2GoTo = GoToLocation:new {
	-- Task properties
	taskName = "wodOutcast2GoTo",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_outcast_2:task01_waypoint_name",
	spawnPoint = {x = -1000, y = 862},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodOutcast2GoTo:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodOutcast2GoTo