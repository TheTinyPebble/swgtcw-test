local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodNSEHSReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodNSEHSReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_ehs:task04_waypoint_name",
	spawnPoint = {x = -4102, y = -166},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodNSEHSReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodNSEHSReturnGoto

wodSMEHSReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodSMEHSReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_ehs:task04_waypoint_name",
	spawnPoint = {x = 149, y = 4500},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodSMEHSReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodSMEHSReturnGoto