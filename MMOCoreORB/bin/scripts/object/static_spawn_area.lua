static_spawn_area = SharedObjectTemplate:new {
clientTemplateFileName = "", 
	 planetMapCategory = "",
	 planetMapSubCategory = "",
	 autoRegisterWithPlanetMap = 1,
	 
	 zoneComponent = "ZoneComponent",
	 objectMenuComponent = {"cpp", "ObjectMenuComponent"},
	 containerComponent = {"cpp", "ContainerComponent"},
	gameObjectType = 33554437
}

ObjectTemplates:addTemplate(static_spawn_area, "object/static_spawn_area.iff")