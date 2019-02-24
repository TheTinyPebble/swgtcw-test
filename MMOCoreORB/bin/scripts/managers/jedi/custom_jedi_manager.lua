JediManager = require("managers.jedi.jedi_manager")
local Logger = require("utils.logger")
local QuestManager = require("managers.quest.quest_manager")

jediManagerName = "CustomJediManager"

CustomJediManager = JediManager:new {
	screenplayName = jediManagerName,
	jediManagerName = jediManagerName,
	jediProgressionType = CUSTOMJEDIPROGRESSION ,
	startingEvent = nil,
}

-- Handling of the useItem event.
-- @param pSceneObject pointer to the item object.
-- @param itemType the type of item that is used.
-- @param pPlayer pointer to the creature object that used the item.
function CustomJediManager:useItem(pSceneObject, itemType, pPlayer)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	Logger:log("useItem called with item type " .. itemType, LT_INFO)
	if itemType == ITEMHOLOCRON then
		CustomJediManagerHolocron.useHolocron(pSceneObject, pPlayer)
	end
	if itemType == ITEMWAYPOINTDATAPAD then
		SithShadowEncounter:useWaypointDatapad(pSceneObject, pPlayer)
	end
	if itemType == ITEMTHEATERDATAPAD then
		SithShadowIntroTheater:useTheaterDatapad(pSceneObject, pPlayer)
	end
end

-- Handling of the checkForceStatus command.
-- @param pPlayer pointer to the creature object of the player who performed the command
function CustomJediManager:checkForceStatusCommand(pPlayer)
	if (pPlayer == nil) then
		return
	end

	CustomGlowing:checkForceStatusCommand(pPlayer)
end

-- Handling of the onPlayerLoggedIn event. The progression of the player will be checked and observers will be registered.
-- @param pPlayer pointer to the creature object of the player who logged in.
function CustomJediManager:onPlayerLoggedIn(pPlayer)
	if (pPlayer == nil) then
		return
	end
	
	CustomGlowing:onPlayerLoggedIn(pPlayer)
	
	if (CustomUnlock:isOnIntro(pPlayer)) then
		CustomUnlock:onLoggedIn(pPlayer)
	end

	--CustomJediTrials:onPlayerLoggedIn(pPlayer)
end

function CustomJediManager:onPlayerLoggedOut(pPlayer)
	if (pPlayer == nil) then
		return
	end
	
	if (CustomUnlock:isOnIntro(pPlayer)) then
		CustomUnlock:onLoggedOut(pPlayer)
	end
end

registerScreenPlay("CustomJediManager", true)

return CustomJediManager
