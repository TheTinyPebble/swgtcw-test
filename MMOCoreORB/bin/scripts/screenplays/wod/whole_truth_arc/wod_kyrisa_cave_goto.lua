local QuestManager = require("managers.quest.quest_manager")
require("utils.helpers")

wodNSKyrisaCaveGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodNSKyrisaCaveGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_ns_kyrisa_boss_fight:task01_waypoint_name",
	spawnPoint = {x = 1993, y = 1823},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodNSKyrisaCaveGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_KYRISA_BOSS_FIGHT_01)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_KYRISA_BOSS_FIGHT_02)
	
	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	
	if (pGhost == nil) then
		return
	end
	
	PlayerObject(pGhost):addWaypoint("dathomir", "theme_park_wod/wod_ns_kyrisa_boss_fight:task02_waypoint_name", "", 1726, 2141, WAYPOINTYELLOW, true, true, 0)
	return 1
end

return wodNSKyrisaCaveGoto

wodSMKyrisaCaveGoto = GoToLocation:new {
	-- Task properties
	taskName = "wodSMKyrisaCaveGoto",
	-- GoToLocation properties
	waypointDescription = "@theme_park_wod/wod_sm_kyrisa_boss_fight:task01_waypoint_name",
	spawnPoint = {x = 1993, y = 1823},
	spawnPlanet = "dathomir",
	spawnRadius = 5,
}

-- Event handler for the enter active area event.
-- The event will complete the task.
-- @param pPlayer pointer to the creature object of the player.
function wodSMKyrisaCaveGoto:onEnteredActiveArea(pPlayer)
	if (pPlayer == nil) then
		return 1
	end

	self:finish(pPlayer)
	QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_KYRISA_BOSS_FIGHT_01)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_KYRISA_BOSS_FIGHT_02)
	
	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	
	if (pGhost == nil) then
		return
	end
	
	PlayerObject(pGhost):addWaypoint("dathomir", "@theme_park_wod/wod_ns_kyrisa_boss_fight:task02_waypoint_name", "", 1726, 2141, WAYPOINTYELLOW, true, true, 0)
	return 1
end

return wodSMKyrisaCaveGoto