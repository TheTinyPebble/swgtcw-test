wod_rubina_convo_handler = Object:new {}

local QuestManager = require("managers.quest.quest_manager")

--TODO: Handle left behind reward

function wod_rubina_convo_handler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local favor = wodPrologueScreenplay:getFavorStatus(pPlayer)
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_MEET_MYSTERIOUS_WITCH)) then
		return convoTemplate("initial")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_RUBINA_CHEST)) then
		return convoTemplate("cache_init")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_LEFT_BEHIND_03)) then
		return convoTemplate("left_behind_return")
	end
	
	if (favor.count == 8) then
		if (favor.clan == "ns" and not (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_RUBINA_GOTO_NS) or QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_RUBINA_GOTO_NS))) then
			return convoTemplate("ns_ready")
		elseif (favor.clan == "sm" and not (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_RUBINA_GOTO_SM) or QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_RUBINA_GOTO_SM))) then
			return convoTemplate("sm_ready")
		end
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_08)) then
		return convoTemplate("return_herbs_sm")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_09)) then
		return convoTemplate("return_herbs_ns")
	end

	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_05) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_05)) then
		return convoTemplate("return_eliminate_sm")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_06) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_06)) then
		return convoTemplate("return_eliminate_ns")
	end
	
	for i = 1, 7 do
		if (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_prologue_outcast_0" .. i))) then
			if (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_prologue_outcast_0" .. i .. "_02"))) then
				return convoTemplate("return_wisdom_ns")
			elseif (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_prologue_outcast_0" .. i .. "_03"))) then
				return convoTemplate("return_wisdom_sm")
			end
		end
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_RUBINA_CHEST)) then
		return convoTemplate("cache_init")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_RUBINA_LEFT_BEHIND_03)) then
		return convoTemplate("left_behind_return")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_RUBINA_LEFT_BEHIND)) then
		return convoTemplate("quest_in_progress")
	end
	
	return convoTemplate("second_init")
end

