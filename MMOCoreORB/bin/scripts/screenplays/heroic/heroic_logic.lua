HeroicLogic = ScreenPlay:new {
	scriptName = "HeroicLogic",
	heroicName = "axkva_min",
	heroicDisplay = "Axkva Mins Cave of Wonders",
	heroicTemplatePath = "object/building/heroic/axkva_min_lair.iff",
	
	lockoutTimer = 10 * 60 * 1000,
	groupSize = 5,
	enterLocation = {zone = "dungeon2", x = 28.9, z = 0, y = 0, cell = 1},
	exitLocation = {zone = "dathomir", x = 0, z = 0, y = 0},
	
	theater = {
	
	},
	
	mobiles = {
	
	},
}

registerScreenPlay("HeroicLogic", false)

function HeroicLogic:spawnDungeon(pPlayer)
	if (pPlayer == nil) then
		return
	end
	
	if (not self:checkGroupSize(pPlayer)) then
		CreatureObject(pPlayer):sendSystemMessage("There are too many group members.")
		return
	end
	
	if (not self:checkGroupCooldown(pPlayer)) then
		CreatureObject(pPlayer):sendSystemMessage("Someone in your group is locked out from this Heroic dungeon.")
		return
	end

	local heroicCount = readData("heroicDungeonCount")
	
	if (heroicCount == nil) then
		heroicCount = 0
	end
	
	local xPos = -7000 + (500 * (heroicCount % 28))
	local yPos = -7000 + (500 * (math.floor(heroicCount / 28)))
	
	local pBuilding = spawnSceneObject("dungeon2", self.heroicTemplatePath, xPos, 0, yPos, 0, 0)
	local buildingID = SceneObject(pBuilding):getObjectID()
	
	writeData("heroicDungeonID:" .. self.heroicName .. SceneObject(pPlayer):getObjectID(), buildingID)
	--writeData("heroicDungeon:" .. buildingID, readData("heroicDungeonCount"))

	for i = 1, BuildingObject(pBuilding):getTotalCellNumber(), 1 do
		SceneObject(pBuilding):_setObject(BuildingObject(pBuilding):getCell(i))
		writeData("heroicDungeon:" .. buildingID .. ":cell" .. i, SceneObject(pBuilding):getObjectID())
	end

	self:spawnTheater(pBuilding) --This is for the custom decorations
	self:spawnMobiles(pBuilding) --This is for regular mobiles
	self:spawnUniqueMobiles(pBuilding) --This is for bosses, or other mobiles with unique mechanics
	
	createEvent(1000, "HeroicLogic", "transportPlayer", pPlayer, "")

	if (CreatureObject(pPlayer):isGrouped()) then
		local groupSize = CreatureObject(pPlayer):getGroupSize()

		for i = 0, groupSize - 1, 1 do
			local pMember = CreatureObject(pPlayer):getGroupMember(i)
			if (pMember ~= nil and pMember ~= pPlayer and CreatureObject(pPlayer):isInRangeWithObject(pMember, 50) and not SceneObject(pMember):isAiAgent()) then
				self:sendTransportSui(pMember, pPlayer, pBuilding)
			end
		end
	end
	
	writeData("heroicDungeonCount", readData("heroicDungeonCount") + 1)
end

function HeroicLogic:checkGroupSize(pPlayer)
	if (pPlayer == nil) then
		return false
	end

	if (CreatureObject(pPlayer):isGrouped()) then
		if (CreatureObject(pPlayer):getGroupSize() > self.GroupSize) then
			return false
		end
	end
	
	return true
end

function HeroicLogic:checkGroupCooldown(pPlayer)
	if (pPlayer == nil) then
		return false
	end

	if (CreatureObject(pPlayer):isGrouped()) then
		for i = 0, CreatureObject(pPlayer):getGroupSize() - 1, 1 do
			local pMember = CreatureObject(pPlayer):getGroupMember(i)
			
			if (CreatureObject(pMember) == nil or not CreatureObject(pMember):checkCooldownRecovery(self.heroicName)) then
				return false
			end
		end
		return true
	else
		return CreatureObject(pPlayer):checkCooldownRecovery(self.heroicName)
	end
end

function HeroicLogic:spawnTheater(pBuilding)
	local buildingID = SceneObject(pBuilding):getObjectID()
	for i,v in ipairs(self.theater) do
		local cellID = readData("heroicDungeon:" .. buildingID .. ":cell" .. v[7])
		local pCreature = spawnMobile(self.planetName, v[1], v[2], v[3], v[4], v[5], v[6], cellID)
		--self:storeObjectsData(pBuilding, pCreature)
	end
end

