wod_queen_mother_convo_handler = Object:new {}

local QuestManager = require("managers.quest.quest_manager")

-- TODO: Reward Handling

function wod_queen_mother_convo_handler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local clan = readScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment")

	if (QuestManager.hasCompletedQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_queen_mother_fight"))) then
		return convoTemplate("quest_complete")
	end
	
	if (QuestManager.hasCompletedQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_ehs"))) then
		return convoTemplate("hunting_init")
	end

	if (QuestManager.hasActiveQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_ehs_03"))) then
		return convoTemplate("initial")
	end
	
	return convoTemplate("not_elligible")
end

function wod_queen_mother_convo_handler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)
	local clan = readScreenPlayData(pPlayer, "witchesOfDathomir", "clanAlignment")

	if (screenID == "complete_spiderclan_secret") then
		QuestManager.completeQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_ehs_03"))
		QuestManager.activateQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_ehs_04"))
		if (clan == "ns") then
			wodNSEHSReturnGoto:start(pPlayer)
		else
			wodSMEHSReturnGoto:start(pPlayer)
		end
	end

	if (screenID == "hunting_start_quest") then
		if (readData("wodThemepark:queenMotherBossFight:active") == 1) then
			return convoTemplate("busy")
		elseif (self:checkGroupStatus(pPlayer)) then
			QuestManager.completeQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_queen_mother_fight_02"))
			QuestManager.activateQuest(pPlayer, getPlayerQuestID("wod_" .. clan .. "_queen_mother_fight_03"))
			wodSpiderclanArc:startBossFight(pPlayer)
		else
			return convoTemplate("not_in_group")
		end
	end

    return pConvScreen
end

function wod_queen_mother_convo_handler:checkGroupStatus(pPlayer)
	if (pPlayer == nil) then
		return false
	end
	
	if (CreatureObject(pPlayer):isGrouped()) then
		local groupSize = CreatureObject(pPlayer):getGroupSize()

		for i = 0, groupSize - 1, 1 do
			local pMember = CreatureObject(pPlayer):getGroupMember(i)
			if (pMember ~= nil and pMember ~= pPlayer and CreatureObject(pPlayer):isInRangeWithObject(pMember, 50) and not SceneObject(pMember):isAiAgent()) then
				return true
			end
		end
	end
	return false
end
