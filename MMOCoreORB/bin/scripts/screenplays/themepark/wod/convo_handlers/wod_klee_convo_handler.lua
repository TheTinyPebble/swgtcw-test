wod_klee_convo_handler = Object:new {
}
wod_klee_convo_handler = Object:new {}

local QuestManager = require("managers.quest.quest_manager")

-- TODO: Reward Handling

function wod_klee_convo_handler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local clan = readScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment")

	if (clan == "" or clan == nil) then
		return convoTemplate("not_elligible")
	elseif (clan == "sm") then
		return convoTemplate("wrong_alignment")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_KILL_SPIDERCLAN) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_KILL_CLAN) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_RECON)) then
		return convoTemplate("quest_in_progress")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_KILL_SPIDERCLAN_02)) then
		return convoTemplate("spiderclan_return")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_KILL_CLAN_02)) then
		return convoTemplate("other_clan_return")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_RECON_02)) then
		return convoTemplate("recon_return")
	end
	
	if (QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_SM_RECON) and (not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_RUBINA_CHEST) or QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_RUBINA_CHEST))) then
		return convoTemplate("init_recon_complete")
	end
	
	return convoTemplate("initial")
end

function wod_klee_convo_handler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)
	
	if (screenID == "initial" or screenID == "init_alt") then
		if (QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_SM_RECON)) then
			clonedConversation:addOption("@conversation/wod_klee:s_35", "other")
		end
	end

	if (screenID == "spiderclan_start") then
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_KILL_SPIDERCLAN)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_KILL_SPIDERCLAN_01)
	end
	
	if (screenID == "other_clan_start") then
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_KILL_CLAN)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_KILL_CLAN_01)
	end
	
	if (screenID == "two_clans_start") then
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_RECON)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_RECON_01)
	end
	
	if (screenID == "cache_start") then
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_RUBINA_CHEST)
	end

	if (screenID == "spiderclan_return") then
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_KILL_SPIDERCLAN_02)
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_KILL_SPIDERCLAN)
	end
	
	if (screenID == "other_clan_return") then
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_KILL_CLAN_02)
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_KILL_CLAN)
	end
	
	if (screenID == "recon_return") then
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_RECON_02)
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_RECON)
	end

    return pConvScreen
end