function HeroicLogic:spawnMobiles(pBuilding)
	local buildingID = SceneObject(pBuilding):getObjectID()
	for i,v in ipairs(self.mobiles) do
		local cellID = readData("heroicDungeon:" .. buildingID .. ":cell" .. v[7])
		local pCreature = spawnMobile(self.planetName, v[1], v[2], v[3], v[4], v[5], v[6], cellID)
		--self:storeObjectsData(pBuilding, pCreature)
	end
end

function HeroicLogic:spawnUniqueMobiles(pBuilding)

end

function HeroicLogic:sendTransportSui(pPlayer, pLeader, pBuilding)
	if (pPlayer == nil or pBuilding == nil) then
		return
	end
	
	local sui = SuiMessageBox.new("HeroicLogic", "transportSuiCallback")
	sui.setTargetNetworkId(SceneObject(pBuilding):getObjectID())
	sui.setTitle(self.heroicDisplay)
	sui.setPrompt(CreatureObject(pLeader):getFirstName() .. " has opened for " .. self.heroicDisplay ..". Do you wish to join?")
	sui.setOkButtonText("Yes")
	sui.setCancelButtonText("No")

	local pageId = sui.sendTo(pPlayer)

	createEvent(30 * 1000, "HeroicLogic", "transportSuiCallback", pPlayer, pageId)
end

function HeroicLogic:transportSuiCallback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		deleteData(SceneObject(pPlayer):getObjectID() .. "corvetteID")
		return
	end

	createEvent(1000, "HeroicLogic", "transportPlayer", pPlayer, "")
end

function HeroicLogic:transportPlayer(pPlayer)
	if pPlayer == nil then
		return
	end

	local buildingID = readData("heroicDungeonID:" .. self.heroicName .. SceneObject(pPlayer):getObjectID())
	local pBuilding = getSceneObject(buildingID)
	
	if (pBuilding == nil) then
		return
	end
	
	local pCell = BuildingObject(pBuilding):getCell(self.enterLocation.cell)

	if (pCell == nil) then
		return
	end

	local cellID = SceneObject(pCell):getObjectID()
	SceneObject(pPlayer):switchZone(self.enterLocation.zone, self.enterLocation.x, self.enterLocation.z, self.enterLocation.y, cellID)
	CreatureObject(pPlayer):addCooldown(self.heroicName, self.lockoutTimer)
end

--[[For timed dungeons

function HeroicLogic:storeObjectsData(pBuilding, pObject)
	if (pObject == nil or pBuilding == nil) then
		return
	end
	local buildingID = SceneObject(pBuilding):getObjectID()
	local objectID = SceneObject(pObject):getObjectID()
	writeStringData("heroicDungeon:spawnedObjects:" .. buildingID, readStringData("heroicDungeon:spawnedObjects:" .. buildingID) .. "," .. objectID)
end

function HeroicLogic:cleanup(pBuilding)
	if (pBuilding == nil) then
		return
	end
	
	local buildingID = SceneObject(pBuilding):getObjectID()
	local playersToRemove = {}
	for i = 1, BuildingObject(pBuilding):getTotalCellNumber(), 1 do
		local pCell = getSceneObject(readData("heroicDungeon:" .. buildingID .. ":cell" .. i))
		for j = SceneObject(pCell):getContainerObjectsSize(), 1, -1 do
			local pObject = SceneObject(pCell):getContainerObject(j - 1)
			if SceneObject(pObject):isPlayerCreature() then
				table.insert(playersToRemove, pObject)
			end
		end
	end
	
	for i = 1, #playersToRemove, 1 do
		local pObject = playersToRemove[i]
		createEvent(1000, self.scriptName, "removePlayer", pObject,"")
	end
	createEvent(1000, self.scriptName, "cleanupDungeon", pBuilding, "")
end

function HeroicLogic:removePlayer(pPlayer)
	if (pPlayer == nil) then
		return 0
	end
	local nx = getRandomNumber(10)
	local ny = getRandomNumber(10)
	SceneObject(pPlayer):switchZone(self.planetName, 3255 + nx, 300, 5438 + ny, 0)
	return 0
end


function HeroicLogic:cleanupDungeon(pBuilding)
	local buildingID = SceneObject(pBuilding):getObjectID()
	local spawnedObjects = readStringData("heroicDungeon:spawnedObjects:" .. buildingID)
	local spawnedObjectsTable = HelperFuncs:splitString(spawnedObjects, ",")
	for i = 1, #spawnedObjectsTable, 1 do
		local pObject = getSceneObject(tonumber(spawnedObjectsTable[i]))
		if (pObject ~= nil) then
			if (SceneObject(pObject):isAiAgent()) then
				CreatureObject(pObject):setPvpStatusBitmask(0)
				forcePeace(pObject)
			end
			SceneObject(pObject):destroyObjectFromWorld()
		end	
	end

	SceneObject(pBuilding):destroyObjectFromWorld()

	deleteStringData("heroicDungeon:spawnedObjects:" .. buildingID)
end
]]