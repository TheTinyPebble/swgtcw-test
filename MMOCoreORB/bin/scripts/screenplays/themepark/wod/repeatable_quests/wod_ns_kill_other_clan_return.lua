local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodKillOtherClanNSReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodKillOtherClanNSReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_kill_clan:task02_waypoint_name",
	spawnPoint = {x = -4088, y = -136},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodKillOtherClanNSReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodKillOtherClanNSReturnGoto
