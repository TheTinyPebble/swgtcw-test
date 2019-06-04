ForceShrineMenuComponent = {}

local jediSkills = {
	jedi_defender_light = {
		"jedi_padawan_novice",
		"jedi_padawan_saber_01",
		"jedi_padawan_saber_02",
		"jedi_padawan_saber_03",
		"jedi_padawan_saber_04",
		"jedi_padawan_healing_01",
		"jedi_padawan_healing_02",
		"jedi_padawan_healing_03",
		"jedi_padawan_healing_04",
		"jedi_padawan_force_power_01",
		"jedi_padawan_force_power_02",
		"jedi_padawan_force_power_03",
		"jedi_padawan_force_power_04",
		"jedi_padawan_force_manipulation_01",
		"jedi_padawan_force_manipulation_02",
		"jedi_padawan_force_manipulation_03",
		"jedi_padawan_force_manipulation_04",
		"jedi_padawan_master",
		"jedi_light_side_defender_novice",
		"jedi_light_side_defender_saber_01",
		"jedi_light_side_defender_saber_02",
		"jedi_light_side_defender_saber_03",
		"jedi_light_side_defender_saber_04",
		"jedi_light_side_defender_mitigation_01",
		"jedi_light_side_defender_mitigation_02",
		"jedi_light_side_defender_mitigation_03",
		"jedi_light_side_defender_mitigation_04",
		"jedi_light_side_defender_force_power_01",
		"jedi_light_side_defender_force_power_02",
		"jedi_light_side_defender_force_power_03",
		"jedi_light_side_defender_force_power_04",
		"jedi_light_side_defender_force_manipulation_01",
		"jedi_light_side_defender_force_manipulation_02",
		"jedi_light_side_defender_force_manipulation_03",
		"jedi_light_side_defender_force_manipulation_04",
		"jedi_light_side_defender_master",
	},
	
	jedi_sabers_light = {
		"jedi_padawan_novice",
		"jedi_padawan_saber_01",
		"jedi_padawan_saber_02",
		"jedi_padawan_saber_03",
		"jedi_padawan_saber_04",
		"jedi_padawan_healing_01",
		"jedi_padawan_healing_02",
		"jedi_padawan_healing_03",
		"jedi_padawan_healing_04",
		"jedi_padawan_force_power_01",
		"jedi_padawan_force_power_02",
		"jedi_padawan_force_power_03",
		"jedi_padawan_force_power_04",
		"jedi_padawan_force_manipulation_01",
		"jedi_padawan_force_manipulation_02",
		"jedi_padawan_force_manipulation_03",
		"jedi_padawan_force_manipulation_04",
		"jedi_padawan_master",
		"jedi_light_side_sabers_novice",
		"jedi_light_side_sabers_saber_single_01",
		"jedi_light_side_sabers_saber_single_02",
		"jedi_light_side_sabers_saber_single_03",
		"jedi_light_side_sabers_saber_single_04",
		"jedi_light_side_sabers_saber_dbl_01",
		"jedi_light_side_sabers_saber_dbl_02",
		"jedi_light_side_sabers_saber_dbl_03",
		"jedi_light_side_sabers_saber_dbl_04",
		"jedi_light_side_sabers_craftsmanship_01",
		"jedi_light_side_sabers_craftsmanship_02",
		"jedi_light_side_sabers_craftsmanship_03",
		"jedi_light_side_sabers_craftsmanship_04",
		"jedi_light_side_sabers_force_manipulation_01",
		"jedi_light_side_sabers_force_manipulation_02",
		"jedi_light_side_sabers_force_manipulation_03",
		"jedi_light_side_sabers_force_manipulation_04",
		"jedi_light_side_sabers_master",
	},
	
	jedi_healer_light = {
		"jedi_padawan_novice",
		"jedi_padawan_saber_01",
		"jedi_padawan_saber_02",
		"jedi_padawan_saber_03",
		"jedi_padawan_saber_04",
		"jedi_padawan_healing_01",
		"jedi_padawan_healing_02",
		"jedi_padawan_healing_03",
		"jedi_padawan_healing_04",
		"jedi_padawan_force_power_01",
		"jedi_padawan_force_power_02",
		"jedi_padawan_force_power_03",
		"jedi_padawan_force_power_04",
		"jedi_padawan_force_manipulation_01",
		"jedi_padawan_force_manipulation_02",
		"jedi_padawan_force_manipulation_03",
		"jedi_padawan_force_manipulation_04",
		"jedi_padawan_master",
		"jedi_light_side_healer_novice",
		"jedi_light_side_healer_saber_01",
		"jedi_light_side_healer_saber_02",
		"jedi_light_side_healer_saber_03",
		"jedi_light_side_healer_saber_04",
		"jedi_light_side_healer_heals_01",
		"jedi_light_side_healer_heals_02",
		"jedi_light_side_healer_heals_03",
		"jedi_light_side_healer_heals_04",
		"jedi_light_side_healer_force_power_01",
		"jedi_light_side_healer_force_power_02",
		"jedi_light_side_healer_force_power_03",
		"jedi_light_side_healer_force_power_04",
		"jedi_light_side_healer_manipulation_01",
		"jedi_light_side_healer_manipulation_02",
		"jedi_light_side_healer_manipulation_03",
		"jedi_light_side_healer_manipulation_04",
		"jedi_light_side_healer_master",
	},
	
	jedi_powers_light = {
		"jedi_padawan_novice",
		"jedi_padawan_saber_01",
		"jedi_padawan_saber_02",
		"jedi_padawan_saber_03",
		"jedi_padawan_saber_04",
		"jedi_padawan_healing_01",
		"jedi_padawan_healing_02",
		"jedi_padawan_healing_03",
		"jedi_padawan_healing_04",
		"jedi_padawan_force_power_01",
		"jedi_padawan_force_power_02",
		"jedi_padawan_force_power_03",
		"jedi_padawan_force_power_04",
		"jedi_padawan_force_manipulation_01",
		"jedi_padawan_force_manipulation_02",
		"jedi_padawan_force_manipulation_03",
		"jedi_padawan_force_manipulation_04",
		"jedi_padawan_master",
		"jedi_light_side_powers_novice",
		"jedi_light_side_powers_assault_01",
		"jedi_light_side_powers_assault_02",
		"jedi_light_side_powers_assault_03",
		"jedi_light_side_powers_assault_04",
		"jedi_light_side_powers_ranged_01",
		"jedi_light_side_powers_ranged_02",
		"jedi_light_side_powers_ranged_03",
		"jedi_light_side_powers_ranged_04",
		"jedi_light_side_powers_power_01",
		"jedi_light_side_powers_power_02",
		"jedi_light_side_powers_power_03",
		"jedi_light_side_powers_power_04",
		"jedi_light_side_powers_manipulation_01",
		"jedi_light_side_powers_manipulation_02",
		"jedi_light_side_powers_manipulation_03",
		"jedi_light_side_powers_manipulation_04",
		"jedi_light_side_powers_master",
	},
	
	jedi_defender_dark = {
		"dark_padawan_novice",
		"dark_padawan_saber_01",
		"dark_padawan_saber_02",
		"dark_padawan_saber_03",
		"dark_padawan_saber_04",
		"dark_padawan_healing_01",
		"dark_padawan_healing_02",
		"dark_padawan_healing_03",
		"dark_padawan_healing_04",
		"dark_padawan_force_power_01",
		"dark_padawan_force_power_02",
		"dark_padawan_force_power_03",
		"dark_padawan_force_power_04",
		"dark_padawan_force_manipulation_01",
		"dark_padawan_force_manipulation_02",
		"dark_padawan_force_manipulation_03",
		"dark_padawan_force_manipulation_04",
		"dark_padawan_master",
		"dark_dark_side_defender_novice",
		"dark_dark_side_defender_saber_01",
		"dark_dark_side_defender_saber_02",
		"dark_dark_side_defender_saber_03",
		"dark_dark_side_defender_saber_04",
		"dark_dark_side_defender_mitigation_01",
		"dark_dark_side_defender_mitigation_02",
		"dark_dark_side_defender_mitigation_03",
		"dark_dark_side_defender_mitigation_04",
		"dark_dark_side_defender_force_power_01",
		"dark_dark_side_defender_force_power_02",
		"dark_dark_side_defender_force_power_03",
		"dark_dark_side_defender_force_power_04",
		"dark_dark_side_defender_force_manipulation_01",
		"dark_dark_side_defender_force_manipulation_02",
		"dark_dark_side_defender_force_manipulation_03",
		"dark_dark_side_defender_force_manipulation_04",
		"dark_dark_side_defender_master",
	},
	
	jedi_sabers_dark = {
		"dark_padawan_novice",
		"dark_padawan_saber_01",
		"dark_padawan_saber_02",
		"dark_padawan_saber_03",
		"dark_padawan_saber_04",
		"dark_padawan_healing_01",
		"dark_padawan_healing_02",
		"dark_padawan_healing_03",
		"dark_padawan_healing_04",
		"dark_padawan_force_power_01",
		"dark_padawan_force_power_02",
		"dark_padawan_force_power_03",
		"dark_padawan_force_power_04",
		"dark_padawan_force_manipulation_01",
		"dark_padawan_force_manipulation_02",
		"dark_padawan_force_manipulation_03",
		"dark_padawan_force_manipulation_04",
		"dark_padawan_master",
		"dark_dark_side_sabers_novice",
		"dark_dark_side_sabers_saber_single_01",
		"dark_dark_side_sabers_saber_single_02",
		"dark_dark_side_sabers_saber_single_03",
		"dark_dark_side_sabers_saber_single_04",
		"dark_dark_side_sabers_saber_dbl_01",
		"dark_dark_side_sabers_saber_dbl_02",
		"dark_dark_side_sabers_saber_dbl_03",
		"dark_dark_side_sabers_saber_dbl_04",
		"dark_dark_side_sabers_craftsmanship_01",
		"dark_dark_side_sabers_craftsmanship_02",
		"dark_dark_side_sabers_craftsmanship_03",
		"dark_dark_side_sabers_craftsmanship_04",
		"dark_dark_side_sabers_force_manipulation_01",
		"dark_dark_side_sabers_force_manipulation_02",
		"dark_dark_side_sabers_force_manipulation_03",
		"dark_dark_side_sabers_force_manipulation_04",
		"dark_dark_side_sabers_master",
	},
	
	jedi_healer_dark = {
		"dark_padawan_novice",
		"dark_padawan_saber_01",
		"dark_padawan_saber_02",
		"dark_padawan_saber_03",
		"dark_padawan_saber_04",
		"dark_padawan_healing_01",
		"dark_padawan_healing_02",
		"dark_padawan_healing_03",
		"dark_padawan_healing_04",
		"dark_padawan_force_power_01",
		"dark_padawan_force_power_02",
		"dark_padawan_force_power_03",
		"dark_padawan_force_power_04",
		"dark_padawan_force_manipulation_01",
		"dark_padawan_force_manipulation_02",
		"dark_padawan_force_manipulation_03",
		"dark_padawan_force_manipulation_04",
		"dark_padawan_master",
		"dark_dark_side_healer_novice",
		"dark_dark_side_healer_saber_01",
		"dark_dark_side_healer_saber_02",
		"dark_dark_side_healer_saber_03",
		"dark_dark_side_healer_saber_04",
		"dark_dark_side_healer_heals_01",
		"dark_dark_side_healer_heals_02",
		"dark_dark_side_healer_heals_03",
		"dark_dark_side_healer_heals_04",
		"dark_dark_side_healer_force_power_01",
		"dark_dark_side_healer_force_power_02",
		"dark_dark_side_healer_force_power_03",
		"dark_dark_side_healer_force_power_04",
		"dark_dark_side_healer_manipulation_01",
		"dark_dark_side_healer_manipulation_02",
		"dark_dark_side_healer_manipulation_03",
		"dark_dark_side_healer_manipulation_04",
		"dark_dark_side_healer_master",
	},
	
	jedi_powers_dark = {
		"dark_padawan_novice",
		"dark_padawan_saber_01",
		"dark_padawan_saber_02",
		"dark_padawan_saber_03",
		"dark_padawan_saber_04",
		"dark_padawan_healing_01",
		"dark_padawan_healing_02",
		"dark_padawan_healing_03",
		"dark_padawan_healing_04",
		"dark_padawan_force_power_01",
		"dark_padawan_force_power_02",
		"dark_padawan_force_power_03",
		"dark_padawan_force_power_04",
		"dark_padawan_force_manipulation_01",
		"dark_padawan_force_manipulation_02",
		"dark_padawan_force_manipulation_03",
		"dark_padawan_force_manipulation_04",
		"dark_padawan_master",
		"dark_dark_side_powers_novice",
		"dark_dark_side_powers_assault_01",
		"dark_dark_side_powers_assault_02",
		"dark_dark_side_powers_assault_03",
		"dark_dark_side_powers_assault_04",
		"dark_dark_side_powers_ranged_01",
		"dark_dark_side_powers_ranged_02",
		"dark_dark_side_powers_ranged_03",
		"dark_dark_side_powers_ranged_04",
		"dark_dark_side_powers_power_01",
		"dark_dark_side_powers_power_02",
		"dark_dark_side_powers_power_03",
		"dark_dark_side_powers_power_04",
		"dark_dark_side_powers_manipulation_01",
		"dark_dark_side_powers_manipulation_02",
		"dark_dark_side_powers_manipulation_03",
		"dark_dark_side_powers_manipulation_04",
		"dark_dark_side_powers_master",
	},
}

function ForceShrineMenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	local menuResponse = LuaObjectMenuResponse(pMenuResponse)

	if (CustomJediManagerCommon.hasJediProgressionScreenPlayState(pPlayer, CUSTOM_JEDI_PROGRESSION_COMPLETED_HOLOCRON_TASKS)) then
		menuResponse:addRadialMenuItem(120, 3, "@jedi_trials:meditate") -- Meditate
	end

	if (CreatureObject(pPlayer):hasSkill("jedi_padawan_novice") or CreatureObject(pPlayer):hasSkill("dark_padawan_novice")) then
		menuResponse:addRadialMenuItem(121, 3, "@force_rank:recover_jedi_items") -- Recover Jedi Items
	end
	
	if (CreatureObject(pPlayer):hasSkill("jedi_light_side_defender_master") or CreatureObject(pPlayer):hasSkill("jedi_light_side_sabers_master") or CreatureObject(pPlayer):hasSkill("jedi_light_side_healer_master") or CreatureObject(pPlayer):hasSkill("jedi_light_side_powers_master") or CreatureObject(pPlayer):hasSkill("dark_dark_side_defender_master") or CreatureObject(pPlayer):hasSkill("dark_dark_side_sabers_master") or CreatureObject(pPlayer):hasSkill("dark_dark_side_healer_master") or CreatureObject(pPlayer):hasSkill("dark_dark_side_powers_master")) then
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
	elseif (selectedID == 122 and (CreatureObject(pPlayer):hasSkill("jedi_light_side_defender_master") or CreatureObject(pPlayer):hasSkill("jedi_light_side_sabers_master") or CreatureObject(pPlayer):hasSkill("jedi_light_side_healer_master") or CreatureObject(pPlayer):hasSkill("jedi_light_side_powers_master") or CreatureObject(pPlayer):hasSkill("dark_dark_side_defender_master") or CreatureObject(pPlayer):hasSkill("dark_dark_side_sabers_master") or CreatureObject(pPlayer):hasSkill("dark_dark_side_healer_master") or CreatureObject(pPlayer):hasSkill("dark_dark_side_powers_master"))) then
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

	if (cancelPressed or pPlayer == nil) then
		return 0
	end
	
	if (CreatureObject(pPlayer):getFaction() == FACTIONIMPERIAL) then
		CreatureObject(pPlayer):setFaction(FACTIONREBEL)
	elseif (CreatureObject(pPlayer):getFaction() == FACTIONREBEL) then
		CreatureObject(pPlayer):setFaction(FACTIONIMPERIAL)
	end
	
	CreatureObject(pPlayer):setFactionStatus(1)

	if (CreatureObject(pPlayer):hasSkill("jedi_light_side_defender_master")) then
		for i = #jediSkills.jedi_defender_light, 1, -1 do
			CreatureObject(pPlayer):surrenderSkill(jediSkills.jedi_defender_light[i])
		end
		for i = 1, #jediSkills.jedi_defender_dark do
			awardSkill(pPlayer, jediSkills.jedi_defender_dark[i])
		end
	elseif (CreatureObject(pPlayer):hasSkill("dark_dark_side_defender_master")) then
		for i = #jediSkills.jedi_defender_dark, 1, -1 do
			CreatureObject(pPlayer):surrenderSkill(jediSkills.jedi_defender_dark[i])
		end
		for i = 1, #jediSkills.jedi_defender_light do
			awardSkill(pPlayer, jediSkills.jedi_defender_light[i])
		end
	elseif (CreatureObject(pPlayer):hasSkill("jedi_light_side_sabers_master")) then
		for i = #jediSkills.jedi_sabers_light, 1, -1 do
			CreatureObject(pPlayer):surrenderSkill(jediSkills.jedi_sabers_light[i])
		end
		for i = 1, #jediSkills.jedi_sabers_dark do
			awardSkill(pPlayer, jediSkills.jedi_sabers_dark[i])
		end
	elseif (CreatureObject(pPlayer):hasSkill("dark_dark_side_sabers_master")) then
		for i = #jediSkills.jedi_sabers_dark, 1, -1 do
			CreatureObject(pPlayer):surrenderSkill(jediSkills.jedi_sabers_dark[i])
		end
		for i = 1, #jediSkills.jedi_sabers_light do
			awardSkill(pPlayer, jediSkills.jedi_sabers_light[i])
		end
	elseif (CreatureObject(pPlayer):hasSkill("jedi_light_side_healer_master")) then
		for i = #jediSkills.jedi_healer_light, 1, -1 do
			CreatureObject(pPlayer):surrenderSkill(jediSkills.jedi_healer_light[i])
		end
		for i = 1, #jediSkills.jedi_healer_dark do
			awardSkill(pPlayer, jediSkills.jedi_healer_dark[i])
		end
	elseif (CreatureObject(pPlayer):hasSkill("dark_dark_side_healer_master")) then
		for i = #jediSkills.jedi_healer_dark, 1, -1 do
			CreatureObject(pPlayer):surrenderSkill(jediSkills.jedi_healer_dark[i])
		end
		for i = 1, #jediSkills.jedi_healer_light do
			awardSkill(pPlayer, jediSkills.jedi_healer_light[i])
		end
	elseif (CreatureObject(pPlayer):hasSkill("jedi_light_side_powers_master")) then
		for i = #jediSkills.jedi_powers_light, 1, -1 do
			CreatureObject(pPlayer):surrenderSkill(jediSkills.jedi_powers_light[i])
		end
		for i = 1, #jediSkills.jedi_powers_dark do
			awardSkill(pPlayer, jediSkills.jedi_powers_dark[i])
		end
	elseif (CreatureObject(pPlayer):hasSkill("dark_dark_side_powers_master")) then
		for i = #jediSkills.jedi_powers_dark, 1, -1 do
			CreatureObject(pPlayer):surrenderSkill(jediSkills.jedi_powers_dark[i])
		end
		for i = 1, #jediSkills.jedi_powers_light do
			awardSkill(pPlayer, jediSkills.jedi_powers_light[i])
		end
	end
end
