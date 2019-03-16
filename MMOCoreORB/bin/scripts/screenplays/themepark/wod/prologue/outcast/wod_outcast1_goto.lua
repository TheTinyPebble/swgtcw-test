local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodOutcast1GoTo = GoToLocation:new {
	-- Task properties
	taskName = "wodOutcast1GoTo",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_outcast_1:task01_waypoint_name",
	spawnPoint = {x = 866, y = 1095},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodOutcast1GoTo:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodOutcast1GoTo