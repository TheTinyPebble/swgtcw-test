local ObjectManager = require("managers.object.object_manager")
local http = require("socket.http")

--Holonews system by Empire in Flames - Released October 2018

--Pulls text files from website for use in-game on Newsnet terminals
--Easy-to-update in-game information - does not require server reboot, since the query happens as player looks for information
--Allows non-server admin to update terminals as necessary

NewsnetMenuComponent = { }


--Radial menu on the Newsnet Object - "20" is the default "use" on the terminal, so if there is no "20" filled in here, "use" will exist.
--It is possible to overwrite the "Examine" option, but selecting that option will still bring up the "Examine" window, so it's best to leave it alone.

function NewsnetMenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	
	
	menuResponse:addRadialMenuItem(20, 3, "Patch Notes")
	--menuResponse:addRadialMenuItem(40, 3, "Upcoming Events")
	menuResponse:addRadialMenuItem(80, 1, "War News")
	menuResponse:addRadialMenuItemToRadialID(80, 81, 3, "Headlines") -- Read Headline
	--menuResponse:addRadialMenuItemToRadialID(80, 82, 3, "War Correspondent")
	--menuResponse:addRadialMenuItem(100, 3, "Around the Galaxy")
end


--Code to handle script response based on selection
function NewsnetMenuComponent:handleObjectMenuSelect(pObject, pPlayer, selectedID)
	--if something funky happens, nil out
	if (pPlayer == nil or pObject == nil) then
		return 0
	end
	
	local body, title = ""
	
	local sui = SuiMessageBox.new("NewsnetMenuComponent", "notifyOkPressed")
	
	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())
	
	sui.setOkButtonText("Close")
	sui.hideCancelButton()
	sui.setWindowType(NEWSNET_INFO)
	
	--Patch Notes text
	if (selectedID == 20) then
		body = http.request("http://swgtcw.us/launcher/patchnotes.txt")
		title = "Patch Notes"

		local pGhost = CreatureObject(pPlayer):getPlayerObject()

		if (pGhost ~= nil) then
			PlayerObject(pGhost):closeSuiWindowType(NEWSNET_INFO)
		end
		
		sui.setTitle(title)
		sui.setPrompt(body)
		sui.sendTo(pPlayer)
	end
	
	--Upcoming Events text
	if (selectedID == 40) then
		body = http.request("http://swgtcw.us/launcher/patchnotes.txt")
		title = "Upcoming Events"
		local pGhost = CreatureObject(pPlayer):getPlayerObject()

		if (pGhost ~= nil) then
			PlayerObject(pGhost):closeSuiWindowType(NEWSNET_INFO)
		end
		
		sui.setTitle(title)
		sui.setPrompt(body)
		sui.sendTo(pPlayer)
	end

	--GCW News text on drop-down radial
	--Original GCW Headlines code is selectedID 81; 80 is the radial header for GCW News
	if (selectedID == 81 or selectedID == 80) then
		-- Original SWGEmu Newsnet code for GCW headlines
		local planet = SceneObject(pObject):getZoneName()

		if (planet == "") then
			return 0
		end

		local controllingFaction = getControllingFaction(planet)

		if (planet ~= "naboo" and planet ~= "corellia") then
			planet = "general"
		end

		local headline

		if (controllingFaction == FACTIONREBEL) then -- Rebels winning
			headline = "headline_" .. planet .. "_rebel_winning_" .. getRandomNumber(1,4)
		elseif (controllingFaction == FACTIONIMPERIAL) then
			headline = "headline_" .. planet .. "_rebel_losing_" .. getRandomNumber(1,4)
		else
			headline = "headline_" .. planet .. "_equal"
		end

		-- Close open Newsnet SUIs and send the player a new one.
		local pGhost = CreatureObject(pPlayer):getPlayerObject()

		if (pGhost ~= nil) then
			PlayerObject(pGhost):closeSuiWindowType(NEWSNET_INFO)
		end
		
		title = "@gcw:" .. planet .. "_newsnet_name"
		body = "@gcw:" .. headline
		--end original SWGEmu Newsnet script
		
		sui.setTitle(title)
		sui.setPrompt(body)
		sui.sendTo(pPlayer)
	end

	--GCW Correspondence text
	if (selectedID == 82) then
		body = http.request("http://swgtcw.us/launcher/patchnotes.txt")
		title = "Report From The Front"
		
		local pGhost = CreatureObject(pPlayer):getPlayerObject()

		if (pGhost ~= nil) then
			PlayerObject(pGhost):closeSuiWindowType(NEWSNET_INFO)
		end
		
		sui.setTitle(title)
		sui.setPrompt(body)
		sui.sendTo(pPlayer)
	end

	if (selectedID == 100) then
		body = http.request("http://swgtcw.us/launcher/patchnotes.txt")
		title = "Around the Galaxy"
		
		local pGhost = CreatureObject(pPlayer):getPlayerObject()

		if (pGhost ~= nil) then
			PlayerObject(pGhost):closeSuiWindowType(NEWSNET_INFO)
		end
		
		sui.setTitle(title)
		sui.setPrompt(body)
		sui.sendTo(pPlayer)
	end
	
	return 0
end

--Necessary function for when players press "okay" at the end. If you'd like something to happen if players press the okay, do it here; otherwise, leave it as an empty function.
function NewsnetMenuComponent:notifyOkPressed()
end
