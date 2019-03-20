local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodWalkabout8Goto = GoToLocation:new {
	-- Task properties
	taskName = "wodWalkabout8Goto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_prologue_walkabout:task08_waypoint_name",
	spawnPoint = {x = -4128, y = 115},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodWalkabout8Goto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodWalkabout8Goto