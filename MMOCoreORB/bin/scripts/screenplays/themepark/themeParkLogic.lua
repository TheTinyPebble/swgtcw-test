WAYPOINT_COLOR_PURPLE = 5
SIT = 1
STAND = 0
FACTIONIMPERIAL = 0xDB4ACC54
FACTIONREBEL = 0x16148850

ThemeParkLogic = ScreenPlay:new {
	numberOfActs = 1,
	npcMap = {},
	permissionMap = {},
	className = "ThemeParkLogic",
	screenPlayState = "theme_park_general",
	missionDescriptionStf = "",
	missionCompletionMessageStf = ""
}

function ThemeParkLogic:setData(npcMapNew, permissionMapNew, classNameNew, screenPlayStateNew, missionDescriptionStfNew)
	self.npcMap = npcMapNew
	self.permissionMap = permissionMapNew
	self.className = classNameNew
	self.screenPlayState = screenPlayStateNew
	self.missionDescriptionStf = missionDescriptionStfNew
	self.missionCompletionMessageStf = missionCompletionMessageStfNew
end

function ThemeParkLogic:start()
	self:spawnNpcs()
	self:permissionObservers()
end

function ThemeParkLogic:spawnNpcs()
	for i = 1, # self.npcMap do
		npcSpawnData = self.npcMap[i].spawnData
		if isZoneEnabled(npcSpawnData.planetName) then
			pNpc = spawnMobile(npcSpawnData.planetName, npcSpawnData.npcTemplate, 1, npcSpawnData.x, npcSpawnData.z, npcSpawnData.y, npcSpawnData.direction, npcSpawnData.cellID)
			if pNpc ~= nil and npcSpawnData.position == SIT then
				npc = LuaCreatureObject(pNpc)
				npc:setState(STATESITTINGONCHAIR)
			end
		end
	end
end

function ThemeParkLogic:permissionObservers()
	for i = 1, # self.permissionMap, 1 do
		local permission = self.permissionMap[i]
		local pRegion = getRegion(permission.planetName, permission.regionName)
		
		if pRegion ~= nil then
			createObserver(ENTEREDAREA, self.className, "cellPermissionsObserver", pRegion)
		end 
	end
end

function ThemeParkLogic:cellPermissionsObserver(pRegion, pCreature)
	if pRegion == nil or pCreature == nil then
		return 0
	end

	creatureSceneObject = LuaSceneObject(pCreature)
	
	if creatureSceneObject:isCreatureObject() then
		region = LuaSceneObject(pRegion)
		
		for i = 1, # self.permissionMap, 1 do
			if self.permissionMap[i].regionName == region:getObjectName() then
				self:setCellPermissions(self.permissionMap[i].permissions, pCreature)
			end
		end
	end	
	
	return 0
end

function ThemeParkLogic:setCellPermissions(permissions, pCreature)
	for i = 1, # permissions, 1 do
		self:updateCellPermissions(permissions[i].cells, self:hasPermission(permissions[i].conditions, pCreature), pCreature)
	end
end

function ThemeParkLogic:hasPermission(conditions, pCreature)
	local hasPermission = true
	for i = 1, # conditions, 1 do
		if conditions[i].permissionType == "faction" then
			if self:isInFaction(conditions[i].faction, pCreature) == false then
				hasPermission = false
			end
		elseif conditions[i].permissionType == "missionState" then
			if self:hasMissionState(conditions[i].mission, conditions[i].missionState, pCreature) == false then
				hasPermission = false
			end
		end
	end
	return hasPermission
end

function ThemeParkLogic:updateCellPermissions(cells, allowedEntry, pCreature)
	if pCreature == nil then
		return
	end
		
	for i = 1, # cells, 1 do
		local pCell = getSceneObject(cells[i])
		if pCell ~= nil then
			updateCellPermission(pCell, allowEntry, pCreature)
		end
	end
end

function ThemeParkLogic:isInFaction(faction, pCreature)
	if pCreature == nil then
		return false
	end
	
	local creature = LuaCreatureObject(pCreature)
	
	if creature:getFaction() == faction then
		return true
	else
		return false
	end
end

function ThemeParkLogic:hasMissionState(mission, missionState, pCreature)
	if pCreature == nil then
		return false
	end
	
	local npcNumber = self:getActiveNpcNumber(pCreature)
	
	if npcNumber > missionState then
		return true
	else
		return false
	end
end

