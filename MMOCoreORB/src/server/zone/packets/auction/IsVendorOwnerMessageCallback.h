/*
 * IsVendorOwnerMessageCallback.h
 *
 *  Created on: 30/01/2010
 *      Author: victor
 */

#ifndef ISVENDOROWNERMESSAGECALLBACK_H_
#define ISVENDOROWNERMESSAGECALLBACK_H_

#include "../MessageCallback.h"

#include "IsVendorOwnerResponseMessage.h"
#include "server/zone/objects/terrain/PlanetNames.h"

#include "server/zone/Zone.h"

class IsVendorOwnerMessageCallback : public MessageCallback {
	uint64 oid;

public:
	IsVendorOwnerMessageCallback(ZoneClientSession* client, ZoneProcessServer* server) :
		MessageCallback(client, server) {

		oid = 0;
	}

	void parse(Message* message) {
		//characterID = message->parseLong(6);
		//System::out << message->toStringData() << endl;
		oid = message->parseLong();
	}

	void run() {
		ManagedReference<SceneObject*> sceno = server->getZoneServer()->getObject(oid);

		if (sceno == NULL)
			return;

		Zone* zone = sceno->getZone();

		if (zone == NULL)
			return;

		PlayerCreature* player = (PlayerCreature*) client->getPlayer();

		if (player == NULL)
			return;

		String planetString = Planet::getPlanetName(zone->getZoneID());
		String vendorRegion = ""; // TODO: Vendors don't have regions impl yet.

		//TODO: Relook at this! - POLONEL
		if (sceno->isTerminal() && ((Terminal*)sceno.get())->isBazaarTerminal()) {
			ActiveArea* area = sceno->getActiveRegion();

			if (area == NULL) {
				sceno->error("NULL AREA FOR THIS TERMINAL");
				return;
			}

			vendorRegion = area->getObjectName()->getStringID();

		}

		IsVendorOwnerResponseMessage* msg = new IsVendorOwnerResponseMessage(sceno, player, planetString, vendorRegion, 0);
		client->sendMessage(msg);

	}
};


#endif /* ISVENDOROWNERMESSAGECALLBACK_H_ */
