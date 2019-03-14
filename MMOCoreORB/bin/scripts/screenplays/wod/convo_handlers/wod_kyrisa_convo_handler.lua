wod_kyrisa_convo_handler = Object:new {}

local QuestManager = require("managers.quest.quest_manager")

-- TODO: Reward Handling
-- TODO: Busy check
-- TODO: Group check

function wod_kyrisa_convo_handler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local clan = readScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment")

	if (QuestManager.hasCompletedQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_kyrisa_boss_fight"))) then
		return convoTemplate("quest_complete")
	end
	
	if (QuestManager.hasCompletedQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_whole_truth"))) then
		return convoTemplate("greater_good_init")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_whole_truth_05"))) then
		return convoTemplate("initial")
	end
	
	return convoTemplate("not_elligible")
end

function wod_kyrisa_convo_handler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)
	local clan = readScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment")

	if (screenID == "complete_quest") then
		QuestManager.completeQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_whole_truth_05"))
		QuestManager.activateQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_whole_truth_06"))
	end

	if (screenID == "greater_good_start_quest") then
		QuestManager.activateQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_kyrisa_boss_fight"))
		QuestManager.activateQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_kyrisa_boss_fight_01"))
		--Busy check
		--Group check
	end

    return pConvScreen
end
