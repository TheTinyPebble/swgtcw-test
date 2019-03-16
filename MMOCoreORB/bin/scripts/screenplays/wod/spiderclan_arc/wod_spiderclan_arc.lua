wodSpiderclanArc = ScreenPlay:new {

}

registerScreenPlay("wodSpiderclanArc", false)

local QuestManager = require("managers.quest.quest_manager")

--Eliminate quest
function wodSpiderclanArc:startEliminateQuest(pPlayer)
	
	dropObserver(KILLEDCREATURE, "wodSpiderclanArc", "notifyKilledHuntTarget", pPlayer)
	deleteScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTarget")
	deleteScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTargetCount")
	deleteScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTargetGoal")
	
	writeScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTargetCount", 0)
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_01) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E02_01)) then
		writeScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTargetGoal", 1) -- TODO: Magic number
		writeScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTarget", "wod_spider_nightsister_obfuscatrix") --TODO: Magic string
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_03) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E02_03)) then
		writeScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTargetGoal", 5) -- TODO: Magic number
		writeScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTarget", "wod_spider_nightsister_initiate") --TODO: Magic string
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_EHS_02) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_EHS_02)) then
		writeScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTargetGoal", 6) -- TODO: Magic number
		writeScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTarget", "wod_spider_nightsister_obfuscatrix") --TODO: Magic string
	end
	
	createObserver(KILLEDCREATURE, "wodSpiderclanArc", "notifyKilledHuntTarget", pPlayer)
end

