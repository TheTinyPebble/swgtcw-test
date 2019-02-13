StaffTools = {
	toolsMenu = {
		{ "Shuttle Dropoff", "openShuttleConfig" },
		{ "Firework Event", "openFireworkConfig" },
		{ "Elite Spawns Satus", "openEliteSpawnStatus" },
		{ "Test ODST", "openOdstConfig" },
		{ "Test Versafunction", "testVersaFunction"},
	}
}

function StaffTools:openToolsSUI(pCreature)
	if (pCreature == nil) then
		return
	end

	self:openSUI(pCreature)
end

function StaffTools:openSUI(pCreature)
	local sui = SuiListBox.new("StaffTools", "mainSuiCallback")

	sui.setTargetNetworkId(SceneObject(pCreature):getObjectID())

	sui.setTitle("Staff Tools")
	sui.setPrompt("Select a tool below to open it.")

	for i = 1, #self.toolsMenu, 1 do
		sui.add(self.toolsMenu[i][1], "")
	end

	sui.sendTo(pCreature)
end

function StaffTools:mainSuiCallback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	local chosenTool = args + 1

	self[self.toolsMenu[chosenTool][2]](pPlayer)
end

function StaffTools.openShuttleConfig(pPlayer)
	ShuttleDropoff:showMainUI(pPlayer)
end

function StaffTools.openFireworkConfig(pPlayer)
	FireworkEvent:showMainUI(pPlayer)
end

function StaffTools.openEliteSpawnStatus(pPlayer)
	eliteSpawns:statusSui(pPlayer)
end

function StaffTools.openOdstConfig(pPlayer)
	callODST:showMainUI(pPlayer)
end

function StaffTools.testVersaFunction(pPlayer)
	writeScreenPlayData(pPlayer, "vendorToken", "event_token", tonumber(readScreenPlayData(pPlayer, "vendorToken", "event_token")) + 5)
	writeScreenPlayData(pPlayer, "vendorToken", "test_token", tonumber(readScreenPlayData(pPlayer, "vendorToken", "test_token")) + 1)
end

function StaffTools:suiShuttleDropoffCallback(pPlayer, pSui, eventIndex, args)
end

return StaffTools
