local QuestManager = require("managers.quest.quest_manager")

--TODO: Add schematic

wodRepairAltar1MenuComponent = {}

function wodRepairAltar1MenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (not CreatureObject(pPlayer):isInRangeWithObject(pSceneObject, 5)) then
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_01_01) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_01_01)) then
		menuResponse:addRadialMenuItem(20, 3, "@theme_park_wod/wod:investigate_altar")
	end

	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_01_02) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_01_02)) then
		menuResponse:addRadialMenuItem(21, 3, "@theme_park_wod/wod:repair_altar")
	end
	menuResponse:addRadialMenuItem(22, 3, "@theme_park_wod/wod:read_inscription")
end

function wodRepairAltar1MenuComponent:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	if (pGhost == nil) then
		return false
	end

	if (selectedID == 20) then
		--PlayerObject(pGhost):addRewardedSchematic(schematic, 2, -1, true)
		CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:schematic_learned_altar")

		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_01_01)) then
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_01_01)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_01_02)
		else
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_01_01)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_01_02)
		end
	end
	if (selectedID == 21) then
		local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")
		
		if (pInventory == nil) then
			return
		end

		local pItem = getContainerObjectByTemplate(pInventory, "object/tangible/theme_park/wod/wod_crafting_alter_key_1.iff", true)

		if (pItem == nil) then
			CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:no_altar_item")
			return
		end

		lightValue = LuaComponent(pItem):getAttributeValue("wod_repair_altar_light")
		darkValue = LuaComponent(pItem):getAttributeValue("wod_repair_altar_dark")
		wisdomValue = LuaComponent(pItem):getAttributeValue("wod_repair_altar_wisdom")

		if (lightValue == darkValue and lightValue + darkValue <= wisdomValue) then
			--PlayerObject(pGhost):removeRewardedSchematic(schematic, true)
			if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_01_02)) then
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_01_02)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_01_03)
				--Goto return
			else
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_01_02)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_01_03)
				--Goto return
			end
			CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:repair_complete")
		else
			CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:not_a_valid_key")
		end
		SceneObject(pItem):destroyObjectFromWorld()
	end
	if (selectedID == 22) then
		CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:altar_inscription_1")
	end
	return 0
end

wodRepairAltar2MenuComponent = {}

function wodRepairAltar2MenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (not CreatureObject(pPlayer):isInRangeWithObject(pSceneObject, 5)) then
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_02_01) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_02_01)) then
		menuResponse:addRadialMenuItem(20, 3, "@theme_park_wod/wod:investigate_altar")
	end

	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_02_02) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_02_02)) then
		menuResponse:addRadialMenuItem(21, 3, "@theme_park_wod/wod:rancor_returned_sm")
	end
	menuResponse:addRadialMenuItem(22, 3, "@theme_park_wod/wod:read_inscription")
end

function wodRepairAltar2MenuComponent:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	if (pGhost == nil) then
		return false
	end

	if (selectedID == 20) then		
		--PlayerObject(pGhost):addRewardedSchematic(schematic, 2, -1, true)
		CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:schematic_learned_altar")

		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_02_01)) then
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_02_01)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_02_02)
		else
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_02_01)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_02_02)
		end
	end
	if (selectedID == 21) then
		local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")

		if (pInventory == nil) then
			return
		end

		local pItem = getContainerObjectByTemplate(pInventory, "object/tangible/theme_park/wod/wod_crafting_alter_key_2.iff", true)

		if (pItem == nil) then
			CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:no_altar_item")
			return
		end

		lightValue = LuaComponent(pItem):getAttributeValue("wod_repair_altar_light")
		darkValue = LuaComponent(pItem):getAttributeValue("wod_repair_altar_dark")
		wisdomValue = LuaComponent(pItem):getAttributeValue("wod_repair_altar_wisdom")
		powerValue = LuaComponent(pItem):getAttributeValue("wod_repair_altar_power")

		if (lightValue == darkValue and lightValue == wisdomValue and lightValue == powerValue) then
			--PlayerObject(pGhost):removeRewardedSchematic(schematic, true)
			if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_02_02)) then
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_02_02)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_02_03)
				--Goto return
			else
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_02_02)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_02_03)
				--Goto return
			end
			CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:repair_complete")
		else
			CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:not_a_valid_key")
		end
		SceneObject(pItem):destroyObjectFromWorld()
	end
	if (selectedID == 22) then
		CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:altar_inscription_2")
	end
	return 0
end

wodRepairAltar3MenuComponent = {}

