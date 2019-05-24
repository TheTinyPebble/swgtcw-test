-- Original code by SWGEmu.

EventTools = {
	toolsMenu = {
		{ "Shuttle Dropoff", "openShuttleConfig" }, --SWGEmu Code
		{ "Firework Event", "openFireworkConfig" }, --SWGEmu Code
		{ "Elite Spawns Satus", "openEliteSpawnStatus" },
		--{ "Test ODST", "openOdstConfig" },
		{ "Test Event Spawn Manager", "testESM" },
		{ "Spawn Buildings + Teleport (For Test)", "spawnBuildings" },
	}
}

function EventTools:openToolsSUI(pCreature)
	if (pCreature == nil) then
		return
	end

	self:openSUI(pCreature)
end

function EventTools:openSUI(pCreature)
	local sui = SuiListBox.new("EventTools", "mainSuiCallback")

	sui.setTargetNetworkId(SceneObject(pCreature):getObjectID())

	sui.setTitle("Event Tools")
	sui.setPrompt("Select a tool below to open it.")

	for i = 1, #self.toolsMenu, 1 do
		sui.add(self.toolsMenu[i][1], "")
	end

	sui.sendTo(pCreature)
end

function EventTools:mainSuiCallback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	local chosenTool = args + 1

	self[self.toolsMenu[chosenTool][2]](pPlayer)
end

function EventTools.openShuttleConfig(pPlayer)
	ShuttleDropoff:showMainUI(pPlayer)
end

function EventTools.openFireworkConfig(pPlayer)
	FireworkEvent:showMainUI(pPlayer)
end

function EventTools.openEliteSpawnStatus(pPlayer)
	eliteSpawns:statusSui(pPlayer)
end

function EventTools.openOdstConfig(pPlayer)
	callODST:showMainUI(pPlayer)
end

function EventTools.testESM(pPlayer)
	eventSpawnManager:openSUI(pPlayer)
end

function EventTools:suiShuttleDropoffCallback(pPlayer, pSui, eventIndex, args)
end

function EventTools.spawnBuildings(pPlayer)
	local sui = SuiListBox.new("EventTools", "spawnBuildingsCallBack")

	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())

	sui.setTitle("Building Spawner (For Test)")
	sui.setPrompt("Select which building to spawn, you'll be teleported inside.")

	sui.add("Tomb of Exar Kun", "")
	sui.add("Axkva Min Lair", "")
	sui.add("Space Station", "")

	sui.sendTo(pPlayer)
end

function EventTools:spawnBuildingsCallBack(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	local arg = args + 1
	
	local zoneName = SceneObject(pPlayer):getZoneName()
	local posX = SceneObject(pPlayer):getWorldPositionX()
	local posZ = SceneObject(pPlayer):getWorldPositionZ()
	local posY = SceneObject(pPlayer):getWorldPositionY()
	local pBuilding, cellX, cellZ, cellY
	
	if (arg == 1) then
		pBuilding = spawnSceneObject(zoneName, "object/building/heroic/exar_kun_tomb.iff", posX, posZ, posY, 0, 0 )
		cellX = -11.6
		cellZ = 0
		cellY = -120.8
	elseif (arg == 2) then
		pBuilding = spawnSceneObject(zoneName, "object/building/heroic/axkva_min_lair.iff", posX, posZ, posY, 0, 0 )
		cellX = 28.9
		cellZ = 0
		cellY = 0
	elseif (arg == 3) then
		pBuilding = spawnSceneObject(zoneName, "object/building/general/npe_space_station.iff", posX, posZ, posY, 0, 0 )
		cellX = 0
		cellZ = 0
		cellY = 0
	end

	if (pBuilding ~= nil) then
		local pCell = BuildingObject(pBuilding):getCell(1)

		if (pCell == nil) then
			return
		end

		local cellID = SceneObject(pCell):getObjectID()
		SceneObject(pPlayer):switchZone(zoneName, cellX, cellZ, cellY, cellID)
		CreatureObject(pPlayer):sendSystemMessage(cellID)
	end
end

return EventTools
