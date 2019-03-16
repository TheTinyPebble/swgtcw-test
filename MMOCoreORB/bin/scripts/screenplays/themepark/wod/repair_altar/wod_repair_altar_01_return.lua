local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodRepairAltar01NSReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodRepairAltar01NSReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_repair_altar_01:task03_waypoint_name",
	spawnPoint = {x = -4002, y = -58},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodRepairAltar01NSReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodRepairAltar01NSReturnGoto

wodRepairAltar01SMReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodRepairAltar01SMReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_repair_altar_01:task03_waypoint_name",
	spawnPoint = {x = 156, y = 4527},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodRepairAltar01SMReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodRepairAltar01SMReturnGoto