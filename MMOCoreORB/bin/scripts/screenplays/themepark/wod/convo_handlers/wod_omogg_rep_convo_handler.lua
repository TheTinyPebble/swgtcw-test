wod_omogg_rep_convo_handler = conv_handler:new{}

local QuestManager = require("managers.quest.quest_manager")

function wod_omogg_rep_convo_handler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	
	if (QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT)) then
		return convoTemplate:getScreen("quest_completed")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT) and not (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT_04) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT_08))) then
		return convoTemplate:getScreen("quest_in_progress")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT_04)) then
		return convoTemplate:getScreen("walkabout_return_init")
	end
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT_08)) then
		return convoTemplate:getScreen("walkabout_two_return_init")
	end
	
	if (QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT_04) and not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT_05)) then
		return convoTemplate:getScreen("walkabout_two_init_alt")
	end

	return convoTemplate:getScreen("initial")
end

function wod_omogg_rep_convo_handler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
    local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)
	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	
	if (pGhost == nil) then
		return pConvScreen
	end
	
	if (screenID == "walkabout_start") then
		wodWalkabout1Goto:start(pPlayer)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT)
	QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT_01)
	end
	
	if (screenID == "walkabout_complete") then
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT_04)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT_05)
	end
	
	if (screenID == "walkabout_two_start") then
		wodWalkabout5Goto:start(pPlayer)
	end
	
	if (screenID == "walkabout_two_complete") then
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT_08)
		QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_WALKABOUT)
		QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_MEET_MYSTERIOUS_WITCH)
		PlayerObject(pGhost):addWaypoint("dathomir", "@theme_park_wod/wod_prologue_walkabout:task09_waypoint_name", "", -3177, 3184, WAYPOINTGREEN, true, true, 0)
	end
	
    return pConvScreen
end
