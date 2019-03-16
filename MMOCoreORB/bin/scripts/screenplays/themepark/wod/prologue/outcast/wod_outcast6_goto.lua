local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodOutcast6GoTo = GoToLocation:new {
	-- Task properties
	taskName = "wodOutcast6GoTo",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_outcast_6:task01_waypoint_name",
	spawnPoint = {x = -856, y = 2788},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodOutcast6GoTo:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodOutcast6GoTo