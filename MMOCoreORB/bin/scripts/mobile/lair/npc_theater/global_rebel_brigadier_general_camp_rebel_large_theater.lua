global_rebel_brigadier_general_camp_rebel_large_theater = Lair:new {
	mobiles = {
		{"cis_magnaguard",1},
		{"cis_battle_droid_captain",1},
		{"cis_sbd",2}
	},
	spawnLimit = 15,
	buildingsVeryEasy = {"object/building/poi/anywhere_rebel_camp_large_1.iff"},
	buildingsEasy = {"object/building/poi/anywhere_rebel_camp_large_1.iff"},
	buildingsMedium = {"object/building/poi/anywhere_rebel_camp_large_1.iff"},
	buildingsHard = {"object/building/poi/anywhere_rebel_camp_large_1.iff"},
	buildingsVeryHard = {"object/building/poi/anywhere_rebel_camp_large_1.iff"},
	missionBuilding = "object/tangible/lair/base/objective_banner_rebel.iff",
	mobType = "npc",
	buildingType = "theater",
	faction = "rebel"
}

addLairTemplate("global_rebel_brigadier_general_camp_rebel_large_theater", global_rebel_brigadier_general_camp_rebel_large_theater)
