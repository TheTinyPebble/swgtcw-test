local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodMysteriousWitchGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodMysteriousWitchGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_prologue_walkabout:task07_waypoint_name",
	spawnPoint = {x = -3177, y = 3184},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodMysteriousWitchGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	return 1
end

-- Event handler for the onSuccessfulSpawn.
-- The event will activate the quest.
-- @param pPlayer pointer to the creature object of the player.
function wodMysteriousWitchGoto:onSuccessfulSpawn(pPlayer)
	if (pPlayer == nil) then
		return
	end

	self:sendCommMessage(pPlayer)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_MEET_MYSTERIOUS_WITCH)
end

function wodMysteriousWitchGoto:sendCommMessage(pPlayer)
	local sui = SuiMessageBox.new("wodMysteriousWitchGoto", "noCallBack")
	sui.setTitle("@theme_park_wod/wod_prologue_walkabout:comm_message_title_02")
	sui.setPrompt("@theme_park_wod/wod_prologue_walkabout:task09_comm_message_text_02")
	sui.hideCancelButton()
	sui.sendTo(pPlayer)
end

function wodMysteriousWitchGoto:noCallback(pPlayer, pSui, eventIndex, ...)
end

return wodMysteriousWitchGoto