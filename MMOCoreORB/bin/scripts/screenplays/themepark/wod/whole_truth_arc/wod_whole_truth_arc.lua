wodWholeTruthArc = ScreenPlay:new {

}

registerScreenPlay("wodWholeTruthArc", true)

local QuestManager = require("managers.quest.quest_manager")

-- TODO: Boss Fight
-- TODO: Reward handling

function wodWholeTruthArc:start()
	self:spawnCagedRancor()
end

function wodWholeTruthArc:spawnCagedRancor()
	--local pRancor = spawnMobile()
	CreatureObject(pRancor):setPvpStatusBitmask(0)
	writeData("wodThemepark:cagedRancorID", SceneObject(pRancor):getObjectID())
end

function wodWholeTruthArc:startBossFight()	
	local pCagedRancor = getSceneObject(readData("wodThemepark:cagedRancorID"))
	SceneObject(pCagedRancor):destroyObjectFromWorld()
	
	--local pBoss = spawnMobile()
	createObserver(OBJECTDESTRUCTION, "wodWholeTruthArc", "notifyBossKilled", pBoss)
	writeData("wodThemepark:rancorBossState", 1)
	createEvent(10 * 1000, "wodWholeTruthArc", "sendMessageToGroup", pBoss, "")
	createEvent(10 * 60 * 1000, "wodWholeTruthArc", "failBossFight", pBoss, "")
	self:sendMessageToGroup(pBoss)
end

function wodWholeTruthArc:notifyBossKilled(pBoss)
	if (pBoss == nil) then
		return 1
	end
	
	local pOwner = getSceneObject(readData("wodThemepark:rancorBossFightOwnerID"))
	
	if (pOwner == nil) then
		return 1
	end
	
	local groupSize = CreatureObject(pOwner):getGroupSize()

	for i = 0, groupSize - 1, 1 do
		local pMember = CreatureObject(pOwner):getGroupMember(i)
		if (pMember ~= nil CreatureObject(pOwner):isInRangeWithObject(pMember, 50)) then
			if (QuestManager.hasActiveQuest(pMember, QuestManager.quests.WOD_NS_KYRISA_BOSS_FIGHT_03)) then
				QuestManager.completeQuest(pMember, QuestManager.quests.WOD_NS_KYRISA_BOSS_FIGHT_03)
				QuestManager.completeQuest(pMember, QuestManager.quests.WOD_NS_KYRISA_BOSS_FIGHT)
				witchesOfDathomirScreenplay:handleReward(pMember, "greaterGood")
			elseif (QuestManager.hasActiveQuest(pMember, QuestManager.quests.WOD_SM_KYRISA_BOSS_FIGHT_03)) then
				QuestManager.completeQuest(pMember, QuestManager.quests.WOD_SM_KYRISA_BOSS_FIGHT_03)
				QuestManager.completeQuest(pMember, QuestManager.quests.WOD_SM_KYRISA_BOSS_FIGHT)
				witchesOfDathomirScreenplay:handleReward(pMember, "greaterGood")
			end
		end
	end
	
	deleteData("wodThemepark:rancorBossState")
	return 1
end

function wodWholeTruthArc:sendMessageToGroup(pBoss)
	if (pBoss == nil) then
		return
	end
	
	local pOwner = getSceneObject(readData("wodThemepark:rancorBossFightOwnerID"))
	
	if (pOwner == nil) then
		return
	end
	
	local bossState = readData("wodThemepark:rancorBossState")
	
	if (bossState == nil or bossState == "") then
		return
	end
	
	if (bossState == 1) then
		writeData("wodThemepark:rancorBossState", 2)
		createEvent(9 * 60 * 1000, "wodWholeTruthArc", "sendMessageToGroup", nil, "")
		CreatureObject(pPlayer):sendGroupMessage("@theme_park_wod/wod:boss_rancor_start")
		CreatureObject(pPlayer):sendGroupMessage("@theme_park_wod/wod:boss_begin")
	elseif (bossState == 2) then
		writeData("wodThemepark:rancorBossState", 3)
		CreatureObject(pPlayer):sendGroupMessage("@theme_park_wod/wod:boss_time_warning")
	elseif (bossState == 3) then
		writeData("wodThemepark:rancorBossState", 4)
		CreatureObject(pPlayer):sendGroupMessage("@theme_park_wod/wod:mutating_rancor")
	elseif (bossState == 4) then
		writeData("wodThemepark:rancorBossState", 5)
		CreatureObject(pPlayer):sendGroupMessage("@theme_park_wod/wod:boss_leaving")
	elseif (bossState == 5) then
		CreatureObject(pPlayer):sendGroupMessage("@theme_park_wod/wod:boss_failed")
	end
end

function wodWholeTruthArc:failBossFight(pBoss)
	if (pBoss == nil) then
		return
	end
	
	self:sendMessageToGroup(pBoss)
	CreatureObject(pBoss):setPvpStatusBitmask(0)
	forcePeace(pBoss)
	--Do move, then despawn
	createEvent(5 * 1000, "wodWholeTruthArc", "despawnBoss", pBoss, "")
end

function wodWholeTruthArc:despawnBoss(pBoss)
	if (pBoss == nil) then
		return
	end
	
	self:sendMessageToGroup(pBoss)
	self:spawnCagedRancor()

	if (SceneObject(pBoss):isAiAgent()) then
		CreatureObject(pBoss):setPvpStatusBitmask(0)
		forcePeace(pBoss)
	end
	SceneObject(pBoss):destroyObjectFromWorld()
