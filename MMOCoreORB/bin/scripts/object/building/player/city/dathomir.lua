object_building_player_city_garden_dathomir_lrg_01 = object_building_player_city_shared_garden_dathomir_lrg_01:new {
	lotSize = 1,
	baseMaintenanceRate = 0,
	allowedZones = {1,5,6},
	cityRankRequired = 3,
	abilitiesRequired = {"placeLargeGarden"}
}

ObjectTemplates:addTemplate(object_building_player_city_garden_dathomir_lrg_01, "object/building/player/city/garden_dathomir_lrg_01.iff")

object_building_player_city_garden_dathomir_med_01 = object_building_player_city_shared_garden_dathomir_med_01:new {
	lotSize = 1,
	baseMaintenanceRate = 0,
	allowedZones = {1,5,6},
	cityRankRequired = 2,
	abilitiesRequired = {"placeMediumGarden"}
}

ObjectTemplates:addTemplate(object_building_player_city_garden_dathomir_med_01, "object/building/player/city/garden_dathomir_med_01.iff")

object_building_player_city_garden_dathomir_sml_01 = object_building_player_city_shared_garden_dathomir_sml_01:new {
	lotSize = 1,
	baseMaintenanceRate = 0,
	allowedZones = {1,5,6},
	cityRankRequired = 1,
	abilitiesRequired = {"placeSmallGarden"}
}

ObjectTemplates:addTemplate(object_building_player_city_garden_dathomir_sml_01, "object/building/player/city/garden_dathomir_sml_01.iff")
