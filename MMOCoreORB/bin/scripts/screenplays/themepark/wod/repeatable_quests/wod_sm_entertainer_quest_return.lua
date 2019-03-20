local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodEntSMReturnEscort = Escort:new {
	-- Task properties
	taskName = "wodEntSMReturnEscort",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_rancor_tamer:task02_waypoint_name",
	returnPoint = {x = 528, y = 4208},
	returnPlanet = "dathomir",
	areaRadius = 16,
}

function wodEntSMReturnEscort:onEnteredActiveArea(pPlayer)
	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_RANCOR_TAMER_02)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_RANCOR_TAMER_03)
	dropObserver(STARTENTERTAIN, pPlayer)
	CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:rancor_returned_sm")
end

return wodEntSMReturnEscort