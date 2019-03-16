witchesOfDathomirScreenplay = ScreenPlay:new {

}

registerScreenPlay("witchesOfDathomirScreenplay", true)

local QuestManager = require("managers.quest.quest_manager")

--TODO: Spawn Scene Objects
--TODO: On logged in events
--TODO: Remove old spawns at locations (outcasts)

function witchesOfDathomirScreenplay:start()
	if (isZoneEnabled("dathomir")) then
		self:spawnMobiles()
		self:spawnSceneObjects()
	end
end

function witchesOfDathomirScreenplay:onPlayerLoggedIn(pPlayer)
	if (pPlayer == nil) then
		return
	end
	
	wodPrologueScreenplay:onPlayerLoggedIn(pPlayer)
	
end

function witchesOfDathomirScreenplay:spawnMobiles()
	spawnMobile("dathomir", "wod_omogg_rep", 1, 558, 6, 3073, 29, 0)
	spawnMobile("dathomir", "wod_rubina", 1, -3177, 21.8, 3184, 0, 0)
	spawnMobile("dathomir", "wod_outcast_01", 1, 866, 132, 1095, 162, 0)
	spawnMobile("dathomir", "wod_outcast_02", 1, -1000, 116.2, 862, -131, 0)
	spawnMobile("dathomir", "wod_outcast_03", 1, -2597, 131.3, 4952, 55, 0)
	spawnMobile("dathomir", "wod_outcast_04", 1, 1482, 131.7, 3515, 43, 0)
	spawnMobile("dathomir", "wod_outcast_05", 1, 1125, 135, -1022, -122, 0)
	spawnMobile("dathomir", "wod_outcast_06", 1, -856, 146.7, 2788, -144, 0)
	spawnMobile("dathomir", "wod_outcast_07", 1, -7121, 363.7, 2933, 111, 0)
end

function witchesOfDathomirScreenplay:spawnSceneObjects()

end