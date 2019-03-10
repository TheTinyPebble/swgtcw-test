local QuestManager = require("managers.quest.quest_manager")

wodProSMBasketMenuComponent = {}

function wodProSMBasketMenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end
	
	if (not CreatureObject(pPlayer):isInRangeWithObject(pSceneObject, 5)) then
		return
	end
	
	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_SPIDER_CLAN_04)) then
		menuResponse:addRadialMenuItem(20, 3, "@wod_theme_park/messages:store_spider")
		return
	end
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_RANCOR_04)) then
		menuResponse:addRadialMenuItem(20, 3, "@wod_theme_park/messages:store_teeth")
		return
	end
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_07)) then
		menuResponse:addRadialMenuItem(20, 3, "@wod_theme_park/messages:store_herb")
		return
	end
end

function wodProSMBasketMenuComponent:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return 0
	end

	if (selectedID == 20) then
		if (creatureObject(pPlayer):isRidingMount()) then
			CreatureObject(pPlayer):sendSystemMessage("@wod_theme_park/messages:store_herb_not_while_mounted")
			return 0
		end
		
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_SPIDER_CLAN_04)) then
			CreatureObject(pPlayer):sendSystemMessage("@wod_theme_park/messages:store_spider_singing")
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_SPIDER_CLAN_04)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_SPIDER_CLAN_05)
			return 0
		end
		
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_RANCOR_04)) then
			CreatureObject(pPlayer):sendSystemMessage("@wod_theme_park/messages:store_rancor_singing")
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_RANCOR_04)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_RANCOR_05)
			return 0
		end

		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_07)) then
			CreatureObject(pPlayer):sendSystemMessage("@wod_theme_park/messages:store_herb_singing")
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_07)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_08)
			return 0
		end
	end
	return 0
end

wodProNSBasketMenuComponent = {}

function wodProNSBasketMenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end
	
	if (not CreatureObject(pPlayer):isInRangeWithObject(pSceneObject, 5)) then
		return
	end
	
	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_SPIDER_CLAN_04)) then
		menuResponse:addRadialMenuItem(20, 3, "@wod_theme_park/messages:store_spider")
		return
	end
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_RANCOR_04)) then
		menuResponse:addRadialMenuItem(20, 3, "@wod_theme_park/messages:store_teeth")
		return
	end
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_07)) then
		menuResponse:addRadialMenuItem(20, 3, "@wod_theme_park/messages:store_herb")
		return
	end
end

function wodProNSBasketMenuComponent:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return 0
	end

	if (selectedID == 20) then
		if (creatureObject(pPlayer):isRidingMount()) then
			CreatureObject(pPlayer):sendSystemMessage("@wod_theme_park/messages:store_herb_not_while_mounted")
			return 0
		end
		
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_SPIDER_CLAN_04)) then
			CreatureObject(pPlayer):sendSystemMessage("@wod_theme_park/messages:store_spider_nightsister")
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_SPIDER_CLAN_04)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_SPIDER_CLAN_06)
			return 0
		end
		
		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_RANCOR_04)) then
			CreatureObject(pPlayer):sendSystemMessage("@wod_theme_park/messages:store_rancor_nightsister")
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_RANCOR_04)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_ELIMINATE_RANCOR_06)
			return 0
		end

		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_07)) then
			CreatureObject(pPlayer):sendSystemMessage("@wod_theme_park/messages:store_herb_nightsister")
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_07)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_09)
			return 0
		end
	end
	return 0
end