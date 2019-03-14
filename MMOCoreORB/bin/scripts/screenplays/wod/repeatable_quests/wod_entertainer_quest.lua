wodEntertainerQuest = ScreenPlay:new {
	targetList = "",
}

registerScreenPlay("wodEntertainerQuest", false)

local QuestManager = require("managers.quest.quest_manager")

--TODO: Timer

function wodEntertainerQuest:beginQuest()
	createObserver(STARTENTERTAIN, "wodEntertainerQuest", "notifyPerformanceObserver", pPlayer)
end

function wodEntertainerQuest:notifyPerformanceObserver(pPlayer, pPlayer2)
	if (pPlayer == nil) then
		return 1
	end
	
	if (self:isTargetCorrect(pPlayer)) then
		createObserver(FLOURISH, "wodEntertainerQuest", "notifyFlourishObserver", pPlayer)
	end

	return 0
end

function wodEntertainerQuest:isTargetCorrect(pPlayer)
	if (pPlayer == nil) then
		return false
	end
	
	local targetID = CreatureObject(pPlayer):getTargetID()
	
	if (targetID == nil) then
		return false
	end
	
	local pTarget = getSceneObject(targetID)
	
	if (pTarget == nil) then
		return false
	end
	
	local targetList = HelperFuncs:splitString(self.targetList, ";")

	if (self.targetList == SceneObject(pTarget):getObjectName() or HelperFuncs:tableContainsValue(targetList, SceneObject(pTarget):getObjectName())) then
		writeData("wodThemepark:rancorTamer:" .. SceneObject(pPlayer):getObjectID(), targetID)
		return true
	end

	return false
end

function wodEntertainerQuest:notifyFlourishObserver(pPlayer, pPlayer2, flourishID)
	if (pPlayer == nil) then
		return 1
	end
	
	local pTarget = getSceneObject(readData("wodThemepark:rancorTamer:" .. SceneObject(pPlayer):getObjectID()))
	
	if (CreatureObject(pTarget):isInCombat() or CreatureObject(pTarget):isDead() or not CreatureObject(pTarget):isAiAgent()) then
		return 1
	end
	
	local n = getRandomNumber(1, 10)
	
	if (n == 10) then
		dropObserver(FLOURISH, pPlayer)
		CreatureObject(pTarget):engageCombat(pPlayer)
		CreatureObject(pPlayer):sendSystemMessage("The rancor notices you and is angered by your actions, run!")
		return 1
	end
	
	if (n <= 2) then
		CreatureObject(pTarget):setPvpStatusBitmask(0)
		AiAgent(pTarget):setAiTemplate("escort")
		AiAgent(pTarget):setFollowObject(pPlayer)
		CreatureObject(pPlayer):sendSystemMessage("The rancor is intrigued by your actions and starts following you.")
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_RANCOR_TAMER)) then
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_RANCOR_TAMER_01)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_RANCOR_TAMER_02)
			wodEntNSReturnGoto:start(pPlayer, pTarget)
		elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_RANCOR_TAMER)) then
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_RANCOR_TAMER_01)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_RANCOR_TAMER_02)
			wodEntSMReturnGoto:start(pPlayer, pTarget)
		end
		dropObserver(STARTENTERTAIN, pPlayer)
		return 1
	end
	
	return 0
end


