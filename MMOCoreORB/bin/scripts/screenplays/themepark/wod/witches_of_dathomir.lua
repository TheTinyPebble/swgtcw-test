witchesOfDathomirScreenplay = ScreenPlay:new {
	spawnZones = {
		{ --Mutant rancor prologue location
			x = -5536, 
			y = 3968, 
			spawnCount = 15, 
			radius = 50, 
			respawnTimer = 300,
			spawnTemplates = {
				"mutant_rancer"
			},
		}, 
		{ --Spiderclan prologue location
			x = -1887, 
			y = 124, 
			spawnCount = 15, 
			radius = 50, 
			respawnTimer = 300,
			spawnTemplates = {
				"spiderclan_acolyte",
				"spiderclan_auspex",
				"spiderclan_crawler",
				"spiderclan_elder",
				"spiderclan_protector",
				"spiderclan_sentinel",
				"spiderclan_sentry",
				"spiderclan_stalker",
				"spiderclan_web_dancer"
			},
		}, 
		{ --First Sister Malklocs
			x = -5039,
			y = -2768, 
			spawnCount = 20, 
			radius = 250, 
			respawnTimer = 150,
			spawnTemplates = {
				"malkloc_plainswalker",
				"female_malkloc_plainswalker",
				"malkloc_bull",
			},
		}, 
		{ --Second Sister Village
			x = -3572,
			y = -6017, 
			spawnCount = 40, 
			radius = 75,
			respawnTimer = 300,
			spawnTemplates = {
				"wod_reanimated_slave",
				"wod_reanimated_slave",
			},
		}, 
		{ --Breeding Cave Spiderclan
			x = 308,
			y = -190, 
			spawnCount = 10, 
			radius = 40,
			respawnTimer = 300,
			spawnTemplates = {
				"wod_spiderclan_obfuscatrix"
			},
		}, 
		{ --Spiderclan Cave obfuscatrix spawns
			x = -1217,
			y = 6261, 
			spawnCount = 5, 
			radius = 40,
			respawnTimer = 300,
			spawnTemplates = {
				"wod_spiderclan_obfuscatrix"
			},
		}, 
	}
}

registerScreenPlay("witchesOfDathomirScreenplay", true)

local QuestManager = require("managers.quest.quest_manager")

--TODO: Spawn Scene Objects
--TODO: Spawn mobiles
--TODO: On logged in events
--TODO: Reward handling check if inventory is full (can it give an item with full inventory? Need testing)

function witchesOfDathomirScreenplay:start()
	if (isZoneEnabled("dathomir")) then
		self:spawnMobiles()
		self:spawnSceneObjects()
	end
end

function witchesOfDathomirScreenplay:onPlayerLoggedIn(pPlayer)
	if (pPlayer == nil) then
		return
	end
	
	wodPrologueScreenplay:onPlayerLoggedIn(pPlayer)
end

