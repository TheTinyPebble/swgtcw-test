local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodProKillSpiderclanGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodProKillSpiderclanGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_prologue_kill_rancor:task01_waypoint_name",
	spawnPoint = {x = -1219, y = 6262}, -- Spider Clan cave
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodProKillSpiderclanGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer) -- TODO: Add to completed kills instead, before activating return
	return 1
end

-- Event handler for the onSuccessfulSpawn.
-- The event will activate the quest.
-- @param pPlayer pointer to the creature object of the player.
function wodProKillSpiderclanGoto:onSuccessfulSpawn(pPlayer)
	if (pPlayer == nil) then
		return
	end

	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_01)
end

return wodProKillSpiderclanGoto