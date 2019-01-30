ForceShrineMenuComponent = {}

function ForceShrineMenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	local menuResponse = LuaObjectMenuResponse(pMenuResponse)

	if (CustomJediManagerCommon.hasJediProgressionScreenPlayState(pPlayer, CUSTOM_JEDI_PROGRESSION_COMPLETED_HOLOCRON_TASKS)) then
		menuResponse:addRadialMenuItem(120, 3, "@jedi_trials:meditate") -- Meditate
	end

	if (CreatureObject(pPlayer):hasSkill("jedi_padawan_novice")) then
		menuResponse:addRadialMenuItem(121, 3, "@force_rank:recover_jedi_items") -- Recover Jedi Items
	end

end

function ForceShrineMenuComponent:handleObjectMenuSelect(pObject, pPlayer, selectedID)
	if (pPlayer == nil or pObject == nil) then
		return 0
	end

	if (selectedID == 120 and CustomJediManagerCommon.hasJediProgressionScreenPlayState(pPlayer, CUSTOM_JEDI_PROGRESSION_COMPLETED_HOLOCRON_TASKS)) then
		if (CreatureObject(pPlayer):getPosture() ~= CROUCHED) then
			CreatureObject(pPlayer):sendSystemMessage("@jedi_trials:show_respect") -- Must respect
		else
			self:doMeditate(pObject, pPlayer)
		end
	elseif (selectedID == 121 and CreatureObject(pPlayer):hasSkill("jedi_padawan_novice")) then
		self:recoverRobe(pPlayer)
	end

	return 0
end

function ForceShrineMenuComponent:doMeditate(pObject, pPlayer)
	if (pPlayer == nil) then
		return
	end
	
	if (CreatureObject(pPlayer):getFaction() == 0) then
		CustomJediManagerCommon:sendFactionChoiceSui(pPlayer)
	end
	
	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	
	if (pGhost == nil) then
		return
	end
	
	local sui = SuiMessageBox.new("CustomJediManagerCommon", "emptyCallback")
	sui.setTitle("@jedi_trials:padawan_trials_title")
	sui.setPrompt("@jedi_trials:padawan_trials_completed")
	sui.sendTo(pPlayer)
	
	awardSkill(pPlayer, "jedi_padawan_novice")
	CreatureObject(pPlayer):playEffect("clienteffect/trap_electric_01.cef", "")
	CreatureObject(pPlayer):playMusicMessage("sound/music_become_jedi.snd")
	
	PlayerObject(pGhost):setJediState(2)
	
	local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")
	
	if (pInventory == nil or SceneObject(pInventory):isContainerFullRecursive()) then
		CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:inventory_full_jedi_robe")
	else
		local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")
		local pItem = giveItem(pInventory, "object/tangible/wearables/robe/robe_jedi_padawan.iff", -1)
	end
	
	sendMail("system", "@jedi_spam:welcome_subject", "@jedi_spam:welcome_body", CreatureObject(pPlayer):getFirstName())
end

function ForceShrineMenuComponent:recoverRobe(pPlayer)
	local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")

	if (pInventory == nil) then
		return
	end

	if (SceneObject(pInventory):isContainerFullRecursive()) then
		CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:inventory_full_jedi_robe")
		return
	end

	local robeTemplate
	--if (CreatureObject(pPlayer):hasSkill("force_title_jedi_rank_03")) then
	--	local councilType = JediTrials:getJediCouncil(pPlayer)

--		if (councilType == JediTrials.COUNCIL_LIGHT) then
--			robeTemplate = "object/tangible/wearables/robe/robe_jedi_light_s01.iff"
--		else
--			robeTemplate = "object/tangible/wearables/robe/robe_jedi_dark_s01.iff"
--		end
--	else
--		robeTemplate = "object/tangible/wearables/robe/robe_jedi_padawan.iff"
--	end
	if (CreatureObject(pPlayer):hasSkill("jedi_dark_side_master_master")) then
		robeTemplate = "object/tangible/wearables/robe/robe_jedi_dark_s01.iff"
	elseif (CreatureObject(pPlayer):hasSkill("jedi_light_side_master_master")) then
		robeTemplate = "object/tangible/wearables/robe/robe_jedi_light_s01.iff"
	else
		robeTemplate = "object/tangible/wearables/robe/robe_jedi_padawan.iff"
	end
	giveItem(pInventory, robeTemplate, -1)
	CreatureObject(pPlayer):sendSystemMessage("@force_rank:items_recovered")
end
