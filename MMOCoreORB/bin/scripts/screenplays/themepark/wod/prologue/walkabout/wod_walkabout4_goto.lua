local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodWalkabout4Goto = GoToLocation:new {
	-- Task properties
	taskName = "wodWalkabout4Goto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_prologue_walkabout:task04_waypoint_name",
	spawnPoint = {x = 558, y = 3073},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodWalkabout4Goto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end
	
	self:finish(pPlayer)
	return 1
end

-- Event handler for the onSuccessfulSpawn.
-- The event will activate the quest.
-- @param pPlayer pointer to the creature object of the player.
function wodWalkabout4Goto:onSuccessfulSpawn(pPlayer)
	if (pPlayer == nil) then
		return
	end

	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT_04)
end

function wodWalkabout4Goto:sendCommMessage(pPlayer)
	local sui = SuiMessageBox.new("wodWalkabout4Goto", "noCallBack")
	sui.setTitle("@theme_park_wod/wod_prologue_walkabout:comm_message_title_02")
	sui.setPrompt("@theme_park_wod/wod_prologue_walkabout:task04_comm_message_text_02")
	sui.hideCancelButton()
	sui.sendTo(pPlayer)
end

function wodWalkabout4Goto:noCallback(pPlayer, pSui, eventIndex, ...)
end

return wodWalkabout4Goto