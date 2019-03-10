wodHerbalPlants = ScreenPlay:new {
	spawnAreas = { --x coord, y coord, spawn radius, plant count
		{x = -3177, y = 3184, radius = 25, count = 10}, -- Outcast 1
		{x = -1000, y = 862, radius = 25, count = 10}, -- Outcast 2
		{x = -2597, y = 4952, radius = 25, count = 10}, -- Outcast 3
		{x = 1482, y = 3515, radius = 25, count = 10}, -- Outcast 4
		{x = 1125, y = -1022, radius = 25, count = 10}, -- Outcast 5
		{x = 866, y = 1095, radius = 25, count = 10}, -- Outcast 6
		{x = -7121, y = 2933, radius = 25, count = 10}, -- Outcast 7
		{x = -3177, y = 3184, radius = 25, count = 10}, -- Rubina
		{x = -2080, y = 3143, radius = 50, count = 20}, -- Sarlacc Area
		{x = -3946, y = -50, radius = 50, count = 20}, -- NS Stronghold
		{x = 678, y = 4079, radius = 50, count = 20}, -- Singing Mountain
		{x = -1219, y = 6262, radius = 35, count = 15}, -- Spider cave
	},
	respawnTimeSecs = 60,
	plantTemplates = {
		"object/tangible/furniture/wod_themepark/wod_themepark_herb_01.iff", -- Lesset plant
		"object/tangible/furniture/wod_themepark/wod_themepark_herb_02.iff", -- Ongmuel plant
		"object/tangible/furniture/wod_themepark/wod_themepark_herb_03.iff", -- Greybush plant
		"object/tangible/furniture/wod_themepark/wod_themepark_herb_04.iff", -- Redweed plant
		"object/tangible/furniture/wod_themepark/wod_themepark_herb_05.iff", -- Rinor plant
		"object/tangible/furniture/wod_themepark/wod_themepark_herb_06.iff", -- Remmy plant (filler plant)
		"object/tangible/furniture/wod_themepark/wod_themepark_herb_07.iff", -- Forest mushroom (filler plant)
		"object/tangible/furniture/wod_themepark/wod_trampled_plant.iff", -- Trampled plant (filler plant)
	},
	gatherMessage = {
		"@wod_theme_park/messages:herb_zip_bar_lesset", -- Gathering Lesset Leaves
		"@wod_theme_park/messages:herb_zip_bar_ongmuel", -- Gathering Ongmuel Leaves
		"@wod_theme_park/messages:herb_zip_bar_grey", -- Gathering Greybush Leaves
		"@wod_theme_park/messages:herb_zip_bar_red", -- Gathering Redweed Leaves
		"@wod_theme_park/messages:herb_zip_bar_rinor", -- Gathering Rinor Leaves
		"@wod_theme_park/messages:herb_zip_bar_remmy", -- Gathering Remmy Stalks
		"@wod_theme_park/messages:herb_zip_bar_shroom", -- Gathering Forest Mushroom Cap
		"@wod_theme_park/messages:herb_zip_bar", -- Gathering Herb
	},
	screenPlayDataKey = { --Corresponds with number of herbs to gather
		"lesset",
		"ongmuel",
		"grey",
		"red",
		"rinor",
	}
}

registerScreenPlay("wodHerbalPlants", true)

local QuestManager = require("managers.quest.quest_manager")

function wodHerbalPlants:start()
	if (isZoneEnabled("dathomir")) then
		self:spawnHerbalPlants()
	end
end

