wod_ns_leandra_convo_handler = Object:new {}

local QuestManager = require("managers.quest.quest_manager")

-- TODO: Reward Handling

function wod_ns_leandra_convo_handler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local clan = readScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment")

	if (clan == "" or clan == nil) then
		return convoTemplate("not_elligible")
	elseif (clan == "sm") then
		return convoTemplate("wrong_alignment")
	end
	
	if (QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_NS_QUEEN_MOTHER_FIGHT)) then
		return convoTemplate("quest_complete")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_QUEEN_MOTHER_FIGHT)) then
		return convoTemplate("quest_challenge_in_progress")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_EHS) and not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_EHS_04)) then
		return convoTemplate("quest_hate_in_progress")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02) and not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_05)) then
		return convoTemplate("quest_investigation_in_progress")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E01) and not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E01_05)) then
		return convoTemplate("quest_lost_in_progress")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_EHS_04)) then
		return convoTemplate("quest_hate_return")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_05)) then
		return convoTemplate("quest_found_return")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E01_05)) then
		return convoTemplate("quest_lost_return")
	end
	
	return convoTemplate("initial")
end

function wod_ns_leandra_convo_handler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)

	if (screenID == "start_quest_lost") then
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E01)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E01_01)
	end
	
	if (screenID == "start_quest_found") then
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E01_05)
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E01)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_01)
	end
	
	if (screenID == "start_quest_hate") then
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E01_05)
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E01)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E02_01)
	end
	
	if (screenID == "start_quest_challenge") then
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E01_05)
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_LOST_E01)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_EHS)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_EHS_01)
	end

    return pConvScreen
end