function ThemeParkLogic:getNpcNumber(pNpc)
	if pNpc == nil then
		return 0
	end	
	npc = LuaCreatureObject(pNpc)
	
	x = npc:getPositionX()
	y = npc:getPositionY()
	z = npc:getPositionZ()
	
	for i = 1, # self.npcMap do
		npcData = self.npcMap[i].spawnData
		if (math.abs(x - npcData.x) < 0.1) and (math.abs(z - npcData.z) < 0.1) and (math.abs(y - npcData.y) < 0.1) then
			return self.npcMap[i].npcNumber
		end
	end
	
	return 1
end

function ThemeParkLogic:getNpcData(npcNumber)
	for i = 1, # self.npcMap do
		if npcNumber == self.npcMap[i].npcNumber then
			return self.npcMap[i]
		end
	end

	return nil
end

function ThemeParkLogic:getActiveNpcNumber(pConversingPlayer)
	if pConversingPlayer == nil then
		return -1
	end
	
	local creature = LuaCreatureObject(pConversingPlayer)
	
	local npcNumber = 1
	local activeNpcNumber = 1
	for i = 1, 10, 1 do
		if creature:hasScreenPlayState(npcNumber, self.screenPlayState) == 1 then
			activeNpcNumber = npcNumber * 2
		end
		npcNumber = npcNumber * 2
	end

	return activeNpcNumber
end

function ThemeParkLogic:activeNpc(pConversingPlayer, pConversingNpc)
	if pConversingPlayer == nil then
		return -1
	end
	
	local npcNumber = self:getNpcNumber(pConversingNpc)
	local activeNpcNumber = self:getActiveNpcNumber(pConversingPlayer)
	return npcNumber - activeNpcNumber
end

function ThemeParkLogic:getCurrentMissionNumber(npcNumber, pConversingPlayer)
	if pConversingPlayer == nil then
		return 0
	end
	local creature = LuaCreatureObject(pConversingPlayer)

	local npcData = self:getNpcData(npcNumber)
	if npcData ~= nil then
		local npcName = npcData.spawnData.npcTemplate	
		local numberOfMissionsTotal = table.getn(npcData.missions)
		
		local missionsCompleted = 0
		local stateToCheck = 1
		for i = 1, numberOfMissionsTotal, 1 do
			if creature:hasScreenPlayState(stateToCheck, self.screenPlayState .. "_mission_" .. npcName) == 1 then
				stateToCheck = stateToCheck * 2
				missionsCompleted = missionsCompleted + 1
			end
		end
		
		return missionsCompleted + 1
	else
		return 0
	end
end

function ThemeParkLogic:missionStatus(pConversingPlayer)
	if pConversingPlayer == nil then
		return 0
	end
	local creature = LuaCreatureObject(pConversingPlayer)
	
	return readData(creature:getObjectID() .. ":activeMission")
end

function ThemeParkLogic:getStfFile(npcNumber)	
	local npcData = self:getNpcData(npcNumber)

	return npcData.stfFile
end

function ThemeParkLogic:handleMissionAccept(npcNumber, missionNumber, pConversingPlayer)
	local mission = self:getMission(npcNumber, missionNumber)
	
	if mission.missionType == "deliver" then
		return self:handleDeliverMissionAccept(mission, pConversingPlayer, missionNumber)
	elseif mission.missionType == "escort" then
		return self:handleEscortMissionAccept(mission, pConversingPlayer, missionNumber)
	elseif mission.missionType == "retrieve" then
		return self:handleRetrieveMissionAccept(mission, pConversingPlayer, missionNumber)
	elseif mission.missionType == "assassinate" then
		return self:handleAssassinateMissionAccept(mission, pConversingPlayer, missionNumber)
	end
end

function ThemeParkLogic:getMission(npcNumber, missionNumber)
	local npcData = self:getNpcData(npcNumber)
	local missions = npcData.missions
	
	return missions[missionNumber]
end

function ThemeParkLogic:handleDeliverMissionAccept(mission, pConversingPlayer, missionNumber)
	if self:spawnMissionNpcs(mission, pConversingPlayer) == true then
		self:giveMissionItems(mission, pConversingPlayer)
		writeData(creature:getObjectID() .. ":activeMission", 1)
		return true
	else
		return false
	end
end

function ThemeParkLogic:handleRetrieveMissionAccept(mission, pConversingPlayer, missionNumber)
	if self:spawnMissionNpcs(mission, pConversingPlayer) == true then
		writeData(creature:getObjectID() .. ":activeMission", 0)
		return true
	else
		return false
	end
end

function ThemeParkLogic:handleEscortMissionAccept(mission, pConversingPlayer, missionNumber)
	if self:spawnMissionNpcs(mission, pConversingPlayer) == true then
		writeData(creature:getObjectID() .. ":activeMission", 1)
		return true
	else
		return false
	end
end

function ThemeParkLogic:handleAssassinateMissionAccept(mission, pConversingPlayer, missionNumber)
	if self:spawnMissionNpcs(mission, pConversingPlayer) == true then
		writeData(creature:getObjectID() .. ":activeMission", 1)
		writeData(creature:getObjectID() .. ":killedMissionNpcs", 0)
		return true
	else
		return false
	end
end

function ThemeParkLogic:spawnMissionNpcs(mission, pConversingPlayer)
	if pConversingPlayer == nil then
		return false
	end
	local creature = LuaCreatureObject(pConversingPlayer)
	local numberOfSpawns = table.getn(mission.primarySpawns) + table.getn(mission.secondarySpawns)

	local spawnPoints = self:getSpawnPoints(numberOfSpawns, creature:getWorldPositionX(), creature:getWorldPositionY(), pConversingPlayer)
	if table.getn(spawnPoints) ~= numberOfSpawns then
		return false
	end
	
	writeData(creature:getObjectID() .. ":missionSpawns", numberOfSpawns)
	
	mainNpcs = mission.primarySpawns
	for i = 1, table.getn(mission.primarySpawns), 1 do
		local pNpc = self:spawnNpc(mainNpcs[i], spawnPoints[i], pConversingPlayer, i)
		if pNpc ~= nil then
			if i == 1 then
				self:updateWaypoint(pConversingPlayer, mainNpcs[i].planetName, spawnPoints[i][1], spawnPoints[i][3])
			end
			if mission.missionType == "assassinate" then
				createObserver(OBJECTDESTRUCTION, self.className, "notifyDefeatedTarget", pNpc)
				createObserver(DAMAGERECEIVED, self.className, "notifyDamagedTarget", pNpc)
				local npc = LuaCreatureObject(pNpc)
				local creature = LuaCreatureObject(pConversingPlayer)
				writeData(npc:getObjectID() .. ":missionOwnerID", creature:getObjectID())
			end
		end
	end
	
	secondaryNpcs = mission.secondarySpawns
	for i = 1 + table.getn(mission.primarySpawns), numberOfSpawns, 1 do
		self:spawnNpc(secondaryNpcs[i - table.getn(mission.primarySpawns)], spawnPoints[i], pConversingPlayer, i)
	end
	
	return true
end

function ThemeParkLogic:notifyDefeatedTarget(pVictim, pAttacker)
	if pVictim == nil or pAttacker == nil then
		return 0
	end

	victim = LuaCreatureObject(pVictim)
	attacker = LuaCreatureObject(pAttacker)
	
	local victimID = victim:getObjectID()
	local attackerID = attacker:getObjectID()
	
	if self:killedByCorrectPlayer(victimID, attackerID) == true then
		local currentKillCount = readData(attackerID .. ":killedMissionNpcs") + 1
		writeData(attackerID .. ":killedMissionNpcs", currentKillCount)
		
		if currentKillCount == self:getMissionKillCount(pAttacker) then
			self:completeMission(pAttacker)
		end
	end
	
	return 1
end

function ThemeParkLogic:notifyDamagedTarget(pTarget, pAttacker, damage)
	if pTarget == nil or pAttacker == nil then
		return 1
	end
	local npcNumber = self:getActiveNpcNumber(pAttacker)
	local missionNumber = self:getCurrentMissionNumber(npcNumber, pAttacker)
	local stfFile = ThemeParkLogic:getStfFile(npcNumber)
	
	local attacker = LuaCreatureObject(pAttacker)
	local target = LuaCreatureObject(pTarget)
	
	local targetID = target:getObjectID()
	local attackerID = attacker:getObjectID()
	
	if self:killedByCorrectPlayer(victimID, attackerID) == true then
		spatialChat(pTarget, stfFile .. ":npc_breech_" .. missionNumber)
		return 1
	end
	
	return 0
end

function ThemeParkLogic:getMissionKillCount(pAttacker)	
	local npcNumber = self:getActiveNpcNumber(pAttacker)
	local missionNumber = self:getCurrentMissionNumber(npcNumber, pAttacker)
	local mission = self:getMission(npcNumber, missionNumber)
	
	if mission.missionType == "assassinate" then
		return table.getn(mission.primarySpawns)
	else
		return 0
	end
