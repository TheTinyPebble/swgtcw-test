/*
 * ComponentManager.cpp
 *
 *  Created on: 26/05/2011
 *      Author: victor
 */

#include "ComponentManager.h"

#include "server/zone/objects/player/components/PlayerContainerComponent.h"
#include "server/zone/objects/scene/components/ContainerComponent.h"
#include "server/zone/objects/scene/components/ZoneComponent.h"
#include "server/zone/objects/scene/components/ObjectMenuComponent.h"
#include "server/zone/objects/player/components/PlayerZoneComponent.h"
#include "server/zone/objects/building/components/ShuttleZoneComponent.h"
#include "server/zone/objects/player/components/PlayerObjectMenuComponent.h"
#include "server/zone/objects/tangible/components/TangibleObjectMenuComponent.h"

ComponentManager::ComponentManager() {
	components.put("ContainerComponent", new ContainerComponent());
	components.put("PlayerContainerComponent", new PlayerContainerComponent());

	components.put("ZoneComponent", new ZoneComponent());
	components.put("PlayerZoneComponent", new PlayerZoneComponent());
	components.put("ShuttleZoneComponent", new ShuttleZoneComponent());

	components.put("ObjectMenuComponent", new ObjectMenuComponent());
	components.put("TangibleObjectMenuComponent", new TangibleObjectMenuComponent());
	components.put("PlayerObjectMenuComponent", new PlayerObjectMenuComponent());
}
