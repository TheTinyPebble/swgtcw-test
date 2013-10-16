/*
 * StaticObjectImplementation.cpp
 *
 *  Created on: 12/04/2010
 *      Author: victor
 */

#include "server/zone/objects/staticobject/StaticObject.h"
#include "server/zone/packets/static/StaticObjectMessage3.h"
#include "server/zone/packets/static/StaticObjectMessage6.h"

void StaticObjectImplementation::sendBaselinesTo(SceneObject* player) {
	BaseMessage* stao3 = new StaticObjectMessage3(_this.get());
	player->sendMessage(stao3);

	BaseMessage* stao6 = new StaticObjectMessage6(_this.get());
	player->sendMessage(stao6);
}
