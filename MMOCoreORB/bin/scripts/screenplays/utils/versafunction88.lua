Versafunction88ScreenPlayString = "versafunction88"
Versafunction88ScreenPlayStates = { --Used to select what to display on /examine.
	{1, "tokenDisplay", "Display Tokens"},
	{2, "factionControlDisplay", "Display Faction Control"},
}

Versafunction88FactionZones = {
	"corellia",
	"naboo",
	"tatooine",
}

Versafunction88TokenData = {
		{"vendorToken", "event_token"},
		{"vendorToken", "test_token"},
	}

Versafunction88AttributeListComponent = {}

function Versafunction88AttributeListComponent:fillAttributeList(pALM, pCreature, pObject)
	local ALM = LuaAttributeListMessage(pALM)
	
	for i = 1, #Versafunction88ScreenPlayStates do
		if (CreatureObject(pCreature):hasScreenPlayState(Versafunction88ScreenPlayStates[i][1], Versafunction88ScreenPlayString)) then
			self[Versafunction88ScreenPlayStates[i][2]](pALM, pCreature, pObject)
			return
		end
	end
	
	ALM:insertNewAttribute("Please select a display to show information on your Versafunction88 Datapad.", "versafunction_no_display") -- the 2nd value has to derive from obj_attr_n.stf
end

function Versafunction88AttributeListComponent.tokenDisplay(pALM, pCreature, pObject)
	local ALM = LuaAttributeListMessage(pALM)
	
	for i = 1, #Versafunction88TokenData do
		local tokenData = tonumber(readScreenPlayData(pCreature, Versafunction88TokenData[i][1], Versafunction88TokenData[i][2]))
		if (tokenData == "" or tokenData == nil) then
			tokenData = 0
		end
		
		ALM:insertNewAttribute(tokenData, "versafunction_token" .. i)
	end
end

function Versafunction88AttributeListComponent.factionControlDisplay(pALM, pCreature, pObject)
	local ALM = LuaAttributeListMessage(pALM)
	
	local controllingFaction = ""
	for i = 1, #Versafunction88FactionZones do
		controllingFaction = getControllingFaction(Versafunction88FactionZones[i])
		
		if (controllingFaction == FACTIONNEUTRAL) then
			controllingFaction = "Neutral"
		elseif (controllingFaction == FACTIONIMPERIAL) then
			controllingFaction = "Republic"
		elseif (controllingFaction  == FACTIONREBEL) then
			controllingFaction  = "CIS"
		end
		
		ALM:insertNewAttribute(controllingFaction, Versafunction88FactionZones[i])
	end
end

Versafunction88MenuComponent = {}

function Versafunction88MenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	
	menuResponse:addRadialMenuItem(120, 3, "Set Display")
	menuResponse:addRadialMenuItem(121, 3, "Lot Information")
end

function Versafunction88MenuComponent:handleObjectMenuSelect(pObject, pPlayer, selectedID)
	if (pPlayer == nil or pObject == nil) then
		return 0
	end
	
	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	
	if (pGhost == nil) then
		return 0
	end
	
	if (selectedID == 120) then
		local sui = SuiListBox.new("Versafunction88MenuComponent", "displaySuiCallback")
		
		sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())
		
		sui.setTitle("Select Display")
		sui.setPrompt("Select which information to display on your Versafunction88 Datapad.")
		
		for i = 1, #Versafunction88ScreenPlayStates do
			sui.add(Versafunction88ScreenPlayStates[i][3], "")
		end
		
		sui.sendTo(pPlayer)
	end
	if (selectedID == 121) then
		local sui = SuiMessageBox.new("Versafunction88MenuComponent", "lotInformationCallback")
		sui.setTitle("Lot Information")
		sui.setOkButtonText("Close")
		sui.hideCancelButton()
		sui.setProperty("", "Size", "250,350")
		local prompt = ""
		
		for i = 1, PlayerObject(pGhost):getTotalOwnedStructureCount() do
			local pStructure = getSceneObject(PlayerObject(pGhost):getOwnedStructure(i - 1))
			
			prompt = prompt .. "Structure " .. i .. ": "
			
			if (pStructure == nil) then
				prompt = prompt .. "empty structure\n\n"
			else
				local structure = LuaSceneObject(pStructure)
			
				prompt = prompt .. structure:getCustomObjectName() .. "\n"
				prompt = prompt .. "Type: " .. structure:getObjectName() .. "\n"
				prompt = prompt .. "Location - Planet: " .. structure:getZoneName():gsub("^%l", string.upper) .. ", X: " .. math.floor(structure:getWorldPositionX()) .. ", Y: " .. math.floor(structure:getWorldPositionY()) .. "\n\n"
			end
		end
		sui.setPrompt(prompt)
		sui.sendTo(pPlayer)
	end
end

function Versafunction88MenuComponent:displaySuiCallback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)
	
	if (cancelPressed) then
		return
	end
	
	local chosenDisplay = args + 1
	
	for i = 1, #Versafunction88ScreenPlayStates do
		CreatureObject(pPlayer):removeScreenPlayState(Versafunction88ScreenPlayStates[i][1], Versafunction88ScreenPlayString)
	end
	
	CreatureObject(pPlayer):setScreenPlayState(Versafunction88ScreenPlayStates[chosenDisplay][1], Versafunction88ScreenPlayString)
end

function Versafunction88MenuComponent:lotInformationCallback(pPlayer, pSui, eventIndex)
end
