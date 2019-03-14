local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodFishingNSReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodFishingNSReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_fishing:task02_waypoint_name",
	spawnPoint = {x = -4086, y = -156},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodFishingNSReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodFishingNSReturnGoto

wodFishingSMReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodFishingSMReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_fishing:task02_waypoint_name",
	spawnPoint = {x = 139, y = 4489},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodFishingSMReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodFishingSMReturnGoto