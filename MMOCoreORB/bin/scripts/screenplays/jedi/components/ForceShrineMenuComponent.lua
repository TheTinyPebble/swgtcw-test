ForceShrineMenuComponent = {}

function ForceShrineMenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	local menuResponse = LuaObjectMenuResponse(pMenuResponse)

	if (CustomJediManagerCommon.hasJediProgressionScreenPlayState(pPlayer, CUSTOM_JEDI_PROGRESSION_COMPLETED_HOLOCRON_TASKS)) then
		menuResponse:addRadialMenuItem(120, 3, "@jedi_trials:meditate") -- Meditate
	end

	if (CreatureObject(pPlayer):hasSkill("jedi_padawan_novice") or CreatureObject(pPlayer):hasSkill("dark_padawan_novice")) then
		menuResponse:addRadialMenuItem(121, 3, "@force_rank:recover_jedi_items") -- Recover Jedi Items
	end
	
	if (CreatureObject(pPlayer):hasSkill("jedi_padawan_master") or CreatureObject(pPlayer):hasSkill("dark_padawan_master")) then
		menuResponse:addRadialMenuItem(122, 3, "Switch Faction")
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
	elseif (selectedID == 121 and (CreatureObject(pPlayer):hasSkill("jedi_padawan_novice") or CreatureObject(pPlayer):hasSkill("dark_padawan_novice"))) then
		self:recoverRobe(pPlayer)
	elseif (selectedID == 122 and (CreatureObject(pPlayer):hasSkill("jedi_padawan_master") or CreatureObject(pPlayer):hasSkill("dark_padawan_master"))) then
		self:swapFaction(pPlayer)
	end

	return 0
end

function ForceShrineMenuComponent:doMeditate(pObject, pPlayer)
	if (pPlayer == nil) then
		return
	end
	
	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	
	if (pGhost == nil) then
		return
	end
	
	if (CreatureObject(pPlayer):hasSkill("base_bust_novice")) then
		CreatureObject(pPlayer):sendSystemMessage("You must drop 'base busting' skills to continue.")
		return
	end
	
	local skillManager = LuaSkillManager()
	local pSkill = skillManager:getSkill("jedi_padawan_novice")
	
	local skillObject = LuaSkill(pSkill)
	local pointsReq = skillObject:getSkillPointsRequired()
	local freePoints = PlayerObject(pGhost):getSkillPoints()
	
	if (pointsReq >= freePoints) then
		CreatureObject(pPlayer):sendSystemMessage("You need to free up " .. pointsReq .. " skill points to continue.")
		return
	end
	
	if (CreatureObject(pPlayer):getFaction() == 0) then
		CustomJediManagerCommon:sendFactionChoiceSui(pPlayer)
		return
	end
	
	local sui = SuiMessageBox.new("CustomJediManagerCommon", "emptyCallback")
	sui.setTitle("@jedi_trials:padawan_trials_title")
	sui.setPrompt("@jedi_trials:padawan_trials_completed")
	sui.sendTo(pPlayer)
	
	CreatureObject(pPlayer):playEffect("clienteffect/trap_electric_01.cef", "")
	CreatureObject(pPlayer):playMusicMessage("sound/music_become_jedi.snd")
	
	PlayerObject(pGhost):setJediState(2)
	awardSkill(pPlayer, "force_title_jedi_rank_01")
	
	local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")
	
	if (pInventory == nil or SceneObject(pInventory):isContainerFullRecursive()) then
		CreatureObject(pPlayer):sendSystemMessage("@jedi_spam:inventory_full_jedi_robe")
	else
		local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")
		local pItem = giveItem(pInventory, "object/tangible/wearables/robe/robe_jedi_padawan.iff", -1)
	end
	
	sendMail("system", "@jedi_spam:welcome_subject", "@jedi_spam:welcome_body", CreatureObject(pPlayer):getFirstName())
	
	if (CreatureObject(pPlayer):getFaction() == FACTIONIMPERIAL) then
		PlayerObject(pGhost):addWaypoint("yavin4", "Light Jedi Enclave", "", -5575, 4905, WAYPOINTYELLOW, true, true, 0)
		awardSkill(pPlayer, "jedi_padawan_novice")
	else
		PlayerObject(pGhost):addWaypoint("yavin4", "Dark Jedi Enclave", "", 5079, 305, WAYPOINTYELLOW, true, true, 0)
		awardSkill(pPlayer, "dark_padawan_novice")
	end
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