end

--Eliminate quest
function wodWholeTruthArc:startEliminateQuest(pPlayer)
	
	dropObserver(KILLEDCREATURE, "wodWholeTruthArc", "notifyKilledHuntTarget", pPlayer)
	deleteScreenPlayData(pPlayer, "wodThemepark:wholeTruthArc:killQuest", "huntTarget")
	deleteScreenPlayData(pPlayer, "wodThemepark:wholeTruthArc:killQuest", "huntTargetCount")
	deleteScreenPlayData(pPlayer, "wodThemepark:wholeTruthArc:killQuest", "huntTargetGoal")
	
	writeScreenPlayData(pPlayer, "wodThemepark:wholeTruthArc:killQuest", "huntTargetCount", 0)
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_02) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_WHOLE_TRUTH_02)) then
		writeScreenPlayData(pPlayer, "wodThemepark:wholeTruthArc:killQuest", "huntTargetGoal", 3) -- TODO: Magic number
		writeScreenPlayData(pPlayer, "wodThemepark:wholeTruthArc:killQuest", "huntTarget", "mutant_rancor") --TODO: Magic string
	end
	
	createObserver(KILLEDCREATURE, "wodWholeTruthArc", "notifyKilledHuntTarget", pPlayer)
end

function wodWholeTruthArc:notifyKilledHuntTarget(pPlayer, pVictim)
	if (pVictim == nil or pPlayer == nil) then
		return 0
	end
	
	if (not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_02) or not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_WHOLE_TRUTH_02)) then
		return 0
	end

	local huntTarget = readScreenPlayData(pPlayer, "wodThemepark:wholeTruthArc:killQuest", "huntTarget")
	local targetCount = tonumber(readScreenPlayData(pPlayer, "wodThemepark:wholeTruthArc:killQuest", "huntTargetCount"))
	local targetGoal = tonumber(readScreenPlayData(pPlayer, "wodThemepark:wholeTruthArc:killQuest", "huntTargetGoal"))

	if (targetCount == nil) then
		printLuaError("wodWholeTruthArc:notifyKilledHuntTarget, nil targetCount for player: " .. SceneObject(pPlayer):getCustomObjectName() .. " (player killed target: " .. SceneObject(pVictim):getObjectName() .. "). Setting to 0.")
		writeScreenPlayData(pPlayer, "wodThemepark:wholeTruthArc:killQuest", "huntTargetCount", 0)
		targetCount = 0
	end

	if (targetGoal == nil) then
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_02) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_02)) then
			printLuaError("wodWholeTruthArc:notifyKilledHuntTarget, nil targetGoal for player: " .. SceneObject(pPlayer):getCustomObjectName() .. " (player killed target: " .. SceneObject(pVictim):getObjectName() .. "). Setting to 3.") -- TODO: Magic numbe
			writeScreenPlayData(pPlayer, "wodThemepark:wholeTruthArc:killQuest", "huntTargetGoal", 3) -- TODO: Magic number
			targetGoal = 3 -- TODO: Magic number
		end
	end

	if (huntTarget == nil or huntTarget == "") then
		local newTarget = ""
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_02) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_02)) then
			newTarget = "mutant_rancor" --TODO: Magic string
			printLuaError("wodWholeTruthArc:notifyKilledHuntTarget, nil huntTarget for player: " .. SceneObject(pPlayer):getCustomObjectName() .. " (player killed target: " .. SceneObject(pVictim):getObjectName() .. "). Setting to " .. newTarget .. ".")
			writeScreenPlayData(pPlayer, "wodThemepark:wholeTruthArc:killQuest", "huntTarget", "mutant_rancor") --TODO: Magic string
		end
		huntTarget = newTarget
	end

	if (SceneObject(pVictim):getZoneName() ~= SceneObject(pPlayer):getZoneName() or not CreatureObject(pPlayer):isInRangeWithObject(pVictim, 80)) then
		return 0
	end

	local targetList = HelperFuncs:splitString(huntTarget, ";")

	if (huntTarget == SceneObject(pVictim):getObjectName() or HelperFuncs:tableContainsValue(targetList, SceneObject(pVictim):getObjectName())) then
		targetCount = targetCount + 1
		
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_02) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_WHOLE_TRUTH_02)) then
			if (getRandomNumber(1, 100) <= 65) then --TODO: Magic number
				return 0
			end
		end

		writeScreenPlayData(pPlayer, "wodThemepark:wholeTruthArc:killQuest", "huntTargetCount", targetCount)

		local remaining = targetGoal - targetCount

		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_02) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_WHOLE_TRUTH_02)) then
			if (remaining == 0) then
				CreatureObject(pPlayer):sendSystemMessage("You have collected a mutant rancor blood sample, " .. remaining .. " remaining.")
			else
				CreatureObject(pPlayer):sendSystemMessage("You have collected enough mutated rancor blood samples.")
			end
		end

		if (targetCount >= targetGoal) then
			if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_02)) then
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_02)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_03)
				wodNSWholeTruth03Goto:start(pPlayer)
			elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_WHOLE_TRUTH_02)) then
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_WHOLE_TRUTH_02)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_WHOLE_TRUTH_03)
				wodSMWholeTruth03Goto:start(pPlayer)
			end
			return 1
		end
	end
	return 0
end