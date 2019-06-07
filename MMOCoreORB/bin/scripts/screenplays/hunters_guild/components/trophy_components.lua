hgT1TrophyStates = {
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

hgT1TrophyMenuComponent = {}

function hgT1TrophyMenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	menuResponse:addRadialMenuItem(20, 3, "Collect Trophy")
end

function hgT1TrophyMenuComponent:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (SceneObject(pSceneObject):isASubChildOf(pPlayer) == false) then
		return 0
	end

	if (selectedID == 20) then
		local sui = SuiMessageBox.new("hgT1TrophyMenuComponent", "t1TrophyCollectCallback")
		sui.setTitle("Collect Trophy")
		sui.setPrompt("Do you want to add this trophy to your collection? If you do, then this trophy will be un-tradeable.")
		sui.sendTo(pPlayer)
	end
	return 0
end

function hgT1TrophyMenuComponent:noCallback(pPlayer, pSui, eventIndex, ...)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	for i = 1, #hgT1TrophyStates do
		if (string.find(SceneObject(pSceneObject):getTemplateObjectPath(), hgT1TrophyStates[i][1])) then
			if (CreatureObject(pPlayer):hasScreenPlayState(hgT1TrophyStates[i][2], "hgT1Trophies")) then
				CreatureObject(pPlayer):sendSystemMessage("You have already collected this trophy.")
				return 0
			else
				CreatureObject(pPlayer):setScreenPlayState(hgT1TrophyStates[i][2], "hgT1Trophies")
				TangibleObject(pSceneObject):setNoTrade(true)
			end
		end
	end
end

hgT1TrophyAttributeListComponent = {}

function hgT1TrophyAttributeListComponent:fillAttributeList(pALM, pPlayer, pObject)
	local ALM = LuaAttributeListMessage(pALM)

	for i = 1, #hgT1TrophyStates do
		if (CreatureObject(pPlayer):hasScreenPlayState(hgT1TrophyStates[i][2], "hgT1Trophies")) then
			ALM:insertNewAttribute(hgT1TrophyStates[i][1], "\\#008000Collected")
		else
			ALM:insertNewAttribute(hgT1TrophyStates[i][1], "\\#ff0000Not Collected")
		end
	end
end
