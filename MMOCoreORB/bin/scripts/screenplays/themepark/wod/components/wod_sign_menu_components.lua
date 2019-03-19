wodStandingSignMenuComponent = {}

function wodStandingSignMenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end
	
	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	menuResponse:addRadialMenuItem(20, 3, "Learn Sign")
end

function wodStandingSignMenuComponent:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (selectedID == 20) then
		if (SceneObject(pSceneObject):isASubChildOf(pPlayer) == false) then
			CreatureObject(pPlayer):sendSystemMessage("You need to have this item in your inventory to learn it.")
			return 0
		end
		
		if (CreatureObject(pPlayer):hasSkill("loot_sign_01")) then
			CreatureObject(pPlayer):sendSystemMessage("You already know this sign.")
			return 0
		end
		
		awardSkill(pPlayer, "loot_sign_01")
		SceneObject(pSceneObject):destroyObjectFromWorld()
	end
	return 0
end

wodHangingSignMenuComponent = {}

function wodHangingSignMenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end
	
	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	menuResponse:addRadialMenuItem(20, 3, "Learn Sign")
end

function wodHangingSignMenuComponent:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (selectedID == 20) then
		if (SceneObject(pSceneObject):isASubChildOf(pPlayer) == false) then
			CreatureObject(pPlayer):sendSystemMessage("You need to have this item in your inventory to learn it.")
			return 0
		end
		
		if (CreatureObject(pPlayer):hasSkill("loot_sign_02")) then
			CreatureObject(pPlayer):sendSystemMessage("You already know this sign.")
			return 0
		end
		
		awardSkill(pPlayer, "loot_sign_02")
		SceneObject(pSceneObject):destroyObjectFromWorld()
	end
	return 0
end