end

function ThemeParkLogic:killedByCorrectPlayer(victimID, attackerID)
	if readData(victimID .. ":missionOwnerID") == attackerID then
		return true
	else
		return false
	end
end

function ThemeParkLogic:spawnNpc(npcTemplate, position, pConversingPlayer, spawnNumber)
	if pConversingPlayer == nil then
		return nil
	end
	
	pNpc = spawnMobile(npcTemplate.planetName, npcTemplate.npcTemplate, 0, position[1], position[2], position[3], math.random(-180, 180), position[4])
	
	if pNpc ~= nil then
		npc = LuaCreatureObject(pNpc)
		npcName = self:getNpcName(npcTemplate.npcName)
		npc:setCustomObjectName(npcName)
		
		creature = LuaCreatureObject(pConversingPlayer)

		writeData(creature:getObjectID() .. ":missionSpawn:no" .. spawnNumber, npc:getObjectID())
	end
	return pNpc
end

function ThemeParkLogic:getNpcName(name)
	if name ~= "random" then
		return name
	end
	return "Random name"
end

function ThemeParkLogic:giveMissionItems(mission, pConversingPlayer)
	if pConversingPlayer == nil then
		return
	end

	creature = LuaCreatureObject(pConversingPlayer)
	itemsToGive = mission.itemSpawns
	
	pInventory = creature:getSlottedObject("inventory")
	if pInventory == nil then
		return
	end
	
	writeData(creature:getObjectID() .. ":missionItems", table.getn(itemsToGive))
	
	for i = 1, table.getn(itemsToGive), 1 do
		local pItem = giveItem(pInventory, itemsToGive[i].itemTemplate, -1)
		
		if (pItem ~= nil) then
			local item = LuaSceneObject(pItem)
			item:setCustomObjectName(itemsToGive[i].itemName)
			item:sendTo(pConversingPlayer)
			writeData(creature:getObjectID() .. ":missionItem:no" .. i, item:getObjectID())
		end
	end
end

function ThemeParkLogic:getMissionDescription(pConversingPlayer)
	local activeNpcNumber = self:getActiveNpcNumber(pConversingPlayer)
	local missionNumber = self:getCurrentMissionNumber(activeNpcNumber, pConversingPlayer)
	
	local npcNumber = 1
	while (npcNumber < activeNpcNumber) do
		missionNumber = missionNumber + table.getn(self:getNpcData(npcNumber).missions)
		npcNumber = npcNumber * 2
	end
	
	return self.missionDescriptionStf .. missionNumber
end

function ThemeParkLogic:updateWaypoint(pConversingPlayer, planetName, x, y)
	if pConversingPlayer ~= nil then
		local creature = LuaCreatureObject(pConversingPlayer)
		local pGhost = creature:getPlayerObject()
		if pGhost ~= nil then
			local ghost = LuaPlayerObject(pGhost)
			local waypointID = readData(creature:getObjectID() .. "themePark:waypointID")
			ghost:removeWaypoint(waypointID, true)

			waypointID = ghost:addWaypoint(planetName, self:getMissionDescription(pConversingPlayer), "", x, y, WAYPOINT_COLOR_PURPLE, true, true)
			writeData(creature:getObjectID() .. "themePark:waypointID", waypointID)
		end
	end
end

function ThemeParkLogic:getSpawnPoints(numberOfSpawns, x, y, pConversingPlayer)
	local spawnPoints = {}
	
	local firstSpawnPoint = getSpawnPoint(pConversingPlayer, x, y, 1000, 1500)
	if firstSpawnPoint ~= nil then
		table.insert(spawnPoints, firstSpawnPoint)
		for i = 2, numberOfSpawns, 1 do
			local nextSpawnPoint = getSpawnPoint(pConversingPlayer, firstSpawnPoint[1], firstSpawnPoint[3], 5, 15)
			if nextSpawnPoint ~= nil then
				table.insert(spawnPoints, nextSpawnPoint)
			end
		end
	end
	
	return spawnPoints
end

function ThemeParkLogic:hasRequiredItem(pConversingPlayer)
	if pConversingPlayer == nil then
		return false
	end

	creature = LuaCreatureObject(pConversingPlayer)
	
	pInventory = creature:getSlottedObject("inventory")
	if pInventory == nil then
		return false
	end

	local inventory = LuaSceneObject(pInventory)
	
	local itemID = readData(creature:getObjectID() .. ":missionItem:no1")
		
	local pItem = inventory:getContainerObjectById(itemID)
	
	if pItem == nil then
		return false
	end
	
	return true
end

function ThemeParkLogic:hasLootedRequiredItem(activeNpcNumber, pConversingPlayer)
	if pConversingPlayer == nil then
		return false
	end

	creature = LuaCreatureObject(pConversingPlayer)
	
	pInventory = creature:getSlottedObject("inventory")
	if pInventory == nil then
		return false
	end
	
	local inventory = LuaSceneObject(pInventory)

	local numberOfItems = inventory:getContainerObjectsSize()
	local requiredItem = self:getRequiredItem(activeNpcNumber, pConversingPlayer)
	
	for i = 1, numberOfItems, 1 do
		local pItem = inventory:getContainerObject(i)
		
		if pItem ~= nil then
			local item = LuaSceneObject(pItem)
			
			if requiredItem.itemTemplate == item:getTemplateObjectPath() and requiredItem.itemName == item:getCustomObjectName() then
				item:destroyObjectFromWorld()
				item:destroyObjectFromDatabase()
				return true
			end
		end
	end
	
	return false
end

function ThemeParkLogic:getRequiredItem(activeNpcNumber, pConversingPlayer)
	local missionNumber = self:getCurrentMissionNumber(activeNpcNumber, pConversingPlayer)
	local mission = self:getMission(activeNpcNumber, missionNumber)
	
	return mission.itemSpawns
end

function ThemeParkLogic:completeMission(pConversingPlayer)
	if pConversingPlayer == nil then
		return
	end
	
	local creature = LuaCreatureObject(pConversingPlayer)
	creature:sendSystemMessage(self.missionCompletionMessageStf)
	
	writeData(creature:getObjectID() .. ":activeMission", 2)
end

function ThemeParkLogic:handleMissionReward(pConversingPlayer)
	local npcNumber = self:getActiveNpcNumber(pConversingPlayer)
	local missionNumber = self:getCurrentMissionNumber(npcNumber, pConversingPlayer)
	local mission = self:getMission(npcNumber, missionNumber)
	rewards = mission.rewards
	
	for i = 1, # rewards, 1 do
		reward = rewards[i]
		if reward.rewardType == "credits" then
			self:giveCredits(pConversingPlayer, reward.amount)
		elseif reward.rewardType == "faction" then
			self:giveFaction(pConversingPlayer, reward.faction, reward.amount)
		elseif reward.rewardType == "loot" then
			self:giveLoot(pConversingPlayer, reward.lootGroup)
		elseif reward.rewardType == "badge" then
			self:giveBadge(pConversingPlayer, reward.badge)
		end
	end
end

function ThemeParkLogic:giveBadge(pConversingPlayer, badge)
	if pConversingPlayer == nil then
		return
	end
	
	local creature = LuaCreatureObject(pConversingPlayer)
	local pGhost = creature:getPlayerObject()
	
	if pGhost ~= nil then
		local ghost = LuaPlayerObject(pGhost)
		ghost:awardBadge(badge)
	end
end

function ThemeParkLogic:giveLoot(pConversingPlayer, lootGroup)
	if pConversingPlayer == nil then
		return
	end
	local creature = LuaCreatureObject(pConversingPlayer)
	
	pInventory = creature:getSlottedObject("inventory")
	if pInventory == nil then
		return
	end
	
	createLoot(pInventory, lootGroup, 0)
end

function ThemeParkLogic:giveCredits(pConversingPlayer, amount)
	if pConversingPlayer == nil then
		return
	end
	local creature = LuaCreatureObject(pConversingPlayer)
	
	creature:addCashCredits(amount, true)
	creature:sendSystemMessageWithDI("@theme_park/messages:theme_park_credits_pp", amount)
end

function ThemeParkLogic:giveFaction(pConversingPlayer, faction, points)
	if pConversingPlayer == nil then
		return
	end
	local creature = LuaCreatureObject(pConversingPlayer)
	local pPlayerObject = creature:getSlottedObject("ghost")
	local playerObject = LuaPlayerObject(pPlayerObject)
	
	playerObject:increaseFactionStanding(faction, points)
end

