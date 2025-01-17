wod_ns_guide_convo_handler = conv_handler:new{}

local QuestManager = require("managers.quest.quest_manager")

function wod_ns_guide_convo_handler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	if (pGhost == nil) then
		return convoTemplate:getScreen("not_enough_faction")
	end
	
	local factionStanding = PlayerObject(pGhost):getFactionStanding("nightsister")
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_RUBINA_GOTO_SM) or QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_RUBINA_GOTO_SM)) then
		return convoTemplate:getScreen("wrong_alignment")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_RUBINA_GOTO_NS) or QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_RUBINA_GOTO_NS)) then
		if (factionStanding > 3000) then
			return convoTemplate:getScreen("initial")
		else
			return convoTemplate:getScreen("not_enough_faction")
		end
	end
	
	return convoTemplate:getScreen("not_elligible")
end

function wod_ns_guide_convo_handler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)
	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	if (pGhost == nil) then
		return pConvScreen
	end

	if (screenID == "initial") then
		if (not PlayerObject(pGhost):hasBadge(161)) then
			PlayerObject(pGhost):awardBadge(161)
		end
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_RUBINA_GOTO_NS)
	end

	if (screenID == "continue" or screenID == "end_conv") then
		if (readScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment") == "sm") then
			witchesOfDathomirScreenplay:handleClanSwap(pPlayer, "sm")
		end
		deleteScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment")
		writeScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment", "ns")
	end
	
    return pConvScreen
end
