local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodNSLostE0105Goto = GoToLocation:new {
	-- Task properties
	taskName = "wodNSLostE0105Goto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_lost_e01:task05_waypoint_name",
	spawnPoint = {x = -4102, y = -166},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodNSLostE0105Goto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodNSLostE0105Goto
