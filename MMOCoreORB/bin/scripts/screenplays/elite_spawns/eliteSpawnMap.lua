eliteSpawnMap = {
	{
		planet = "endor", mobile = "gorax", respawnTime = 90, 
		spawnArea = {
			{x = 5050, y = 4678, radius = 1500},
		},
		mechanics = {
			mechanic = "patrolling",
			--spawnAdds = true, addsToSpawn = 1, addMobile = "minor_gorax",
		},
	},
	--[[{
		planet = "endor", mobile = "elite_mandalorian_supercommando", respawnTime = 5, 
		spawnArea = {
			{x = 5050, y = 4678, radius = 1500}, --Temporary
		},
	},
	{
		planet = "dantooine", mobile = "elite_mandalorian_supercommando", respawnTime = 5, 
		spawnArea = {
			{x = 5050, y = 4678, radius = 1500}, --Temporary
		},
	},
	{
		planet = "dathomir", mobile = "nightsister_elder", respawnTime = 5, 
		idleWander = false,
		spawnArea = {
			{x = 5050, y = 4678, radius = 1500},
		},
		mechanics = {
			mechanic = "addWaves",
			numberOfWaves = 3, addsPerWave = 2, addMobile = "nightsister_protector",
			spawnAdds = true, addsToSpawn = 3, initialAddMobile = "nightsister_stalker",
		},
	},
	{
		planet = "dantooine", mobile = "dark_jedi_master", respawnTime = 5, 
		spawnArea = {
			{x = 5050, y = 4678, radius = 1500},
		},
		spawnTheater = true,
		flattenLayer = true,
		theater = {
			{ template = "object/static/structure/dathomir/mtn_clan_hut_s01.iff", xDiff = 0.896, zDiff = 0.236, yDiff = -0.272, heading = 0 },
			{ template = "object/static/structure/general/camp_campfire_logs_smoldering_s01.iff", xDiff = 0.0886, zDiff = 0.008, yDiff = 0.682, heading = -16.464 },
			{ template = "object/static/structure/general/prp_junk_s8.iff", xDiff = 0.513, zDiff = 0.247, yDiff = -2.335, heading = 0 },
			{ template = "object/static/structure/general/camp_stool_short_s01.iff", xDiff = 0.400, zDiff = -0.040, yDiff = 1.733, heading = 0 },
			{ template = "object/static/structure/general/camp_stool_short_s01.iff", xDiff = -1.521, zDiff = -0.209, yDiff = 0.653, heading = 0 },
			{ template = "object/static/structure/general/camp_stool_short_s01.iff", xDiff = -0.376, zDiff = -0.242, yDiff = -0.460, heading = 0 },
		},
		spawnAdds = true,
		adds = {
			{ template = "dark_adept", xDiff = 1, yDiff = -0.272, heading = 0, idleWander = false },
		},
		awardBadge = false, badgeToAward = BDG_RACING_AGRILAT_SWAMP,
	},]]
}
