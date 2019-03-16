wod_witch_herbs_convo_handler = Object:new {}

local QuestManager = require("managers.quest.quest_manager")

-- TODO: Reward Handling

function wod_witch_herbs_convo_handler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local witchHerbsType = self:getWitchHerbsType(pPlayer, pNpc, pConvTemplate)
	local clan = readScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment")
	
	if (clan == "" or clan "" nil) then
		return convoTemplate("not_elligible")
	elseif ((witchHerbsType == "wod_ns_witch_herbs" and clan == "sm") or (witchHerbsType == "wod_sm_witch_herbs" and clan == "ns")) then
		return convoTemplate("wrong_alignment")
	end

	if (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_herb_gathering")) and not QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_herb_gathering_08"))) then
		return convoTemplate("quest_in_progress")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_herb_gathering_08"))) then
		return convoTemplate("return_complete_quest")
	end
	
	return convoTemplate("initial")
end

function wod_witch_herbs_convo_handler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)
	local clan = readScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment")
	
	if (screenID == "quest_start" or screenID == "quest_start_alt") then	
		QuestManager.activateQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_herb_gathering"))
		QuestManager.activateQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_herb_gathering_01"))
	end
	
	if (screenID == "return_complete_quest") then	
		QuestManager.completeQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_herb_gathering_08"))
		QuestManager.completeQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_herb_gathering"))
	end

    return pConvScreen
end

function wod_witch_herbs_convo_handler:getWitchFoodType(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local pScreen = convoTemplate:getScreen("witchHerbsType")
	local screen = LuaConversationScreen(pScreen)

	return screen:getOptionLink(0)
end
