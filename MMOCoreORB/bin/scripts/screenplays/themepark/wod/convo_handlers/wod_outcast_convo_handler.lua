wod_outcast_convo_handler = Object:new {}

local QuestManager = require("managers.quest.quest_manager")

function wod_outcast_convo_handler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local outcast = self:getOutcast(pPlayer, pNpc, pConvTemplate)
	
	if (QuestManager.hasCompletedQuest(pPlayer, getPlayerQuestID(outcast .. "_01"))) then
		return convoTemplate("supported_clan")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID(outcast))) then
		return convoTemplate("initial")
	end
	
	return convoTemplate("not_elligible")
end

function wod_outcast_convo_handler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)
	local outcast = self:getOutcast(pPlayer, pNpc, pConvTemplate)

	if (screenID == "dilemma_one_sm") then
		self:addSMPoint(pPlayer)
		return convoTemplate("dilemma_two")
	elseif (screenID == "dilemma_one_sm") then
		self:addNSPoint(pPlayer)
		return convoTemplate("dilemma_two")
	end
	
	if (screenID == "dilemma_two_sm") then
		self:addSMPoint(pPlayer)
		return convoTemplate("dilemma_three")
	elseif (screenID == "dilemma_two_sm") then
		self:addNSPoint(pPlayer)
		return convoTemplate("dilemma_three")
	end
	
	if (screenID == "dilemma_three_sm") then
		self:addSMPoint(pPlayer)
		return convoTemplate("supported_clan")
	elseif (screenID == "dilemma_three_sm") then
		self:addNSPoint(pPlayer)
		return convoTemplate("supported_clan")
	end
	
	local supportedClan = self:getClanAlignment(pPlayer)
	if (screenID == "supported_clan_confirm") then
		if (supportedClan == "ns") then
			clonedScreen:setDialogTextStringId("@conversation/" .. outcast .. ":s_110")
			clonedScreen:addOption("@conversation/" .. outcast .. ":s_112", "end_screen")
		elseif (supportedClan == "sm") then
			clonedScreen:setDialogTextStringId("@conversation/" .. outcast .. ":s_104")
			clonedScreen:addOption("@conversation/" .. outcast .. ":s_106", "end_screen")
		end
	end
	
	if (screenID == "end_screen") then
		QuestManager.completeQuest(pPlayer, getPlayerQuestID(outcast .. "_01"))
		if (supportedClan == "ns") then
			QuestManager.activateQuest(pPlayer, getPlayerQuestID(outcast .. "_02"))
			clonedScreen:setDialogTextStringId("@conversation/" .. outcast .. ":s_114")
		elseif (supportedClan == "sm") then
			QuestManager.activateQuest(pPlayer, getPlayerQuestID(outcast .. "_03"))
			clonedScreen:setDialogTextStringId("@conversation/" .. outcast .. ":s_108")
		end
		wodRubinaReturnGoto:start(pPlayer)
	end
	
    return pConvScreen
end

function wod_outcast_convo_handler:getOutcast(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local pScreen = convoTemplate:getScreen("outcast")
	local screen = LuaConversationScreen(pScreen)

	return screen:getOptionLink(0)
end

function wod_outcast_convo_handler:addNSPoint(pPlayer)
	local curPoints = tonumber(readScreenPlayData(pPlayer, "wodThemepark:prologue", "outcastNS"))
	
	if (curPoints == nil) then
		curPoints = 0
	end
	
	writeScreenPlayData(pPlayer, "wodThemepark:prologue", "outcastNS", curPoints + 1)
end

function wod_outcast_convo_handler:addSMPoint(pPlayer)
	local curPoints = tonumber(readScreenPlayData(pPlayer, "wodThemepark:prologue", "outcastSM"))
	
	if (curPoints == nil) then
		curPoints = 0
	end
	
	writeScreenPlayData(pPlayer, "wodThemepark:prologue", "outcastSM", curPoints + 1)
end

function wod_outcast_convo_handler:getClanAlignment(pPlayer)
	local NSPoints = tonumber(readScreenPlayData(pPlayer, "wodThemepark:prologue", "outcastNS"))
	
	if (NSPoints == nil) then
		NSPoints = 0
	end
	
	local SMPoints = tonumber(readScreenPlayData(pPlayer, "wodThemepark:prologue", "outcastSM"))
	
	if (SMPoints == nil) then
		SMPoints = 0
	end
	
	if (NSPoints > SMPoints) then
		return "ns"
	else
		return "sm"
	end
end