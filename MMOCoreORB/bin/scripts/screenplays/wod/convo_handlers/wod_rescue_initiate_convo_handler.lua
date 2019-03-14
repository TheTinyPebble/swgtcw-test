wod_rescue_initiate_convo_handler = Object:new {}

local QuestManager = require("managers.quest.quest_manager")

-- TODO: Reward Handling
-- TODO: Busy check
-- TODO: Group check

function wod_rescue_initiate_convo_handler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local clan = readScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment")

	if (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_lost_e02_03"))) then
		return convoTemplate("initial_" .. clan)
	end
	
	return convoTemplate("not_elligible_" .. clan)
end

function wod_rescue_initiate_convo_handler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)

	if (screenID == "complete_quest_" .. clan) then
		QuestManager.completeQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_lost_e02_03"))
		QuestManager.activateQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_lost_e02_04"))
	end

    return pConvScreen
end