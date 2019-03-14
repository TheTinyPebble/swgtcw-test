local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

local QuestManager = require("managers.quest.quest_manager")
local Logger = require("utils.logger")

wodEntNSReturnEscort = Escort:new {
	-- Task properties
	taskName = "wodEntNSReturnEscort",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_rancor_tamer:task02_waypoint_name",
	returnPoint = {x = -4086, y = -156},
	returnPlanet = "dathomir",
	areaRadius = 16,
}

function wodEntNSReturnEscort:onEnteredActiveArea(pPlayer)
	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_RANCOR_TAMER_02)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_RANCOR_TAMER_03)
end

return wodEntNSReturnEscort

wodEntSMReturnEscort = Escort:new {
	-- Task properties
	taskName = "wodEntSMReturnEscort",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_rancor_tamer:task02_waypoint_name",
	returnPoint = {x = 139, y = 4489},
	returnPlanet = "dathomir",
	spawnRadius = 5,
}

function wodEntSMReturnEscort:onEnteredActiveArea(pPlayer)
	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_RANCOR_TAMER_02)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_RANCOR_TAMER_03)
end

return wodEntSMReturnEscort