function witchesOfDathomirScreenplay:spawnMobiles()
	--Prologue
	spawnMobile("dathomir", "wod_omogg_rep", -1, 558, 6, 3073, 29, 0)
	spawnMobile("dathomir", "wod_rubina", -1, -3177, 21.8, 3184, 0, 0)
	spawnMobile("dathomir", "wod_outcast_01", -1, 866, 132, 1095, 162, 0)
	spawnMobile("dathomir", "wod_outcast_02", -1, -1000, 116.2, 862, -131, 0)
	spawnMobile("dathomir", "wod_outcast_03", -1, -2597, 131.3, 4952, 55, 0)
	spawnMobile("dathomir", "wod_outcast_04", -1, 1482, 131.7, 3515, 43, 0)
	spawnMobile("dathomir", "wod_outcast_05", -1, 1125, 135, -1022, -122, 0)
	spawnMobile("dathomir", "wod_outcast_06", -1, -856, 146.7, 2788, -144, 0)
	spawnMobile("dathomir", "wod_outcast_07", -1, -7121, 363.7, 2933, 111, 0)
	--Singing Mountain Clan
	spawnMobile("dathomir", "wod_telo", -1, -25.9, 2.0, -7.4, -153, 2665882)
	spawnMobile("dathomir", "wod_aujante_klee", -1, 3, 3, -5.2, 176, 2665884)
	spawnMobile("dathomir", "wod_azzenaj", -1, -12.0, 2.0, 14.7, 150, 2665880)
	spawnMobile("dathomir", "wod_zideera", -1, -12.3, 2, -8.6, -79, 2665882)
	spawnMobile("dathomir", "wod_vurlene", -1, -12, 3, -9.5, 72, 2665880)
	spawnMobile("dathomir", "wod_hazel", -1, -14.2, 1.9, -21, -20, 2665883)
	spawnMobile("dathomir", "wod_vhaunda", -1, -22.3, 2, 5.05, 5, 2665881)
	spawnMobile("dathomir", "wod_izaryx", -1, -12, 2, -4, -110, 2665882)
	spawnMobile("dathomir", "wod_sm_vendor", -1, -27.3, 2.0, 9.0, 66, 2665881)
	--Nightsister
	spawnMobile("dathomir", "wod_saik", -1, 3.2, 0.8, -1.8, -5, 189375)
	spawnMobile("dathomir", "wod_num", -1, -4001.0, 119.0, -62.4, -165, 0)
	spawnMobile("dathomir", "wod_leandra", -1, 7.7, 7.2, -34.2, 22, 189382)
	spawnMobile("dathomir", "wod_ns_vendor", -1, 0.2, 0.8, -54.7, -5, 189379)
	spawnMobile("dathomir", "wod_satra", -1, -13.6, 7.2, -14.4, -164, 189384)
	spawnMobile("dathomir", "wod_fath_hray", -1, -12, 7.2, -36.7, 13, 189384)
	spawnMobile("dathomir", "wod_diax", -1, -20.5, 7.2, -27.4, 140, 189384)
	spawnMobile("dathomir", "wod_kais", -1, 14.2, 7.2, -15, -92, 189382)
	spawnMobile("dathomir", "wod_gethzerion", -1, -2, 7.2, -1, -135, 189383)

	--Ghost guide abandoned village: -6850, -4897
	spawnMobile("dathomir", "wod_ghost_witch", -1, -6894.9, 461.8, -4853.8, 109, 0)
	
	--Other statics
	spawnMobile("dathomir", "wod_rescue_initiate", -1, 1.4, -46.1, -150.6, -11, 3695706)
	
	for i = 1, #self.spawnZones do
		for j = 1, #self.spawnZones[i].spawnCount do
			local spawnPoint = getSpawnPoint("dathomir", self.spawnZones[i].x, self.spawnZones[i].y, 0, self.spawnZones[i].radius)
			
			local n = getRandomNumber(1, #self.spawnZones[i].spawnTemplates)
			local pMobile = spawnMobile("dathomir", self.spawnZones[i].spawnTemplates[n], self.spawnZones[i].respawnTimer, spawnPoint[1], spawnPoint[2], spawnPoint[3], math.random(360), 0)
			AiAgent(pMobile):setAiTemplate("idlewander")
		end
	end
	
	--Cave of Mutations (Kyrisa): 1993, 42, 1823
	
	--Breeding Cave (Queen Mother): 308, 114, -190
	
	--Temple of the Stars: 5269, 121, 165
end

function witchesOfDathomirScreenplay:spawnSceneObjects()
	--Herb baskets
	spawnSceneObject("dathomir", "object/tangible/furniture/wod_themepark/pro_ns_herb_storage.iff", -3181, 22.1, 3185.1, 0, 0)
	spawnSceneObject("dathomir", "object/tangible/furniture/wod_themepark/pro_sm_herb_storage.iff", -3172, 25.5, 3182.4, 0, 0)
	spawnSceneObject("dathomir", "object/tangible/furniture/wod_themepark/ns_herb_storage.iff", -11.2, 7.2, -30.5, 189384, 0)
	spawnSceneObject("dathomir", "object/tangible/furniture/wod_themepark/herb_storage.iff", -29, 2, -3.4, 2665882, 0)

	--Repair altars
	spawnSceneObject("dathomir", "object/tangible/content/wod_crafting_alter_1.iff", -1150, 128, 1281, 0, 0)
	spawnSceneObject("dathomir", "object/tangible/content/wod_crafting_alter_2.iff", 1455, 135, 1387, 0, 0)
	spawnSceneObject("dathomir", "object/tangible/content/wod_crafting_alter_3.iff", -6703, 125, 3087, 0, 0)
	spawnSceneObject("dathomir", "object/tangible/content/wod_crafting_alter_4.iff", 2774, 15, 6466, 0, 0)
	
	--First sister altar
	spawnSceneObject("dathomir", "object/tangible/content/wod_first_sister_altar.iff", -4841, 135, -2938, 0, 0)
	
	--Second sister village: -3572, -6017
	spawnSceneObject("dathomir", "object/tangible/content/wod_second_sister_fire_1.iff", -3587.3, 87.9, -5996.8, 0, 0)
	spawnSceneObject("dathomir", "object/tangible/content/wod_second_sister_fire_2.iff", -3546.8, 87.2, -5993.8, 0, 0)
	spawnSceneObject("dathomir", "object/tangible/content/wod_second_sister_fire_3.iff", -3553.4, 94.6, -6053.3, 0, 0)
	spawnSceneObject("dathomir", "object/tangible/content/wod_second_sister_fire_4.iff", -3602.1, 99.9, -6051.4, 0, 0)

	--Trampled Veg (lost e01)
	local pPlant = spawnSceneObject("dathomir", "object/tangible/furniture/wod_themepark/wod_trampled_plant.iff", -1316, 17, 6163 , 0, 0)
	SceneObject(pPlant):setObjectMenuComponent("wodSpiderclanVegetationMenuComponent")

	--Temple of the Stars: 5269, 121, 165
	spawnSceneObject("dathomir", "object/tangible/furniture/wod_themepark/data_cache.iff", -9.8, -37.7, -25.1, 610001025, math.rad(90))
	spawnSceneObject("dathomir", "object/tangible/furniture/wod_themepark/data_cache.iff", -9.8, -37.3, -31.7, 610001025, math.rad(90))
	spawnSceneObject("dathomir", "object/tangible/furniture/wod_themepark/data_cache.iff", -9.8, -37.7, -25.1, 610001025, math.rad(-90))
	local pCache = spawnSceneObject("dathomir", "object/tangible/furniture/wod_themepark/data_cache.iff", -9.8, -37.3, -31.7, 610001025, math.rad(-90))
	SceneObject(pCache):setObjectMenuComponent("wodLeftBehindCacheMenuComponent")
end

function witchesOfDathomirScreenplay:handleReward(pPlayer, key)
	if (pPlayer == nil or key == nil) then
		return
	end

	local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")

	if (pInventory == nil) then
		return
	end

	local curCount = tonumber(readScreenPlayData(pPlayer, "wodThemepark:reward", key))

	if (curCount == nil or curCount == "") then
		curCount = 0
	end

	writeScreenPlayData(pPlayer, "wodThemepark:reward", key, curCount + 1)
	writeStringData("wodThemepark:rewardKey:" .. SceneObject(pPlayer):getObjectID(), key)

	local rewardKey = wodRewardManager[key]

	if (rewardKey.rewardOnce and curCount + 1 ~= 1) then
		return
	end

	if (curCount + 1 ~= 1 or curCount + 1 % rewardKey.rewardInterval == 0) then
		local pItem
		if (rewardKey.credits ~= nil and rewardKey.credits > 0) then
			CreatureObject(pPlayer):addCashCredits(rewardKey.credits)
		end		
		if (rewardKey.rewardType == "all") then
			for i = 1, #rewardKey.reward do
				pItem = giveItem(pInventory, rewardKey.reward[i], -1)
				
				if ((wodRewardManager[key].tokenCount ~= nil or not wodRewardManager[key].tokenCount == 0) and pItem ~= nil and string.match(SceneObject(pItem):getTemplateObjectPath(), "wod_token")) then
					TangibleObject(pItem):setUseCount(wodRewardManager[key].tokenCount)
				end
			end
		elseif (rewardKey.rewardType == "pick") then
			local sui = SuiListBox.new("witchesOfDathomirScreenplay", "pickRewardCallback")

			sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())
			sui.setTitle("Pick a Reward")

			local message = "Please select which item you want to buy."
			sui.setPrompt(message)

			for i = 1, #rewardKey.reward do
				sui.add(#rewardKey.reward[i][2], #rewardKey.reward[i][1])
			end

			sui.sendTo(pCreatureObject)
		else --Random option
			if (rewardKey.rewardType ~= "random") then
				CreatureObject(pPlayer):sendSystemMessage("A reward could not be found for prologue quest, key: '" .. key .. "', please contact an admin.")
				return
			end
			local n = getRandomNumber(1, #rewardKey.reward)
				pItem = giveItem(pInventory, rewardKey.reward[n], -1)
			
			if ((wodRewardManager[key].tokenCount ~= nil or not wodRewardManager[key].tokenCount == 0) and pItem ~= nil and string.match(SceneObject(pItem):getTemplateObjectPath(), "wod_token")) then
				TangibleObject(pItem):setUseCount(wodRewardManager[key].tokenCount)
			end
		end

		if (wodRewardManager[key].rewardRandomValuable ~= nil or not wodRewardManager[key].rewardRandomValuable == 0) then
			local n = getRandomNumber(1, 5)
			pItem = giveItem(pInventory, "object/tangible/content/wod_token_" .. n .. ".iff", -1)

			if (pItem ~= nil) then
				TangibleObject(pItem):setUseCount(wodRewardManager[key].rewardRandomValuable)
			end
		end	
		CreatureObject(pPlayer):sendSystemMessage("You have received a reward.")
	end
end

function witchesOfDathomirScreenplay:addToCollection(pPlayer, key)
	if (pPlayer == nil or key == nil) then
		return
	end
	
	local curCount = tonumber(readScreenPlayData(pPlayer, "wodThemepark:collection", key))
	
	if (curCount == nil or curCount == "") then
		curCount = 0
	end
	
	writeScreenPlayData(pPlayer, "wodThemepark:collection", key, curCount + 1)
	
	if (curCount + 1 == wodRewardManager[key].collectionRewardCount or not wodRewardManager[key].collectionRewardOnce) then
		if (curCount + 1 % wodRewardManager[key].collectionRewardCount == 0) then
			self:handleCollectionReward(pPlayer, key)
		end
	end	
end

function witchesOfDathomirScreenplay:handleCollectionReward(pPlayer, key)
	if (pPlayer == nil or key == nil) then
		return
	end

	local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")
	
	if (pInventory == nil) then
		return
	end
	
	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	if (pGhost == nil) then
		return
	end
	
	local key = "enemies" .. key
	local clan = ""
	
	if (string.match(string.lower(key), "sm")) then
		clan = "SM"
	elseif (string.match(string.lower(key), "ns")) then
		clan = "NS"
	end
	
	if (string.match(string.lower(key), "herbs")) then
		key = "herbs"
	elseif (string.match(string.lower(key), "wisdom")) then
		key = "wisdom"
	end
	
	local rewardKey = wodRewardManager[key]
	local rewardString = "collectionReward" .. clan

	local pItem
	if (rewardKey.collectionRewardType == "all") then
		for i = 1, #rewardKey.reward do
			pItem = giveItem(pInventory, rewardKey.rewardString[i], -1)
			if ((wodRewardManager[key].collectionRewardCount ~= nil or not wodRewardManager[key].collectionRewardCount == 0) and pItem ~= nil and string.match(SceneObject(pItem):getTemplateObjectPath(), "wod_token")) then
				TangibleObject(pItem):setUseCount(wodRewardManager[key].collectionRewardCount)
			end
		end
	elseif (rewardKey.collectionRewardType == "pick") then
		local sui = SuiListBox.new("witchesOfDathomirScreenplay", "pickRewardCallback")

		sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())
		sui.setTitle("Pick a Reward")

		local message = "Please select which item you want to buy."
		sui.setPrompt(message)

		for i = 1, #rewardKey.reward do
			sui.add(#rewardKey.reward[i][2], #rewardKey.reward[i][1])
		end

		sui.sendTo(pCreatureObject)
	else --Random option
		if (rewardKey.collectionRewardType ~= "random") then
			CreatureObject(pPlayer):sendSystemMessage("A reward could not be found for prologue quest, key: '" .. key .. "', please contact an admin.")
			return
		end
		local n = getRandomNumber(1, #rewardKey.rewardString)
		pItem = giveItem(pInventory, rewardKey.rewardString[n], -1)
		if ((wodRewardManager[key].collectionRewardCount ~= nil or not wodRewardManager[key].collectionRewardCount == 0) and pItem ~= nil and string.match(SceneObject(pItem):getTemplateObjectPath(), "wod_token")) then
			TangibleObject(pItem):setUseCount(wodRewardManager[key].collectionRewardCount)
		end
	end
	
	if (rewardKey[rewardString .. "BadgeToAward"] ~= nil and rewardKey[rewardString .. "BadgeToAward"] ~= "" or not PlayerObject(pGhost):hasBadge(rewardKey[rewardString .. "BadgeToAward"])) then
		PlayerObject(pGhost):awardBadge(rewardKey[rewardString .. "BadgeToAward"])
	end
	CreatureObject(pPlayer):sendSystemMessage("You have received a reward.")
end

function witchesOfDathomirScreenplay:pickRewardCallback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)
	local pPageData = LuaSuiBoxPage(pSui):getSuiPageData()

	if (pPageData == nil) then
		return
	end

	local suiPageData = LuaSuiPageData(pPageData)
	local reward = suiPageData:getStoredData(tostring(args))

	if (cancelPressed or args == nil or tonumber(args) < 0) then
		reward = suiPageData:getStoredData("1")
	end

	local pItem = giveItem(pInventory, reward, -1)

	local key = readStringData("wodThemepark:rewardKey:" .. SceneObject(pPlayer):getObjectID())
	if (wodRewardManager[key].tokenCount ~= nil or not wodRewardManager[key].tokenCount == 0 and string.match(SceneObject(pItem):getTemplateObjectPath(), "wod_token")) then
		TangibleObject(pItem):setUseCount(wodRewardManager[key].tokenCount)
	elseif (wodRewardManager[key].collectionRewardCount ~= nil or not wodRewardManager[key].collectionRewardCount == 0 and string.match(SceneObject(pItem):getTemplateObjectPath(), "wod_token")) then
		TangibleObject(pItem):setUseCount(wodRewardManager[key].collectionRewardCount)
	end
end

function witchesOfDathomirScreenplay:handleClanSwap(pPlayer, curClan)
	if (pPlayer == nil or curClan == nil) then
		return
	end
	
	if (curClan == "ns") then
		deleteScreenPlayData(pPlayer, "witchesOfDathomir", "storedQuestData:ns")
		for i = 250, 350 do
			if (QuestManager.hasCompletedQuest(pPlayer, i)) then
				writeScreenPlayData(pPlayer, "witchesOfDathomir", "storedQuestData:ns", readScreenPlayData(pPlayer, "witchesOfDathomir", "storedQuestData:ns") .. ";" .. i)
				QuestManager.resetQuest(pPlayer, i)
			elseif (QuestManager.hasActiveQuest(pPlayer, i)) then
				QuestManager.resetQuest(pPlayer, i)
			end
			local storedQuestsSM = HelperFuncs:splitString(readScreenPlayData(pPlayer, "witchesOfDathomir", "storedQuestData:sm"), ";")
			for i = 1, #storedQuestsSM do
				QuestManager.completeQuest(pPlayer, storedQuestsSM[i])
			end
		end
	elseif (curClan == "sm") then
		deleteScreenPlayData(pPlayer, "witchesOfDathomir", "storedQuestData:sm")
		for i = 351, 451 do
			if (QuestManager.hasCompletedQuest(pPlayer, i)) then
				writeScreenPlayData(pPlayer, "witchesOfDathomir", "storedQuestData:sm", readScreenPlayData(pPlayer, "witchesOfDathomir", "storedQuestData:sm") .. ";" .. i)
				QuestManager.resetQuest(pPlayer, i)
			elseif (QuestManager.hasActiveQuest(pPlayer, i)) then
				QuestManager.resetQuest(pPlayer, i)
			end
			local storedQuestsNS = HelperFuncs:splitString(readScreenPlayData(pPlayer, "witchesOfDathomir", "storedQuestData:ns"), ";")
			for i = 1, #storedQuestsNS do
				QuestManager.completeQuest(pPlayer, storedQuestsNS[i])
			end
		end
	end
end