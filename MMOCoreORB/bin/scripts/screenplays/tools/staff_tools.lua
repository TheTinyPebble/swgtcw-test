-- Original code by SWGEmu.

StaffTools = {
	toolsMenu = {
		{ "Lookup CRC", "lookupCRC" },
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

function StaffTools.lookupCRC(pPlayer)
	StaffTools:sendCrcSui(pPlayer)
end

function StaffTools:sendCrcSui(pPlayer)
	if (pPlayer == nil) then
		return
	end
	
	local sui = SuiInputBox.new("StaffTools", "lookupCrcCallback")
	
	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())
	
	local suiBody = "Enter a CRC to lookup."
	sui.setTitle("Lookup CRC")
	sui.setPrompt(suiBody)
	
	sui.sendTo(pPlayer)
end

function StaffTools:lookupCrcCallback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)
	
	if (cancelPressed) then
		return
	end
	
	local crc = tonumber(args)
	
	if (crc) then
		local pCrc = getSceneObject(crc)
		if (pCrc == nil) then
			CreatureObject(pPlayer):sendSystemMessage("The object you are trying to look up does not exist.")
		end
		local crcName = SceneObject(pCrc):getCustomObjectName()
		CreatureObject(pPlayer):sendSystemMessage("The name of the object you looked up: " .. crcName)
	else
		CreatureObject(pPlayer):sendSystemMessage("You need to input a hex or a decimal number.")
	end
end

return StaffTools
