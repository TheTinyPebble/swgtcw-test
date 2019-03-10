wodPrologueScreenplay = ScreenPlay:new {

}

registerScreenPlay("wodPrologueScreenplay", true)

local QuestManager = require("managers.quest.quest_manager")

--TODO: Mobiles
--TODO: Spawn mobiles
--TODO: On logged in events
--TODO: Reward handling

function wodPrologueScreenplay:start()
	if (isZoneEnabled("dathomir")) then
		self:spawnMobiles()
	end
end

function wodPrologueScreenplay:onPlayerLoggedIn(pPlayer)
	if (pPlayer == nil) then
		return
	end

	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_01) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_01)) then
		dropObserver(KILLEDCREATURE, "wodPrologueScreenplay", "notifyKilledHuntTarget", pPlayer)
		createObserver(KILLEDCREATURE, "wodPrologueScreenplay", "notifyKilledHuntTarget", pPlayer)
	end
end

function wodPrologueScreenplay:spawnMobiles()

end

--Reward handling
function wodPrologueScreenplay:addToCollection(pPlayer, key)
	if (pPlayer == nil) then
		return
	end
	
	local curCount = tonumber(readScreenPlayData(pPlayer, "wodThemepark:prologue:collection", key))
	
	if (curCount == nil or curCount == "") then
		curCount = 0
	end
	
	writeScreenPlayData(pPlayer, "wodThemepark:prologue:collection", key, curCount + 1)
	
	if (curCount + 1 % 5 == 0) then --TODO: Magic number
		self:handleCollectionReward(pPlayer, key)
	end
end

function wodPrologueScreenplay:handleCollectionReward(pPlayer, key)

end

function wodPrologueScreenplay:handleReward(pPlayer, key)

end

--Reset quests for repeatables
function wodPrologueScreenplay:resetQuest(pPlayer, key)
	if (pPlayer == nil) then
		return
	end
	
	if (key == "herbs") then
		if (QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING)) then
			QuestManager.resetQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING)
			for i = 1, 9 do
				QuestManager.resetQuest(pPlayer, getPlayerQuestID("wod_prologue_herb_gathering_0" .. i))
			end
		end
	end
	
	if (key == "eliminate") then
		if (QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR)) then
			QuestManager.resetQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR)
			for i = 1, 6 do
				QuestManager.resetQuest(pPlayer, getPlayerQuestID("wod_prologue_kill_rancor_0" .. i))
			end
		end
		if(QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN)) then
			QuestManager.resetQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN)
			for i = 1, 6 do
				QuestManager.resetQuest(pPlayer, getPlayerQuestID("wod_prologue_kill_spider_clan_0" .. i))
			end
		end
	end
	
	if (key == "wisdom") then
		for i = 1, 7 do
			if (QuestManager.hasCompletedQuest(pPlayer, getPlayerQuestID("wod_prologue_outcast_0" .. i))) then
				QuestManager.resetQuest(pPlayer, getPlayerQuestID("wod_prologue_outcast_0" .. i))
				for j = 1, 3 do
					QuestManager.resetQuest(pPlayer, getPlayerQuestID("wod_prologue_outcast_0" .. i .. "_0" .. j))
				end
			end
		end
	end
end

--Eliminate quest
function wodPrologueScreenplay:startEliminateQuest(pPlayer)
	if (not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_01) and not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_01)) then
		return
	end
	
	dropObserver(KILLEDCREATURE, "wodPrologueScreenplay", "notifyKilledHuntTarget", pPlayer)
	deleteScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTarget")
	deleteScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTargetCount")
	deleteScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTargetGoal")
	
	writeScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTargetCount", 0)
	writeScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTargetGoal", 5) -- TODO: Magic number
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_01)) then
		writeScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTarget", "mutant_rancor") --TODO: Magic string
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN)) then
		writeScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTarget", "spiderclan_acolyte;spiderclan_auspex;spiderclan_crawler;spiderclan_elder;spiderclan_protector;spiderclan_sentinel;spiderclan_sentry;spiderclan_stalker;spiderclan_web_dancer") --TODO: Magic string
	end
	
	createObserver(KILLEDCREATURE, "wodPrologueScreenplay", "notifyKilledHuntTarget", pPlayer)
end