function wod_rubina_convo_handler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
    local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)
	
	if (screenID == "task_herbs_start") then
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING)) then
			return convoTemplate("quest_in_progress")
		end
		wodPrologueScreenplay:resetQuest(pPlayer, "herbs")
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_01)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_02)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_03)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_04)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_05)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_06)
	end
	
	if (screenID == "return_herbs_complete_ns") then
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING)
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_08)
		wodPrologueScreenplay:addToCollection(pPlayer, "herbsNS")
		wodPrologueScreenplay:addToFavor(pPlayer, "ns")
		wodPrologueScreenplay:handleReward(pPlayer, "herbs")
	elseif (screenID == "return_herbs_complete_sm") then
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING)
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_09)
		wodPrologueScreenplay:addToCollection(pPlayer, "herbsSM")
		wodPrologueScreenplay:addToFavor(pPlayer, "sm")
		wodPrologueScreenplay:handleReward(pPlayer, "herbs")
	end
	
	if (screenID == "task_enemies_start") then
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN)) then
			return convoTemplate("quest_in_progress")
		end
		local n = getRandomNumber(1, 2)
		wodPrologueScreenplay:resetQuest(pPlayer, "enemies")
		if (n == 1) then
			wodProKillRancorGoto:start(pPlayer)
		else
			wodProKillSpiderclanGoto:start(pPlayer)
		end
	end
	
	if (screenID == "return_eliminate_complete_ns") then
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_05)) then
			wodPrologueScreenplay:addToCollection(pPlayer, "rancor")
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR)
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_05)
		elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_05)) then
			wodPrologueScreenplay:addToCollection(pPlayer, "spiderclan")
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN)
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_05)
		end
		wodPrologueScreenplay:addToFavor(pPlayer, "sm")
		wodPrologueScreenplay:handleReward(pPlayer, "eliminate")
	elseif (screenID == "return_eliminate_complete_sm") then
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_06)) then
			wodPrologueScreenplay:addToCollection(pPlayer, "rancor")
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR)
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_06)
		elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_06)) then
			wodPrologueScreenplay:addToCollection(pPlayer, "spiderclan")
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN)
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_06)
		end
		wodPrologueScreenplay:addToFavor(pPlayer, "ns")
		wodPrologueScreenplay:handleReward(pPlayer, "eliminate")
	end
	
	if (screenID == "task_wisdom_start") then
		for i = 1, 7 do
			if (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_prologue_outcast_0" .. i))) then
				return convoTemplate("quest_in_progress")
			end
		end
		wodPrologueScreenplay:resetQuest(pPlayer, "wisdom")
		local n = getRandomNumber(1, 7)
		if (n == 1) then
			wodOutcast1GoTo:start(pPlayer)
		elseif (n == 2) then
			wodOutcast2GoTo:start(pPlayer)
		elseif (n == 3) then
			wodOutcast3GoTo:start(pPlayer)
		elseif (n == 4) then
			wodOutcast4GoTo:start(pPlayer)
		elseif (n == 5) then
			wodOutcast5GoTo:start(pPlayer)
		elseif (n == 6) then
			wodOutcast6GoTo:start(pPlayer)
		else
			wodOutcast7GoTo:start(pPlayer)
		end
	end
	
	if (screenID == "return_wisdom_ns") then
		deleteScreenPlayData(pPlayer, "wodThemepark:prologue", "outcastSM")
		deleteScreenPlayData(pPlayer, "wodThemepark:prologue", "outcastNS")
		wodPrologueScreenplay:addToCollection(pPlayer, "wisdomNS")
		wodPrologueScreenplay:addToFavor(pPlayer, "ns")
		wodPrologueScreenplay:handleReward(pPlayer, "wisdom")
	elseif (screenID == "return_wisdom_sm") then
		deleteScreenPlayData(pPlayer, "wodThemepark:prologue", "outcastSM")
		deleteScreenPlayData(pPlayer, "wodThemepark:prologue", "outcastNS")
		wodPrologueScreenplay:addToCollection(pPlayer, "wisdomSM")
		wodPrologueScreenplay:addToFavor(pPlayer, "sm")
		wodPrologueScreenplay:handleReward(pPlayer, "wisdom")
	end
	
	if (screnID == "favor") then
		local favor = wodPrologueScreenplay:getFavorStatus(pPlayer)
		if (favor.count == 0) then
			clonedScreen:setDialogTextStringId("@conversation/wod_rubina:s_196")
		elseif (favor.count == 1) then
			clonedScreen:setDialogTextStringId("@conversation/wod_rubina:s_204")
		elseif (favor.count == 2) then
			if (favor.clan == "ns") then
				clonedScreen:setDialogTextStringId("@conversation/wod_rubina:s_164")
			elseif (favor.clan == "sm") then
				clonedScreen:setDialogTextStringId("@conversation/wod_rubina:s_198")
			end
		elseif (favor.count == 5) then
			if (favor.clan == "ns") then
				clonedScreen:setDialogTextStringId("@conversation/wod_rubina:s_158")
			elseif (favor.clan == "sm") then
				clonedScreen:setDialogTextStringId("@conversation/wod_rubina:s_200")
			end
		elseif (favor.count == 8) then
			if (favor.clan == "ns") then
				clonedScreen:setDialogTextStringId("@conversation/wod_rubina:s_156")
			elseif (favor.clan == "sm") then
				clonedScreen:setDialogTextStringId("@conversation/wod_rubina:s_202")
			end
		end
	end
	
	if (screenID == "left_behind_start") then
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_RUBINA_CHEST)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_LEFT_BEHIND)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_LEFT_BEHIND_01)
	end
	
	if (screenID == "left_behind_complete_quest") then
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_LEFT_BEHIND_03)
		--Handle reward
	end
	
    return pConvScreen
end