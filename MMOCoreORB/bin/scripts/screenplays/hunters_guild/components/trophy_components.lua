ghaT1TrophyStates = {
	{"trophy_bocatt_unmounted", 1},
	{"trophy_choku_unmounted", 2},
	{"trophy_corellian_sand_panther_unmounted", 4},
	{"trophy_gurreck_unmounted", 8},
	{"trophy_kliknik_unmounted", 16},
	{"trophy_peko_peko_unmounted", 32},
	{"trophy_slice_hound_unmounted", 64},
	{"trophy_swirlprong_unmounted", 128},
	{"trophy_verne_unmounted", 256},
	{"trophy_zucca_boar_unmounted", 512},
}

ghaT1TrophyMenuComponent = {}

function ghaT1TrophyMenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	menuResponse:addRadialMenuItem(20, 3, "Collect Trophy")
end

function ghaT1TrophyMenuComponent:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (SceneObject(pSceneObject):isASubChildOf(pPlayer) == false) then
		return 0
	end

	if (selectedID == 20) then
		writeData("ghaT1TrophyID" .. SceneObject(pPlayer):getObjectID(), SceneObject(pSceneObject):getObjectID())
		local sui = SuiMessageBox.new("ghaT1TrophyMenuComponent", "t1TrophyCollectCallback")
		sui.setTitle("Collect Trophy")
		sui.setPrompt("Do you want to add this trophy to your collection? If you do, then this trophy will be un-tradeable.")
		sui.sendTo(pPlayer)
	end
	return 0
end

function ghaT1TrophyMenuComponent:t1TrophyCollectCallback(pPlayer, pSui, eventIndex, ...)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	local pSceneObject = getSceneObject(readData("ghaT1TrophyID" .. SceneObject(pPlayer):getObjectID()))
	
	if (pSceneObject == nil) then
		return
	end

	for i = 1, #ghaT1TrophyStates do
		if (string.find(SceneObject(pSceneObject):getTemplateObjectPath(), ghaT1TrophyStates[i][1])) then
			if (CreatureObject(pPlayer):hasScreenPlayState(ghaT1TrophyStates[i][2], "ghaT1Trophies")) then
				CreatureObject(pPlayer):sendSystemMessage("You have already collected this trophy.")
				return 0
			else
				CreatureObject(pPlayer):setScreenPlayState(ghaT1TrophyStates[i][2], "ghaT1Trophies")
				TangibleObject(pSceneObject):setNoTrade(true)
			end
		end
	end
	
	deleteData("ghaT1TrophyID" .. SceneObject(pPlayer):getObjectID())
end

ghaT1TrophyAttributeListComponent = {}

function ghaT1TrophyAttributeListComponent:fillAttributeList(pALM, pPlayer, pObject)
	local ALM = LuaAttributeListMessage(pALM)
	
	if (TangibleObject(pObject):isNoTrade()) then
		ALM:insertNewAttribute("no_trade", "\\#ff0000No Trade")
	end

	for i = 1, #ghaT1TrophyStates do
		if (CreatureObject(pPlayer):hasScreenPlayState(ghaT1TrophyStates[i][2], "ghaT1Trophies")) then
			ALM:insertNewAttribute(ghaT1TrophyStates[i][1], "\\#008000Collected")
		else
			ALM:insertNewAttribute(ghaT1TrophyStates[i][1], "\\#ff0000Not Collected")
		end
	end
end
