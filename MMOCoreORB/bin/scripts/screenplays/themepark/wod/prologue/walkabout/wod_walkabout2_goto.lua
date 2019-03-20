local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodWalkabout2Goto = GoToLocation:new {
	-- Task properties
	taskName = "wodWalkabout2Goto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_prologue_walkabout:task02_waypoint_name",
	spawnPoint = {x = 4747, y = 2399},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodWalkabout2Goto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	self:sendCommMessage(pPlayer)
	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT_02)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT_03)
	wodWalkabout3Goto:start(pPlayer)
	return 1
end

function wodWalkabout2Goto:sendCommMessage(pPlayer)
	local sui = SuiMessageBox.new("wodWalkabout2Goto", "noCallBack")
	sui.setTitle("@theme_park_wod/wod_prologue_walkabout:comm_message_title_02")
	sui.setPrompt("@theme_park_wod/wod_prologue_walkabout:task02_comm_message_text_02")
	sui.hideCancelButton()
	sui.sendTo(pPlayer)
end

function wodWalkabout2Goto:noCallback(pPlayer, pSui, eventIndex, ...)
end

return wodWalkabout2Goto