function ThemeParkLogic:giveItem(pConversingPlayer, itemList)
	if pConversingPlayer == nil then
		return
	end
	local creature = LuaCreatureObject(pConversingPlayer)
	
	pInventory = creature:getSlottedObject("inventory")
	if pInventory == nil then
		return
	end
	
	for currentItem = 1, # itemList, 1 do
		local thisItem = itemList[currentItem]
		local itemTemplate = thisItem.itemTemplate
		local numberOfItemsOfThisType = math.random(thisItem.minimum, thisItem.maximum)

		for i = 1, numberOfItemsOfThisType, 1 do
			local pItem = giveItem(pInventory, itemTemplate, -1)
			
			if (pItem ~= nil) then
				local item = LuaSceneObject(pItem)
				item:sendTo(pConversingPlayer)
			end
		end
	end
end

function ThemeParkLogic:cleanUpMission(pConversingPlayer)
	if pConversingPlayer == nil then
		return false
	end

	creature = LuaCreatureObject(pConversingPlayer)
	
	local numberOfSpawns = readData(creature:getObjectID() .. ":missionSpawns")
	for i = 1, numberOfSpawns, 1 do
		local objectID = readData(creature:getObjectID() .. ":missionSpawn:no" .. i)
		local pNpc = getSceneObject(objectID)
			
		if pNpc ~= nil then
			local npc = LuaSceneObject(pNpc)
			npc:destroyObjectFromWorld()
		end
	end	
end

function ThemeParkLogic:removeDeliverItem(pConversingPlayer)
	if pConversingPlayer == nil then
		return false
	end

	creature = LuaCreatureObject(pConversingPlayer)
			
	pInventory = creature:getSlottedObject("inventory")
	if pInventory == nil then
		return false
	end

	local inventory = LuaSceneObject(pInventory)
	
	local numberOfItems = readData(creature:getObjectID() .. ":missionItems")
	for i = 1, numberOfItems, 1 do
		local itemID = readData(creature:getObjectID() .. ":missionItem:no" .. i)
			
		local pItem = inventory:getContainerObjectById(itemID)
		if pItem ~= nil then
			local item = LuaSceneObject(pItem)
			item:destroyObjectFromWorld()
			item:destroyObjectFromDatabase()
		end
	end
end

function ThemeParkLogic:goToNextMission(pConversingPlayer)
	if pConversingPlayer == nil then
		return
	end
	
	local npcNumber = self:getActiveNpcNumber(pConversingPlayer)
	local missionNumber = self:getCurrentMissionNumber(npcNumber, pConversingPlayer)
	local npcData = self:getNpcData(npcNumber)
	local npcName = npcData.spawnData.npcTemplate	
	
	local creature = LuaCreatureObject(pConversingPlayer)
	writeData(creature:getObjectID() .. ":activeMission", 0)
	creature:setScreenPlayState(math.pow(2, missionNumber - 1), self.screenPlayState .. "_mission_" .. npcName)
	
	if missionNumber == table.getn(npcData.missions) then
		creature:setScreenPlayState(npcNumber, self.screenPlayState)
	end
end

function ThemeParkLogic:followPlayer(pConversingNpc, pConversingPlayer)
	if pConversingNpc ~= nil and pConversingPlayer ~= nil then
		npc = LuaAiAgent(pConversingNpc)
		npc:setFollowObject(pConversingPlayer)
	end
end

function ThemeParkLogic:getMissionType(activeNpcNumber, pConversingPlayer)
	if pConversingPlayer == nil then
		return
	end
	
	local npcNumber = self:getActiveNpcNumber(pConversingPlayer)
	local missionNumber = self:getCurrentMissionNumber(npcNumber, pConversingPlayer)
	local mission = self:getMission(npcNumber, missionNumber)
	
	return mission.missionType
end

function ThemeParkLogic:escortedNpcInTheSameCell(pConversingPlayer)
	if pConversingPlayer == nil then
		return false
	end

	creature = LuaCreatureObject(pConversingPlayer)
	playerSceneObject = LuaSceneObject(pConversingPlayer)
	local playerCellID = playerSceneObject:getParentID()

	local numberOfSpawns = readData(creature:getObjectID() .. ":missionSpawns")
	for i = 1, numberOfSpawns, 1 do
		local objectID = readData(creature:getObjectID() .. ":missionSpawn:no" .. i)
		local pNpc = getSceneObject(objectID)
			
		if pNpc ~= nil then
			local npc = LuaSceneObject(pNpc)
			npcCellID = npc:getParentID()

			if playerCellID ~= npcCellID then
				return false
			end
		else
			return false
		end
	end
	
	return true
end