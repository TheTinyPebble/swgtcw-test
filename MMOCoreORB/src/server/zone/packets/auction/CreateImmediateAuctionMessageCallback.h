/*
 * CreateImmediateAuctionMessageCallback.h
 *
 *  Created on: 13/03/2010
 *      Author: victor
 */

#ifndef CREATEIMMEDIATEAUCTIONMESSAGECALLBACK_H_
#define CREATEIMMEDIATEAUCTIONMESSAGECALLBACK_H_

#include "../MessageCallback.h"
#include "server/zone/managers/auction/AuctionManager.h"
#include "server/zone/objects/tangible/terminal/vendor/VendorTerminal.h"
#include "server/zone/objects/creature/vendor/VendorCreature.h"


class CreateImmediateAuctionMessageCallback : public MessageCallback {
	uint64 objectID;
	uint64 vendorID;

	uint32 price;
	uint32 duration;
	byte premium;

	UnicodeString description;
public:
	CreateImmediateAuctionMessageCallback(ZoneClientSession* client, ZoneProcessServer* server) :
			MessageCallback(client, server) {

	}

	void parse(Message* message) {

		objectID = message->parseLong(); // object for sale
		vendorID = message->parseLong(); // vendor

		price = message->parseInt(); // Sale price
		duration = message->parseInt(); // How long to sell for in seconds

		message->parseUnicode(description);

		premium = message->parseByte(); // Preium Sale flag

	}

	void run() {
		ManagedReference<CreatureObject*> player = cast<CreatureObject*>( client->getPlayer().get().get());
		ManagedReference<SceneObject*> sceno = server->getZoneServer()->getObject(vendorID);

		if (player == NULL || sceno == NULL || !sceno->isVendor())
			return;

		// And now we figure out what Vendor Class
		Vendor* vendor = NULL;

		if (sceno->isTerminal()) {
			Terminal* term = cast<Terminal*>( sceno.get());
			if (term->isVendorTerminal()) {
				VendorTerminal* terminal = cast<VendorTerminal*>( term);
				vendor = terminal->getVendor();
			}

		} else if (sceno->isCreatureObject()) {
			CreatureObject* cero = cast<CreatureObject*>( sceno.get());
			if (!cero->isVendorCreature())
				return;

			VendorCreature* vendorCreature = cast<VendorCreature*>( cero);
			vendor = vendorCreature->getVendor();

		} else
			return;

		if (vendor == NULL)
			return;

		AuctionManager* auctionManager = server->getZoneServer()->getAuctionManager();

		auctionManager->addSaleItem(player, objectID, vendor, description, price, duration, false, premium);
	}

};

#endif /* CREATEIMMEDIATEAUCTIONMESSAGECALLBACK_H_ */
