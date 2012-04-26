function printf(...) io.write(string.format(unpack(arg))) end

function writeData(key, data)
	keyUnpacked = string.format(key)
		
	writeSharedMemory(keyUnpacked, data)
end

function deleteData(key)
	deleteSharedMemory(string.format(key))
end

function readData(key)
	return readSharedMemory(string.format(key))
end

Object = { 
}

-- for creation of new instances
function Object:new (o)
	o = o or { }
	setmetatable(o, self)
    self.__index = self
    return o
end

ScreenPlay = Object:new {
	numerOfActs = 0,
	startingEvent = nil
}

Act = Object:new {
		
}



includeFile("themepark/tutorial.lua")
includeFile("themepark/themepark_jabba.lua")
includeFile("recruiters/recruiters.lua")
includeFile("tasks/mozo_bondog.lua")
includeFile("tasks/dolac_legasi.lua")
includeFile("tasks/hedon_istee.lua")
includeFile("tasks/vardias_tyne.lua")
includeFile("tasks/ris_armor_quest.lua")
includeFile("recruiters/imperialrecruiter.lua")
includeFile("recruiters/rebelrecruiter.lua")
includeFile("dungeon/death_watch_bunker.lua")
includeFile("dungeon/geonosian_lab.lua")
includeFile("dungeon/death_watch_bunker_conv_handles.lua")
includeFile("themepark/imperial_retreat/kaja_orzee_handler.lua")

--Tests
--includeFile("tests/options_bitmask_test.lua")
includeFile("event/stresstest_20120128.lua")