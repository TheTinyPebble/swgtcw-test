local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodHuntingNSReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodHuntingNSReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_hunting:task02_waypoint_name",
	spawnPoint = {x = -4086, y = -156},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodHuntingNSReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodHuntingNSReturnGoto