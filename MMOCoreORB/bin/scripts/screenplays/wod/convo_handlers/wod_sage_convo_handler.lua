wod_sage_convo_handler = Object:new {}

local QuestManager = require("managers.quest.quest_manager")

-- TODO: Reward Handling

function wod_sage_convo_handler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local sage = self:getSageType(pPlayer, pNpc, pConvTemplate)
	local clan = readScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment")
	
	if (clan == "" or clan "" nil) then
		return convoTemplate("not_elligible")
	elseif ((sage == "wod_ns_sage" and clan == "sm") or (sage == "wod_sm_sage" and clan == "ns")) then
		return convoTemplate("wrong_alignment")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_01")) or QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_02")) or QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_03")) or QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_04"))) then
		return convoTemplate("quest_in_progress")
	elseif (QuestManager.hasCompletedQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_04"))) then
		return convoTemplate("quest_completed")
	end
	
	if (not CreatureObject(pPlayer):hasSkill("crafting_artisan_novice")) then
		return convoTemplate("not_crafter")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_04_04"))) then
		return convoTemplate("init_fifth")
	elseif (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_03_04")) or QuestManager.hasCompletedQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_03_04"))) then
		return convoTemplate("init_fourth")
	elseif (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_02_04")) or QuestManager.hasCompletedQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_02_04"))) then
		return convoTemplate("init_third")
	elseif (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_01_04")) or QuestManager.hasCompletedQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_01_04"))) then
		return convoTemplate("init_second")
	end

	return convoTemplate("initial")
end

function wod_sage_convo_handler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)
	local clan = readScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment")
	
	if (screenID == "quest_start_first") then
		QuestManager.activateQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_01_01"))
	elseif (screenID == "quest_start_second") then
		QuestManager.activateQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_02_01"))
	elseif (screenID == "quest_start_third") then
		QuestManager.activateQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_03_01"))
	elseif (screenID == "quest_start_fourth") then
		QuestManager.activateQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_04_01"))
	end

	if (screenID == "init_second") then
		QuestManager.completeQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_01_04"))
		QuestManager.completeQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_01"))
	elseif (screenID == "init_third") then
		QuestManager.completeQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_02_04"))
		QuestManager.completeQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_02"))
	elseif (screenID == "init_fourth") then
		QuestManager.completeQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_03_04"))
		QuestManager.completeQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_03"))
	elseif (screenID == "init_fifth") then
		QuestManager.completeQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_04_04"))
		QuestManager.completeQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_repair_altar_04"))
		--Handle reward
	end

    return pConvScreen
end

function wod_sage_convo_handler:getSageType(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local pScreen = convoTemplate:getScreen("sageType")
	local screen = LuaConversationScreen(pScreen)

	return screen:getOptionLink(0)
end