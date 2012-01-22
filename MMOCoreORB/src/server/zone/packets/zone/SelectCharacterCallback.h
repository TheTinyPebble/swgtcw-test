/*
 * SelectCharacterCallback.h
 *
 *  Created on: Sep 5, 2009
 *      Author: theanswer
 */

#ifndef SELECTCHARACTERCALLBACK_H_
#define SELECTCHARACTERCALLBACK_H_

#include "../MessageCallback.h"

#include "server/zone/ZoneServer.h"
#include "server/zone/Zone.h"
#include "server/zone/managers/player/PlayerManager.h"

#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/player/PlayerObject.h"

#include "server/chat/ChatManager.h"
#include "server/login/account/Account.h"

class SelectCharacterCallback : public MessageCallback {
	uint64 characterID;
public:
	SelectCharacterCallback(ZoneClientSession* client, ZoneProcessServer* server) :
		MessageCallback(client, server) {

	}

	void parse(Message* message) {
		characterID = message->parseLong(6);
	}

	void run() {

		if(!client->hasCharacter(characterID)) {
			ErrorMessage* errMsg = new ErrorMessage("Login Error", "Invalid Character ID", 0x0);
			client->sendMessage(errMsg);
			return;
		}

		ZoneServer* zoneServer = server->getZoneServer();
		//ObjectManager* objectManager = zoneServer->getObjectManager();

		//Logger::console.info("selected char id: 0x" + String::hexvalueOf((int64)characterID), true);

		ManagedReference<SceneObject*> obj = zoneServer->getObject(characterID, true);

		if (obj != NULL && obj->isPlayerCreature()) {
			CreatureObject* player = cast<CreatureObject*>( obj.get());
			PlayerObject* ghost = player->getPlayerObject();

			Locker _locker(player);

			if (player->getPlayerObject() == NULL) {
				_locker.release();

				//oldClient->disconnect(),
				return;
			}

			ManagedReference<ZoneClientSession*> oldClient = player->getClient();

			if (oldClient != NULL && client != oldClient) {

				_locker.release();

				oldClient->disconnect();

				return;
			}

			player->setClient(client);
			client->setPlayer(obj);

			String zoneName = ghost->getSavedTerrainName();
			uint64 savedParentID = ghost->getSavedParentID();
			ManagedReference<SceneObject*> playerParent = zoneServer->getObject(savedParentID, true);

			Zone* zone = zoneServer->getZone(zoneName);
			ManagedReference<SceneObject*> currentParent = player->getParent();

			if ((playerParent != NULL && currentParent == NULL) || (currentParent != NULL && currentParent->isCellObject())) {
				ghost->setTeleporting(true);
				player->setMovementCounter(0);
				ghost->setClientLastMovementStamp(0);

				playerParent = playerParent == NULL ? currentParent : playerParent;

				playerParent->transferObject(player, -1, false);

				ghost->updateLastValidatedPosition();

				if (player->getZone() == NULL) {
					SceneObject* root = player->getRootParent();

					zone->transferObject(root, -1, false);
				}

				player->sendToOwner(true);
			} else if (currentParent == NULL) {
				zone->transferObject(player, -1, true);
			} else {
				player->sendToOwner(true);
			}

			if (playerParent == NULL)
				ghost->setSavedParentID(0);

			ghost->setOnline();

			ChatManager* chatManager = zoneServer->getChatManager();
			chatManager->addPlayer(player);
			chatManager->loadMail(player);

			ghost->notifyOnline();

			PlayerManager* playerManager = zoneServer->getPlayerManager();
			playerManager->sendLoginMessage(player);

		}
	}
};


#endif /* SELECTCHARACTERCALLBACK_H_ */
