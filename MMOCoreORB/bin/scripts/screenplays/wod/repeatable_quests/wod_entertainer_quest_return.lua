local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodEntNSReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodEntNSReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_rancor_tamer:task02_waypoint_name",
	spawnPoint = {x = -4086, y = -156},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodEntNSReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodEntNSReturnGoto

wodEntSMReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodEntSMReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_rancor_tamer:task02_waypoint_name",
	spawnPoint = {x = 139, y = 4489},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodEntSMReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodEntSMReturnGoto