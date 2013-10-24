local realCreateEvent
local realGetCityRegionAt
local realGetSceneObject
local realGetSpawnPoint
local realReadData
local realSpawnMobile
local realWriteData

local realLuaAiAgent
local realLuaCityRegion
local realLuaCreatureObject
local realLuaPlayerObject
local realLuaSceneObject

local DirectorManagerMocks = { }

DirectorManagerMocks.aiAgents = {}
DirectorManagerMocks.cityRegions = {}
DirectorManagerMocks.creatureObjects = {}
DirectorManagerMocks.playerObjects = {}
DirectorManagerMocks.sceneObjects = {}

-- Function to be called in the setup method for a test to prepare the mocks.
function DirectorManagerMocks.setup()
	realCreateEvent = createEvent
	realGetCityRegionAt = getCityRegionAt
	realGetSceneObject = getSceneObject
	realGetSpawnPoint = getSpawnPoint
	realReadData = readData
	realSpawnMobile = spawnMobile
	realWriteData = writeData

	realLuaAiAgent = LuaAiAgent
	realLuaCityRegion = LuaCityRegion
	realLuaCreatureObject = LuaCreatureObject
	realLuaPlayerObject = LuaPlayerObject
	realLuaSceneObject = LuaSceneObject
end

-- Function to be called in the teardown method for a test to clean up the mocks.
function DirectorManagerMocks.teardown()
	createEvent = realCreateEvent
	getCityRegionAt = realGetCityRegionAt
	getSceneObject = realGetSceneObject
	getSpawnPoint = realGetSpawnPoint
	readData = realReadData
	spawnMobile = realSpawnMobile
	writeData = realWriteData

	LuaAiAgent = realLuaAiAgent 
	LuaCityRegion = realLuaCityRegion
	LuaCreatureObject = realLuaCreatureObject
	LuaPlayerObject = realLuaPlayerObject
	LuaSceneObject = realLuaSceneObject
end

-- Function to be called in the before_each method for a test to prepare the mocks.
function DirectorManagerMocks.before_each()
	createEvent = spy.new(function() end)
	getCityRegionAt = spy.new(function() return nil end)
	getSceneObject = spy.new(function() return nil end)
	getSpawnPoint = spy.new(function() return nil end)
	readData = spy.new(function() return nil end)
	spawnMobile = spy.new(function() return nil end)
	writeData = spy.new(function() end)

	LuaAiAgent = spy.new(function(pAiAgent)
		if pAiAgent == nil then
			assert.not_nil(pAiAgent)
			return nil
		end
		return DirectorManagerMocks.aiAgents[pAiAgent]
	end)

	LuaCityRegion = spy.new(function(pCityRegion)
		if pCityRegion == nil then
			assert.not_nil(pCityRegion)
			return nil
		end
		return DirectorManagerMocks.cityRegions[pCityRegion]
	end)

	LuaCreatureObject = spy.new(function(pCreatureObject)
		if pCreatureObject == nil then
			assert.not_nil(pCreatureObject)
			return nil
		end
		return DirectorManagerMocks.creatureObjects[pCreatureObject]
	end)

	LuaPlayerObject = spy.new(function(pPlayerObject)
		if pPlayerObject == nil then
			assert.not_nil(pPlayerObject)
			return nil
		end
		return DirectorManagerMocks.playerObjects[pPlayerObject]
	end)

	LuaSceneObject = spy.new(function(pSceneObject)
		if pSceneObject == nil then
			assert.not_nil(pSceneObject)
			return nil
		end
		return DirectorManagerMocks.sceneObjects[pSceneObject]
	end)
end

-- Function to be called in the after_each method for a test to verify the mocks.
function DirectorManagerMocks.after_each()
end

return DirectorManagerMocks
