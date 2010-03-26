/*
 * CreateAuctionMessageCallback.h
 *
 *  Created on: 13/03/2010
 *      Author: victor
 */

#ifndef CREATEAUCTIONMESSAGECALLBACK_H_
#define CREATEAUCTIONMESSAGECALLBACK_H_


#include "../MessageCallback.h"
#include "server/zone/managers/bazaar/BazaarManager.h"


class CreateAuctionMessageCallback : public MessageCallback {
	uint64 objectid;
	uint64 bazaarid;

	uint32 price;
	uint32 duration;

	UnicodeString description;
public:
	CreateAuctionMessageCallback(ZoneClientSession* client, ZoneProcessServerImplementation* server) :
			MessageCallback(client, server) {

	}

	void parse(Message* message) {

		objectid = message->parseLong(); // object for sale
		bazaarid = message->parseLong(); // bazaar

		price = message->parseInt(); // Sale price
		duration = message->parseInt(); // How long to sell for in minutes

		message->parseUnicode(description);

	}

	void run() {
		PlayerCreature* player = (PlayerCreature*) client->getPlayer();

		if (player == NULL)
			return;

		BazaarManager* bazaarManager = server->getZoneServer()->getBazaarManager();
		bazaarManager->addSaleItem(player, objectid, bazaarid, description, price, duration, true);
	}

};


#endif /* CREATEAUCTIONMESSAGECALLBACK_H_ */
