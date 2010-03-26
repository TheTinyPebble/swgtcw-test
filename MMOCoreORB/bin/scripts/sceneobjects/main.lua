--Copyright (C) 2007 <SWGEmu>
 
--This File is part of Core3.
 
--This program is free software; you can redistribute 
--it and/or modify it under the terms of the GNU Lesser 
--General Public License as published by the Free Software
--Foundation; either version 2 of the License, 
--or (at your option) any later version.
 
--This program is distributed in the hope that it will be useful, 
--but WITHOUT ANY WARRANTY; without even the implied warranty of 
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
--See the GNU Lesser General Public License for
--more details.
 
--You should have received a copy of the GNU Lesser General 
--Public License along with this program; if not, write to
--the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
 
--Linking Engine3 statically or dynamically with other modules 
--is making a combined work based on Engine3. 
--Thus, the terms and conditions of the GNU Lesser General Public License 
--cover the whole combination.
 
--In addition, as a special exception, the copyright holders of Engine3 
--give you permission to combine Engine3 program with free software 
--programs or libraries that are released under the GNU LGPL and with 
--code included in the standard release of Core3 under the GNU LGPL 
--license (or modified versions of such code, with unchanged license). 
--You may copy and distribute such a system following the terms of the 
--GNU LGPL for Engine3 and the licenses of the other code concerned, 
--provided that you include the source code of that other code when 
--and as the GNU LGPL requires distribution of source code.
 
--Note that people who make modified versions of Engine3 are not obligated 
--to grant this special exception for their modified versions; 
--it is their choice whether to do so. The GNU Lesser General Public License 
--gives permission to release a modified version without this exception; 
--this exception also makes it possible to release a modified version 
--which carries forward this exception.

-- utils
-- lua files

RunObjectFile("objects/object.lua") -- basic object
RunObjectFile("objects/lair.lua") -- Lair Object

local sin, cos = math.sin, math.cos
local deg, rad = math.deg, math.rad
math.sin = function (x) return sin(rad(x)) end
math.cos = function (x) return cos(rad(x)) end

-- Global object table
Objects = { }

function Objects:addObject(obj, type)
	self[type] = obj
end

function getObject(type)
	return Objects[type]
end

function spawnObject(object, Planet, PositionX, PositionY)
	newObject = object:new { planet = Planet, positionX = PositionX, positionY = PositionY }
	AddObjectToServer(newObject)
end

function spawnObject(object, Planet, PositionX, PositionY, respawnTime)
	newObject = object:new { planet = Planet, positionX = PositionX, positionY = PositionY, respawnTimer = respawnTime }
	AddObjectToServer(newObject)
end

function spawnLair(lair, Planet, PositionX, PositionY, PositionZ)
	newLair = lair:new { planet = Planet, positionX = PositionX, positionY = PositionY, positionZ = PositionZ }
	AddLairToServer(newLair)
end

-- Creature objects
-- RunObjectFile("objects/lairs/corelliaLairs.lua")
-- RunObjectFile("objects/lairs/dantooineLairs.lua")
-- RunObjectFile("objects/lairs/dathomirLairs.lua")
-- RunObjectFile("objects/lairs/endorLairs.lua")
-- RunObjectFile("objects/lairs/lokLairs.lua")
-- RunObjectFile("objects/lairs/nabooLairs.lua")
-- RunObjectFile("objects/lairs/roriLairs.lua")
-- RunObjectFile("objects/lairs/talusLairs.lua")
-- RunObjectFile("objects/lairs/tatooineLairs.lua")
-- RunObjectFile("objects/lairs/yavin4Lairs.lua")


-- Spawns
RunObjectFile("spawns.lua")