function wodSpiderclanArc:notifyKilledHuntTarget(pPlayer, pVictim)
	if (pVictim == nil or pPlayer == nil) then
		return 0
	end
	
	if (not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_03) or not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E02_03) or not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_EHS_02) or not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_EHS_02)) then
		return 0
	end

	local huntTarget = readScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTarget")
	local targetCount = tonumber(readScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTargetCount"))
	local targetGoal = tonumber(readScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTargetGoal"))

	if (targetCount == nil) then
		printLuaError("wodSpiderclanArc:notifyKilledHuntTarget, nil targetCount for player: " .. SceneObject(pPlayer):getCustomObjectName() .. " (player killed target: " .. SceneObject(pVictim):getObjectName() .. "). Setting to 0.")
		writeScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTargetCount", 0)
		targetCount = 0
	end

	if (targetGoal == nil) then
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_03) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E02_03)) then
			printLuaError("wodSpiderclanArc:notifyKilledHuntTarget, nil targetGoal for player: " .. SceneObject(pPlayer):getCustomObjectName() .. " (player killed target: " .. SceneObject(pVictim):getObjectName() .. "). Setting to 5.") -- TODO: Magic numbe
			writeScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTargetGoal", 5) -- TODO: Magic number
			targetGoal = 5 -- TODO: Magic number
		elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_EHS_02) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_EHS_02)) then
			printLuaError("wodSpiderclanArc:notifyKilledHuntTarget, nil targetGoal for player: " .. SceneObject(pPlayer):getCustomObjectName() .. " (player killed target: " .. SceneObject(pVictim):getObjectName() .. "). Setting to 6.") -- TODO: Magic numbe
			writeScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTargetGoal", 6) -- TODO: Magic number
			targetGoal = 6 -- TODO: Magic number
		end
	end

	if (huntTarget == nil or huntTarget == "") then
		local newTarget = ""
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_03) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E02_03)) then
			newTarget = "wod_spider_nightsister_initiate" --TODO: Magic string
			printLuaError("wodSpiderclanArc:notifyKilledHuntTarget, nil huntTarget for player: " .. SceneObject(pPlayer):getCustomObjectName() .. " (player killed target: " .. SceneObject(pVictim):getObjectName() .. "). Setting to " .. newTarget .. ".")
			writeScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTarget", "wod_spider_nightsister_initiate") --TODO: Magic string
		elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_EHS_02) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_EHS_02)) then
			newTarget = "wod_spider_nightsister_obfuscatrix" --TODO: Magic string
			printLuaError("wodSpiderclanArc:notifyKilledHuntTarget, nil huntTarget for player: " .. SceneObject(pPlayer):getCustomObjectName() .. " (player killed target: " .. SceneObject(pVictim):getObjectName() .. "). Setting to " .. newTarget .. ".")
			writeScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTarget", "wod_spider_nightsister_obfuscatrix") --TODO: Magic string
		end
		huntTarget = newTarget
	end

	if (SceneObject(pVictim):getZoneName() ~= SceneObject(pPlayer):getZoneName() or not CreatureObject(pPlayer):isInRangeWithObject(pVictim, 80)) then
		return 0
	end

	local targetList = HelperFuncs:splitString(huntTarget, ";")

	if (huntTarget == SceneObject(pVictim):getObjectName() or HelperFuncs:tableContainsValue(targetList, SceneObject(pVictim):getObjectName())) then
		targetCount = targetCount + 1
		
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_01) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E02_01)) then
			if (getRandomNumber(1, 5) ~= 1) then
				return 0
			end
		end

		writeScreenPlayData(pPlayer, "wodThemepark:killQuest", "huntTargetCount", targetCount)

		local remaining = targetGoal - targetCount

		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_03) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E02_03)) then
			if (remaining == 0) then
				if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_03)) then
					CreatureObject(pPlayer):sendSystemMessage("Your disturbance has allowed the initiate to escape, return to Leandra.")
				else
					CreatureObject(pPlayer):sendSystemMessage("Your disturbance has allowed the initiate to escape, return to Azzenaj.")
				end
			else
				CreatureObject(pPlayer):sendSystemMessage("You have killed an acolyte.")
			end
		elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_EHS_02) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_EHS_02)) then
			CreatureObject(pPlayer):sendSystemMessage("You have killed a Spiderclan Obfuscatrix.")
		end

		if (targetCount >= targetGoal) then
			if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_01)) then
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_01)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_02)
				self:sendCommMessage(pPlayer)
			elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E02_01)) then
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E02_01)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E02_02)
				self:sendCommMessage(pPlayer)
			else(QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_03)) then
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_03)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_04)
				wodNSLostE0204Goto:start(pPlayer)
			elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E02_03)) then
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E02_03)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E02_04)
				wodSMLostE0204Goto:start(pPlayer)
			elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_EHS_02)) then
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_EHS_02)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_EHS_03)
				self:sendCommMessage(pPlayer)
			elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_EHS_02)) then
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_EHS_02)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_EHS_03)
				self:sendCommMessage(pPlayer)
			end
			return 1
		end
	end
	return 0
end

function wodSpiderclanArc:sendCommMessage(pPlayer)
	if (pPlayer == nil) then
		return
	end

	local sui = SuiMessageBox.new("wodSpiderclanArc", "noCallback")
	sui.hideCancelButton()

	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_01)) then
		sui.setTitle("@theme_park_wod/wod_ns_lost_e02:comm_message_title")
		sui.setPrompt("@theme_park_wod/wod_ns_lost_e02:task01_comm_message_text")
		sui.sendTo(pPlayer)
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_LOST_E02_01)) then
		sui.setTitle("@theme_park_wod/wod_sm_lost_e02:comm_message_title")
		sui.setPrompt("@theme_park_wod/wod_sm_lost_e02:task01_comm_message_text")
		sui.sendTo(pPlayer)
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_EHS_02)) then
		sui.setTitle("@theme_park_wod/wod_ns_ehs:comm_message_title")
		sui.setPrompt("@theme_park_wod/wod_ns_ehs:task02_comm_message_text")
		sui.sendTo(pPlayer)
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_EHS_02)) then
		sui.setTitle("@theme_park_wod/wod_sm_ehs:comm_message_title")
		sui.setPrompt("@theme_park_wod/wod_sm_ehs:task02_comm_message_text")
		sui.sendTo(pPlayer)
	end
end

function wodSpiderclanArc:noCallback(pPlayer, pSui, eventIndex, ...)
end