function ForceShrineMenuComponent:swapFaction(pPlayer)
	if (pPlayer == nil) then
		return
	end
	
	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	
	if (pGhost == nil) then
		return
	end

	if (CreatureObject(pPlayer):getFaction() == FACTIONIMPERIAL and (PlayerObject(pGhost):getFactionStanding("rebel") < 200)) then
		CreatureObject(pPlayer):sendSystemMessage("You do not have enough faction with the CIS to defect.")
		return
	elseif (CreatureObject(pPlayer):getFaction() == FACTIONREBEL and (PlayerObject(pGhost):getFactionStanding("imperial") < 200)) then
		CreatureObject(pPlayer):sendSystemMessage("You do not have enough faction with the Republic to defect.")
		return
	end
	
	local sui = SuiMessageBox.new("ForceShrineMenuComponent", "swapFactionCallback")
	sui.setTitle("Faction Defection Information")
	sui.setPrompt("Warning: You are about to swap factions. You will retain your profession skills, however you will lose your current faction rank and faction standing. Are you sure you would like to proceed?")

	sui.sendTo(pPlayer)
end

function ForceShrineMenuComponent:swapFactionCallback(pPlayer, pSui, eventIndex, ...)
	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	if (pGhost == nil) then
		return 0
	end

	local cancelPressed = (eventIndex == 1)

	if (cancelPressed or pCreature == nil) then
		return 0
	end
	
	if (CreatureObject(pPlayer):getFaction() == FACTIONIMPERIAL and (PlayerObject(pGhost):getFactionStanding("rebel") < 200)) then
		CreatureObject(pPlayer):setFaction(370444368) -- Rebel faction hash code
	elseif (CreatureObject(pPlayer):getFaction() == FACTIONREBEL and (PlayerObject(pGhost):getFactionStanding("imperial") < 200)) then
		CreatureObject(pPlayer):setFaction(3679112276) -- Imperial faction hash code
	end
	
	CreatureObject(pPlayer):setFactionStatus(1)
	
	if (CreatureObject(pPlayer):hasSkill("jedi_padawan_master")) then
		writeStringData("jediFactionSwap:" .. SceneObject(pPlayer):getObjectID(), "jedi_padawan_master")
	elseif (CreatureObject(pPlayer):hasSkill("dark_padawan_master")) then
		writeStringData("jediFactionSwap:" .. SceneObject(pPlayer):getObjectID(), "dark_padawan_master")
	end
	
	if (CreatureObject(pPlayer):hasSkill("jedi_light_side_defender_master")) then
		writeStringData("jediFactionSwap:" .. SceneObject(pPlayer):getObjectID(), "jedi_light_side_defender_master")
	elseif (CreatureObject(pPlayer):hasSkill("dark_dark_side_defender_master")) then
		writeStringData("jediFactionSwap:" .. SceneObject(pPlayer):getObjectID(), "dark_dark_side_defender_master")
	end
	
	if (CreatureObject(pPlayer):hasSkill("jedi_light_side_sabers_master")) then
		writeStringData("jediFactionSwap:" .. SceneObject(pPlayer):getObjectID(), "jedi_light_side_sabers_master")
	elseif (CreatureObject(pPlayer):hasSkill("dark_dark_side_sabers_master")) then
		writeStringData("jediFactionSwap:" .. SceneObject(pPlayer):getObjectID(), "dark_dark_side_sabers_master")
	end
	
	if (CreatureObject(pPlayer):hasSkill("jedi_light_side_healer_master")) then
		writeStringData("jediFactionSwap:" .. SceneObject(pPlayer):getObjectID(), "jedi_light_side_healer_master")
	elseif (CreatureObject(pPlayer):hasSkill("dark_dark_side_healer_master")) then
		writeStringData("jediFactionSwap:" .. SceneObject(pPlayer):getObjectID(), "dark_dark_side_healer_master")
	end
	
	if (CreatureObject(pPlayer):hasSkill("jedi_light_side_powers_master")) then
		writeStringData("jediFactionSwap:" .. SceneObject(pPlayer):getObjectID(), "jedi_light_side_powers_master")
	elseif (CreatureObject(pPlayer):hasSkill("dark_dark_side_powers_master")) then
		writeStringData("jediFactionSwap:" .. SceneObject(pPlayer):getObjectID(), "dark_dark_side_powers_master")
	end
		
	local skillManager = LuaSkillManager()
	skillManager:surrenderAllSkills(pPlayer, false)
	awardSkill(pPlayer, readStringData("jediFactionSwap:" .. SceneObject(pPlayer):getObjectID()))
	deleteStringData("jediFactionSwap:" .. SceneObject(pPlayer):getObjectID())
end