function wodPrologueScreenplay:notifyKilledHuntTarget(pPlayer, pVictim)
	if (pVictim == nil or pPlayer == nil) then
		return 0
	end
	
	if (not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_01) and not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_01)) then
		return 0
	end

	local huntTarget = readScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTarget")
	local targetCount = tonumber(readScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTargetCount"))
	local targetGoal = tonumber(readScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTargetGoal"))

	if (targetCount == nil) then
		printLuaError("wodPrologueScreenplay:notifyKilledHuntTarget, nil targetCount for player: " .. SceneObject(pPlayer):getCustomObjectName() .. " (player killed target: " .. SceneObject(pVictim):getObjectName() .. "). Setting to 0.")
		writeScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTargetCount", 0)
		targetCount = 0
	end

	if (targetGoal == nil) then
		printLuaError("wodPrologueScreenplay:notifyKilledHuntTarget, nil targetGoal for player: " .. SceneObject(pPlayer):getCustomObjectName() .. " (player killed target: " .. SceneObject(pVictim):getObjectName() .. "). Setting to 5.") -- TODO: Magic numbe
		writeScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTargetGoal", 5) -- TODO: Magic number
		targetGoal = 5 -- TODO: Magic number
	end

	if (huntTarget == nil or huntTarget == "") then
		local newTarget = ""
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_01)) then
			writeScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTarget", "mutant_rancor") --TODO: Magic string
			newTarget = "mutant_rancor" --TODO: Magic string
		elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN)) then
			writeScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTarget", "spiderclan_acolyte;spiderclan_auspex;spiderclan_crawler;spiderclan_elder;spiderclan_protector;spiderclan_sentinel;spiderclan_sentry;spiderclan_stalker;spiderclan_web_dancer") --TODO: Magic string
			newTarget = "spiderclan_acolyte;spiderclan_auspex;spiderclan_crawler;spiderclan_elder;spiderclan_protector;spiderclan_sentinel;spiderclan_sentry;spiderclan_stalker;spiderclan_web_dancer" --TODO: Magic string
		end
		printLuaError("KnightTrials:notifyKilledHuntTarget, nil huntTarget for player: " .. SceneObject(pPlayer):getCustomObjectName() .. " (player killed target: " .. SceneObject(pVictim):getObjectName() .. "). Setting to " .. newTarget .. ".")
		huntTarget = newTarget
	end

	if (SceneObject(pVictim):getZoneName() ~= SceneObject(pPlayer):getZoneName() or not CreatureObject(pPlayer):isInRangeWithObject(pVictim, 80)) then
		return 0
	end

	local targetList = HelperFuncs:splitString(huntTarget, ";")

	if (huntTarget == SceneObject(pVictim):getObjectName() or HelperFuncs:tableContainsValue(targetList, SceneObject(pVictim):getObjectName())) then
		local n = getRandomNumber(1, 4) --TODO: Magic number
		if (n == 1) then
			return 0
		end
		
		targetCount = targetCount + 1
		writeScreenPlayData(pPlayer, "wodThemepark:prologue", "huntTargetCount", targetCount)
		
		local remaining = targetGoal - targetCount
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR)) then
			if (remaining == 0) then
				CreatureObject(pPlayer):sendSystemMessage("You have collected a mutant rancor tooth, return to Rubina.")
			else
				CreatureObject(pPlayer):sendSystemMessage("You have collected a mutant rancor tooth, " .. remaining .. " remaining.")
			end
		elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN)) then
			if (remaining == 0) then
				CreatureObject(pPlayer):sendSystemMessage("You have collected a Spider Clan emblem, return to Rubina.")
			else
				CreatureObject(pPlayer):sendSystemMessage("You have collected a Spider Clan emblem, " .. remaining .. " remaining.")
			end
		end

		if (targetCount >= targetGoal) then
			if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR)) then
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_01)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_02)
			elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN)) then
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_01)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_02)
			end
			wodRubinaReturn:start(pPlayer)
			return 1
		end
	end

	return 0
end

--Rubina favor
function wodPrologueScreenplay:addToFavor(pPlayer, key)
	if (pPlayer == nil) then
		return
	end
	
	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	if (pGhost == nil) then
		return
	end
	
	curNSFavor = tonumber(readScreenPlayData(pPlayer, "wodThemepark:prologue:favor", "nsFavor"))
		
	if (curNSFavor == nil or curNSFavor == "") then
		curNSFavor = 0
	end
	
	curSMFavor = tonumber(readScreenPlayData(pPlayer, "wodThemepark:prologue:favor", "smFavor"))
		
	if (curSMFavor == nil or curSMFavor == "") then
		curSMFavor = 0
	end
	
	if (key == "ns") then
		if (curNSFavor < 8) then
			writeScreenPlayData(pPlayer, "wodThemepark:prologue:favor", "nsFavor", curNSFavor + 1)
		end
		
		if (curSMFavor > 0) then
			writeScreenPlayData(pPlayer, "wodThemepark:prologue:favor", "smFavor", curSMFavor - 1)
		end
		
		PlayerObject(pGhost):increaseFactionStanding("nightsister", 500) -- TODO: Magic number, add enable/disable faction gain/loss
		PlayerObject(pGhost):decreaseFactionStanding("mtn_clan", 500)
	elseif (key == "sm") then
		if (curSMFavor < 8) then
			writeScreenPlayData(pPlayer, "wodThemepark:prologue:favor", "smFavor", curSMFavor + 1)
		end
		
		if (curNSFavor > 0) then
			writeScreenPlayData(pPlayer, "wodThemepark:prologue:favor", "nsFavor", curNSFavor - 1)
		end
		
		PlayerObject(pGhost):increaseFactionStanding("mtn_clan", 500)
		PlayerObject(pGhost):decreaseFactionStanding("nightsister", 500)
	end
	
	local curCount = tonumber(readScreenPlayData(pPlayer, "wodThemepark:prologue:collection", key))
	
	if (curCount == nil or curCount == "") then
		curCount = 0
	end
	
	writeScreenPlayData(pPlayer, "wodThemepark:prologue:collection", key, curCount + 1)
	
	if (curCount + 1 % 5 == 0) then --TODO: Magic number
		self:handleCollectionReward(pPlayer, key)
	end
end

function wodPrologueScreenplay:getFavorStatus(pPlayer)
	if (pPlayer == nil) then
		return
	end
	
	curNSFavor = tonumber(readScreenPlayData(pPlayer, "wodThemepark:prologue:favor", "nsFavor"))
		
	if (curNSFavor == nil or curNSFavor == "") then
		curNSFavor = 0
	end
	
	curSMFavor = tonumber(readScreenPlayData(pPlayer, "wodThemepark:prologue:favor", "smFavor"))
		
	if (curSMFavor == nil or curSMFavor == "") then
		curSMFavor = 0
	end
	
	if (curNSFavor == curSMFavor) then
		return {count = 0, clan = "ns"}
	end
	
	if (curNSFavor > curSMFavor) then
		return {count = curNSFavor - curSMFavor, clan = "ns"}
	end
	
	if (curSMFavor > curNSFavor) then
		return {count = curSMFavor - curNSFavor, clan = "sm"}
	end
end