function wodHerbalPlants:spawnHerbalPlants()
	local pAnchor = getSceneObject(readData("wodThemepark:anchorID"))
	
	for i = 1, #self.spawnAreas do
		for j = 1, self.spawnAreas[i].count do
			local a = math.random() * 2 * math.pi
			local r = self.spawnAreas[i].radius * math.sqrt(math.random())

			local x = self.spawnAreas[i].x + r * math.cos(a)
			local y = self.spawnAreas[i].y + r * math.sin(a)
			local z = getTerrainHeight(pAnchor, x, y)
			
			local n = getRandomNumber(1, #self.plantTemplates)
			local pObject = spawnSceneObject("dathomir", self.plantTemplates[n], x, z, y, math.rad(math.random(360)), 0)
			writeData("wodThemepark:herbPlantLoc:" .. SceneObject(pObject):getObjectID(), i)
			writeData("wodThemepark:herbPlantTemplateNum:" .. SceneObject(pObject):getObjectID(), n)
		end
	end
end

function wodHerbalPlants:spawnHerbalPlants(..., loc)
	local pAnchor = getSceneObject(readData("wodThemepark:anchorID"))
	
	local a = math.random() * 2 * math.pi
	local r = self.spawnAreas[loc].radius * math.sqrt(math.random())

	local x = self.spawnAreas[loc].x + r * math.cos(a)
	local y = self.spawnAreas[loc].y + r * math.sin(a)
	local z = getTerrainHeight(pAnchor, x, y)
			
	local n = getRandomNumber(1, #self.plantTemplates)
	local pObject = spawnSceneObject("dathomir", self.plantTemplates[n], x, z, y, math.rad(math.random(360)), 0)
	writeData("wodThemepark:herbPlantLoc:" .. SceneObject(pObject):getObjectID(), loc)
	writeData("wodThemepark:herbPlantTemplateNum:" .. SceneObject(pObject):getObjectID(), n)
end

function wodHerbalPlants:gatherHerbalPlant(pPlayer, pPlant)
	if (pPlayer == nil or pPlant == nil) then
		return
	end
	
	local plantLoc = readData("wodThemepark:herbPlantLoc:" .. SceneObject(pPlant):getObjectID())
	local plantTemplateNum = readData("wodThemepark:herbPlantTemplateNum:" .. SceneObject(pObject):getObjectID())
	
	createEvent(self.respawnTimeSecs * 1000, "wodHerbalPlants", "respawnHerbalPlant", nil, plantLoc)
	
	if (plantTemplateNum >= 5) then --TODO: Magic Number
		self:collectQuestHerb(pPlayer, plantTemplateNum)
	elseif (plantTemplateNum == 8) then --TODO: Magic Number, trampled plant
		CreatureObject(pPlayer):sendSystemMessage("You didn't manage to get anything useful from the trampled plant.")
	else
		CreatureObject(pPlayer):sendSystemMessage("@wod_theme_park/messages:dont_need_herb")
		createEvent(5 * 1000, "wodHerbalPlants", "addBankCredits", pPlayer, "")
	end
	
	SceneObject(pSceneObject):destroyObjectFromWorld()
end

function wodHerbalPlants:collectQuestHerb(pPlayer, num)
	if (pPlayer == nil or plantTemplateNum == nil) then
		return
	end
	
	local spString, questName = ""
	if (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_NS_HERB_GATHERING)) then
		spString = "wodThemepark:ns:herbs"
		questName = "wod_ns_herb_gathering"
	elseif (QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.WOD_SM_HERB_GATHERING)) then
		spString = "wodThemepark:sm:herbs"
		questName = "wod_sm_herb_gathering"
	else
		spString = "wodThemepark:prologue:herbs"
		questName = "wod_prologue_herb_gathering"
	end
	
	local curHerbs = tonumber(readScreenPlayData(pPlayer, spString, self.screenPlayDataKey[tonumber(num)]))
	
	if (curHerbs == nil or curHerbs == "") then
		curHerbs == 0
	end
	
	writeScreenPlayData(pPlayer, spString, self.screenPlayDataKey[tonumber(num)], curHerbs + 1)
	
	if (curHerbs + 1 == 3) then --TODO: Magic number
		CreatureObject(pPlayer):sendSystemMessage("@wod_theme_park/" .. questName .. ":task06_task_display_string_" .. num)
		QuestManager.completeQuest(pPlayer, getPlayerQuestID(questName .. "_0" .. num))
		self:checkQuestStatus(pPlayer, questName)
	elseif (curHerbs + 1 > 3) then --TODO: Magic Number
		CreatureObject(pPlayer):sendSystemMessage("@wod_theme_park/messages:extra_credit_herbs")
		local bankCredits = CreatureObject(pPlayer):getBankCredits()
		createEvent(5 * 1000, "wodHerbalPlants", "addBankCredits", pPlayer, "")
	end
end

function wodHerbalPlants:checkQuestStatus(pPlayer, questName)
	if (pPlayer == nil or questName == nil) then
		return
	end
	
	for i = 1, 5 do -- TODO: Magic number
		if (not QuestManager.hasCompletedQuest(pPlayer, getPlayerQuestID(questName .. "_0" .. i))) then
			return
		end
	end
	
	QuestManager.completeQuest(pPlayer, getPlayerQuestID(questName .. "_06"))
	QuestManager.activateQuest(pPlayer, getPlayerQuestID(questName .. "_07"))
	wodRubinaReturn:start(pPlayer)
end

function wodHerbalPlants:addBankCredits(pPlayer)
	if (pPlayer == nil) then
		return
	end
	
	local bankCredits = CreatureObject(pPlayer):getBankCredits()
	CreatureObject(pPlayer):setBankCredits(bankCredits + 100) -- TODO: Magic number
	CreatureObject(pPlayer):sendSystemMessage("@wod_theme_park/messages:received_credits")
end