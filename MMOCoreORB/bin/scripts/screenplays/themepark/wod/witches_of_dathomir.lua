witchesOfDathomirScreenplay = ScreenPlay:new {

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
	
	witchesOfDathomirScreenplay:onPlayerLoggedIn(pPlayer)
	
end

function witchesOfDathomirScreenplay:spawnMobiles()
	spawnMobile("dathomir", "wod_omogg_rep", 1, 558, 6, 3073, 29, 0)
	spawnMobile("dathomir", "wod_rubina", 1, -3177, 21.8, 3184, 0, 0)
	spawnMobile("dathomir", "wod_outcast_01", 1, 866, 132, 1095, 162, 0)
	spawnMobile("dathomir", "wod_outcast_02", 1, -1000, 116.2, 862, -131, 0)
	spawnMobile("dathomir", "wod_outcast_03", 1, -2597, 131.3, 4952, 55, 0)
	spawnMobile("dathomir", "wod_outcast_04", 1, 1482, 131.7, 3515, 43, 0)
	spawnMobile("dathomir", "wod_outcast_05", 1, 1125, 135, -1022, -122, 0)
	spawnMobile("dathomir", "wod_outcast_06", 1, -856, 146.7, 2788, -144, 0)
	spawnMobile("dathomir", "wod_outcast_07", 1, -7121, 363.7, 2933, 111, 0)
end

function witchesOfDathomirScreenplay:spawnSceneObjects()

end

function witchesOfDathomirScreenplay:handleReward(pPlayer, key)
	if (pPlayer == nil or key == nil) then
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
		local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")
		local pItem
		if (rewardKey.credits ~= nil and rewardKey.credits > 0) then
			CreatureObject(pPlayer):addCashCredits(rewardKey.credits)
		end		
		if (rewardKey.rewardType == "all") then
			for i = 1, #rewardKey.reward do
				pItem = giveItem(pInventory, rewardKey.reward[i], -1)
				
				if ((wodRewardManager[key].rewardCount ~= nil or not wodRewardManager[key].rewardCount == 0) and (pItem ~= nil)) then
					TangibleObject(pItem):setUseCount(wodRewardManager[key].rewardCount)
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
			
			if ((wodRewardManager[key].rewardCount ~= nil or not wodRewardManager[key].rewardCount == 0) and (pItem ~= nil)) then
				TangibleObject(pItem):setUseCount(wodRewardManager[key].rewardCount)
			end
		end

		if (wodRewardManager[key].rewardRandomValuable ~= nil or not wodRewardManager[key].rewardRandomValuable == 0) then
			local n = getRandomNumber(1, 5)
			pItem = giveItem(pInventory, "object/tangible/content/wod_token_" .. n .. ".iff", -1)
			TangibleObject(pItem):setUseCount(wodRewardManager[key].rewardRandomValuable)
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
	
	local pGhost = CreatureObject(pPlayer):getPlayerObject()

	if (pGhost == nil) then
		return
	end
	
	local key = "enemies" .. key
	local clan = ""
	
	if (string.match(key, "herbs")) then
		key = "herbs"
	elseif (string.match(key, "wisdom")) then
		key = "wisdom"
	end
	
	if (string.match(key, "SM")) then
		clan = "SM"
	elseif (string.match(key, "NS")) then
		clan = "NS"
	end
	
	local rewardKey = wodRewardManager[key]
	local rewardString = "collectionReward" .. clan

	local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")
	local pItem
	if (rewardKey.collectionRewardType == "all") then
		for i = 1, #rewardKey.reward do
			pItem = giveItem(pInventory, rewardKey.rewardString[i], -1)
			if ((wodRewardManager[key].collectionRewardCount ~= nil or not wodRewardManager[key].collectionRewardCount == 0) and (pItem ~= nil)) then
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
		if ((wodRewardManager[key].collectionRewardCount ~= nil or not wodRewardManager[key].collectionRewardCount == 0) and (pItem ~= nil)) then
			TangibleObject(pItem):setUseCount(wodRewardManager[key].collectionRewardCount)
		end
	end
	
	if (rewardKey[rewardString .. "BadgeToAward"] ~= nil and rewardKey[rewardString .. "BadgeToAward"] ~= "" or PlayerObject(pGhost):hasBadge(rewardKey[rewardString .. "BadgeToAward"])) then
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
	if (wodRewardManager[key].rewardCount ~= nil or not wodRewardManager[key].rewardCount == 0) then
		TangibleObject(pItem):setUseCount(wodRewardManager[key].rewardCount)
	elseif (wodRewardManager[key].collectionRewardCount ~= nil or not wodRewardManager[key].collectionRewardCount == 0) then
		TangibleObject(pItem):setUseCount(wodRewardManager[key].collectionRewardCount)
	end
end