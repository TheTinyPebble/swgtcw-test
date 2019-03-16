wod_ns_rancor_mistress_convo_handler = Object:new {}

local QuestManager = require("managers.quest.quest_manager")

-- TODO: Reward Handling

function wod_ns_rancor_mistress_convo_handler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local clan = readScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment")

	if (clan == "" or clan "" nil) then
		return convoTemplate("not_elligible")
	elseif (clan == "sm") then
		return convoTemplate("wrong_alignment")
	end

	if (QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_03) and not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_04)) then
		return convoTemplate("whole_truth_two_init")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_KYRISA_BOSS_06) or (QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH) and not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_KYRISA_BOSS_FIGHT))) then
		return convoTemplate("return_whole_truth_two")
	end

	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH) and not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_03)) then
		return convoTemplate("quest_whole_truth_in_progress")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH) and not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_06)) then
		return convoTemplate("quest_whole_truth_two_in_progress")
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_KYRISA_BOSS_FIGHT)) then
		return convoTemplate("quest_greater_good_in_progress")
	end

	return convoTemplate("initial")
end

function wod_ns_rancor_mistress_convo_handler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)

	if (screenID == "start_quest_whole_truth") then
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_01)
		wodNSWholeTruth01Goto:start(pPlayer)
	end

	if (screenID == "complete_quest_whole_truth") then
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_03)
	end

	if (screenID == "start_quest_whole_truth_two") then
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_04)
		wodNSWholeTruth04Goto:start(pPlayer)
	end

	if (screenID == "return_whole_truth_two") then
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH)) then
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH_06)
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_WHOLE_TRUTH)
		end
	end

	if (screenID == "quest_greater_good_start") then
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_KYRISA_BOSS_FIGHT)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_KYRISA_BOSS_FIGHT_01)
	end

    return pConvScreen
end
