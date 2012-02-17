/*
 * ComponentManager.cpp
 *
 *  Created on: 26/05/2011
 *      Author: victor
 */

#include "ComponentManager.h"

#include "server/zone/objects/player/components/PlayerContainerComponent.h"
#include "server/zone/objects/scene/components/ContainerComponent.h"
#include "server/zone/objects/tangible/components/LootContainerComponent.h"
#include "server/zone/objects/scene/components/ZoneComponent.h"
#include "server/zone/objects/scene/components/ObjectMenuComponent.h"
#include "server/zone/objects/scene/components/AttributeListComponent.h"
#include "server/zone/objects/creature/vendor/VendorContainerComponent.h"
#include "server/zone/objects/player/components/PlayerZoneComponent.h"
#include "server/zone/objects/building/components/ShuttleZoneComponent.h"
#include "server/zone/objects/player/components/PlayerObjectMenuComponent.h"
#include "server/zone/objects/tangible/components/ContainerObjectComponent.h"
#include "server/zone/objects/tangible/components/TrapMenuComponent.h"
#include "server/zone/objects/tangible/components/LairMenuComponent.h"
#include "server/zone/objects/tangible/components/TangibleObjectMenuComponent.h"
#include "server/zone/objects/tangible/components/LootSchematicMenuComponent.h"
#include "server/zone/objects/tangible/components/BountyHunterDroidMenuComponent.h"
#include "server/zone/objects/tangible/components/CampKitMenuComponent.h"
#include "server/zone/objects/tangible/components/CampTerminalMenuComponent.h"
#include "server/zone/objects/tangible/components/InsuranceTerminalMenuComponent.h"
#include "server/zone/objects/tangible/components/BankTerminalMenuComponent.h"
#include "server/zone/objects/tangible/components/CloningTerminalMenuComponent.h"
#include "server/zone/objects/tangible/components/HologrindHolocronMenuComponent.h"
#include "server/zone/objects/tangible/components/ArtCrateMenuComponent.h"
#include "server/zone/objects/tangible/components/LootSchematicAttributeListComponent.h"
#include "server/zone/objects/tangible/deed/components/PlaceStructureComponent.h"
#include "server/zone/objects/tangible/deed/components/PlaceCityHallComponent.h"
#include "server/zone/ZoneContainerComponent.h"
#include "server/zone/objects/structure/components/StructureContainerComponent.h"
#include "server/zone/objects/region/components/CityManagementMenuComponent.h"
#include "server/zone/objects/region/components/CityVotingMenuComponent.h"
#include "server/zone/objects/scene/components/AiInterfaceComponent.h"
#include "server/zone/objects/scene/components/AiDummyComponent.h"
#include "server/zone/objects/creature/components/AiDefaultComponent.h"
#include "server/zone/objects/creature/components/AiCreatureComponent.h"
#include "server/zone/objects/creature/components/AiNPCComponent.h"

ComponentManager::ComponentManager() {
	components.put("ContainerComponent", new ContainerComponent());
	components.put("PlayerContainerComponent", new PlayerContainerComponent());
	components.put("LootContainerComponent", new LootContainerComponent());

	components.put("ZoneComponent", new ZoneComponent());
	components.put("PlayerZoneComponent", new PlayerZoneComponent());
	components.put("ShuttleZoneComponent", new ShuttleZoneComponent());

	components.put("ObjectMenuComponent", new ObjectMenuComponent());
	components.put("TangibleObjectMenuComponent", new TangibleObjectMenuComponent());
	components.put("PlayerObjectMenuComponent", new PlayerObjectMenuComponent());

	components.put("LootSchematicMenuComponent", new LootSchematicMenuComponent());

	components.put("BountyHunterDroidMenuComponent", new BountyHunterDroidMenuComponent());

	components.put("CampKitMenuComponent", new CampKitMenuComponent());
	components.put("CampTerminalMenuComponent", new CampTerminalMenuComponent());

	components.put("InsuranceTerminalMenuComponent", new InsuranceTerminalMenuComponent());
	components.put("BankTerminalMenuComponent", new BankTerminalMenuComponent());
	components.put("CloningTerminalMenuComponent", new CloningTerminalMenuComponent());

	components.put("ArtCrateMenuComponent", new ArtCrateMenuComponent());

	components.put("ZoneContainerComponent", new ZoneContainerComponent());

	components.put("HologrindHolocronMenuComponent", new HologrindHolocronMenuComponent());

	components.put("AttributeListComponent", new AttributeListComponent());
	components.put("LootSchematicAttributeListComponent", new LootSchematicAttributeListComponent());

	components.put("PlaceStructureComponent", new PlaceStructureComponent());
	components.put("PlaceCityHallComponent", new PlaceCityHallComponent());

	components.put("ContainerObjectComponent", new ContainerObjectComponent());
	components.put("StructureContainerComponent", new StructureContainerComponent());

	components.put("VendorContainerComponent", new VendorContainerComponent());

	components.put("CityManagementMenuComponent", new CityManagementMenuComponent());
	components.put("CityVotingMenuComponent", new CityVotingMenuComponent());
	components.put("TrapMenuComponent", new TrapMenuComponent());

	components.put("LairMenuComponent", new LairMenuComponent());

	components.put("AiInterfaceComponent", new AiInterfaceComponent());
	components.put("AiDummyComponent", new AiDummyComponent());
	components.put("AiDefaultComponent", new AiDefaultComponent());
	components.put("AiCreatureComponent", new AiCreatureComponent());
	components.put("AiNPCComponent", new AiNPCComponent());
}
