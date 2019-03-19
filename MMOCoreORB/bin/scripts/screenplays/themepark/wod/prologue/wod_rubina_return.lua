local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodRubinaReturnGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodRubinaReturnGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/messages:rubina_return_waypoint_name",
	spawnPoint = {x = -3177, y = 3184},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodRubinaReturnGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

return wodRubinaReturnGoto