function wodRepairAltar3MenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (not CreatureObject(pPlayer):isInRangeWithObject(pSceneObject, 5)) then
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_03_01) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_03_01)) then
		menuResponse:addRadialMenuItem(20, 3, "@theme_park_wod/wod:investigate_altar")
	end

	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_03_02) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_03_02)) then
		menuResponse:addRadialMenuItem(21, 3, "@theme_park_wod/wod:rancor_returned_sm")
	end
	menuResponse:addRadialMenuItem(22, 3, "@theme_park_wod/wod:read_inscription")
end

function wodRepairAltar3MenuComponent:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	if (pGhost == nil) then
		return false
	end

	if (selectedID == 20) then		
		--PlayerObject(pGhost):addRewardedSchematic(schematic, 2, -1, true)
		CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:schematic_learned_altar")

		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_03_01)) then
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_03_01)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_03_02)
		else
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_03_01)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_03_02)
		end
			CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:repair_complete")
	end
	if (selectedID == 21) then
		local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")

		if (pInventory == nil) then
			return
		end

		local pItem = getContainerObjectByTemplate(pInventory, "object/tangible/theme_park/wod/wod_crafting_alter_key_2.iff", true)
		
		if (pItem == nil) then
			CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:no_altar_item")
			return
		end

		wisdomValue = LuaComponent(pItem):getAttributeValue("wod_repair_altar_wisdom")
		powerValue = LuaComponent(pItem):getAttributeValue("wod_repair_altar_power")
		ageValue = LuaComponent(pItem):getAttributeValue("wod_repair_altar_age")

		if (wisdomValue < powerValue and powerValue < powerValue) then
			--PlayerObject(pGhost):removeRewardedSchematic(schematic, true)
			if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_03_02)) then
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_03_02)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_03_03)
				--Goto return
			else
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_03_02)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_03_03)
				--Goto return
			end
			CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:repair_complete")
		else
			CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:not_a_valid_key")
		end
		SceneObject(pItem):destroyObjectFromWorld()
	end
	if (selectedID == 22) then
		CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:altar_inscription_3")
	end
	return 0
end

wodRepairAltar4MenuComponent = {}

function wodRepairAltar4MenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (not CreatureObject(pPlayer):isInRangeWithObject(pSceneObject, 5)) then
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_04_01) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_04_01)) then
		menuResponse:addRadialMenuItem(20, 3, "@theme_park_wod/wod:investigate_altar")
	end

	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_04_02) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_04_02)) then
		menuResponse:addRadialMenuItem(21, 3, "@theme_park_wod/wod:rancor_returned_sm")
	end
	menuResponse:addRadialMenuItem(22, 3, "@theme_park_wod/wod:read_inscription")
end

function wodRepairAltar4MenuComponent:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	if (pGhost == nil) then
		return false
	end

	if (selectedID == 20) then		
		--PlayerObject(pGhost):addRewardedSchematic(schematic, 2, -1, true)
		CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:schematic_learned_altar")

		if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_04_01)) then
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_04_01)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_04_02)
		else
			QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_04_01)
			QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_04_02)
		end
	end
	if (selectedID == 21) then
		local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")

		if (pInventory == nil) then
			return
		end

		local pItem = getContainerObjectByTemplate(pInventory, "object/tangible/theme_park/wod/wod_crafting_alter_key_2.iff", true)
		
		if (pItem == nil) then
			CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:no_altar_item")
			return
		end

		powerValue = LuaComponent(pItem):getAttributeValue("wod_repair_altar_power")
		trustValue = LuaComponent(pItem):getAttributeValue("wod_repair_altar_trust")
		friendshipValue = LuaComponent(pItem):getAttributeValue("wod_repair_altar_friendship")
		loyaltyValue = LuaComponent(pItem):getAttributeValue("wod_repair_altar_loyalty")

		if (trustValue == friendshipValue and trustValue == loyaltyValue and trustValue * 2 <= powerValue) then
			--PlayerObject(pGhost):removeRewardedSchematic(schematic, true)
			if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_04_02)) then
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_04_02)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_NS_REPAIR_ALTAR_04_03)
				--Goto return
			else
				QuestManager.completeQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_04_02)
				QuestManager.activateQuest(pPlayer, QuestManager.quests.WOD_SM_REPAIR_ALTAR_04_03)
				--Goto return
			end
			CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:repair_complete")
		else
			CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:not_a_valid_key")
		end
		SceneObject(pItem):destroyObjectFromWorld()
	end
	if (selectedID == 22) then
		CreatureObject(pPlayer):sendSystemMessage("@theme_park_wod/wod:altar_inscription_4")
	end
	return 0
end