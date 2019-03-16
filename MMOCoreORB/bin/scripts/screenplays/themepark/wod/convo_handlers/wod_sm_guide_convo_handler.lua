wod_sm_guide_convo_handler = Object:new {}

local QuestManager = require("managers.quest.quest_manager")

function wod_sm_guide_convo_handler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	if (pGhost == nil) then
		return
	end
	
	local factionStanding = PlayerObject(pGhost):getFactionStanding("mtn_clan")
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_RUBINA_GOTO_NS) or QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_RUBINA_GOTO_NS)) then
		return convoTemplate("wrong_alignment")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_RUBINA_GOTO_SM) or QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_RUBINA_GOTO_SM)) then
		if (factionStanding > 3000) then
			return convoTemplate("initial")
		else
			return convoTemplate("not_enough_faction_end")
		end
	end
	
	return convoTemplate("not_elligible")
end

function wod_sm_guide_convo_handler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)

	if (screenID == "continue" or screenID == "end_conv") then
		deleteScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment")
		writeScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment", "sm")
	end
	
    return pConvScreen
end
