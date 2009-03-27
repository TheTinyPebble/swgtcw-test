/*
Copyright (C) 2007 <SWGEmu>

This File is part of Core3.

This program is free software; you can redistribute
it and/or modify it under the terms of the GNU Lesser
General Public License as published by the Free Software
Foundation; either version 2 of the License,
or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Lesser General Public License for
more details.

You should have received a copy of the GNU Lesser General
Public License along with this program; if not, write to
the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

Linking Engine3 statically or dynamically with other modules
is making a combined work based on Engine3.
Thus, the terms and conditions of the GNU Lesser General Public License
cover the whole combination.

In addition, as a special exception, the copyright holders of Engine3
give you permission to combine Engine3 program with free software
programs or libraries that are released under the GNU LGPL and with
code included in the standard release of Core3 under the GNU LGPL
license (or modified versions of such code, with unchanged license).
You may copy and distribute such a system following the terms of the
GNU LGPL for Engine3 and the licenses of the other code concerned,
provided that you include the source code of that other code when
and as the GNU LGPL requires distribution of source code.

Note that people who make modified versions of Engine3 are not obligated
to grant this special exception for their modified versions;
it is their choice whether to do so. The GNU Lesser General Public License
gives permission to release a modified version without this exception;
this exception also makes it possible to release a modified version
which carries forward this exception.
*/

#include "objects.h"
#include "packets.h"

#include "ZoneServer.h"

#include "ZoneClientSessionImplementation.h"

#include "ZoneProcessServerImplementation.h"

#include "Zone.h"

#include "managers/player/PlayerManager.h"
#include "managers/name/NameManager.h"
#include "managers/item/ItemManager.h"
#include "managers/radial/RadialManager.h"
#include "managers/planet/PlanetManager.h"
#include "managers/bazaar/BazaarManager.h"
#include "managers/bazaar/BazaarPlanetManager.h"
#include "managers/sui/SuiManager.h"

#include "objects/terrain/PlanetNames.h"
#include "objects/tangible/terminal/bazaar/RegionBazaar.h"

#include "managers/planet/events/tutorial/TutorialAudioStatMigrationEvent.h"
#include "managers/planet/events/tutorial/TutorialAudioWelcomeEvent.h"

#include "../login/packets/ErrorMessage.h"

#include "../chat/ChatManager.h"

#include "ZonePacketHandler.h"

ZonePacketHandler::ZonePacketHandler(const String& s, ZoneProcessServerImplementation* serv) : Logger(s) {
		processServer = serv;

		server = processServer->getZoneServer();
}

void ZonePacketHandler::handleMessage(Message* pack) {
	//info("parsing " + pack->toString());

	uint16 opcount = pack->parseShort();
	uint32 opcode = pack->parseInt();

	//System::out << "handleMessage: opcount: " << hex << opcount << dec << " opcode: " << hex << opcode << endl;

	switch (opcount) {
	case 1:
		switch (opcode) {
		case 0x43FD1C22: //CmdSceneReady Zone done loading.
			handleCmdSceneReady(pack);
			break;
		case 0xC1B03B81: //FactionRequestMessage
			handleFactionRequestMessage(pack);
			break;
		case 0xB75DD5D7: //StomachRequestMessage
		    handleStomachRequestMessage(pack);
		    break;
		case 0x9D105AA1: //PlayerMoneyRequest
		    handlePlayerMoneyRequest(pack);
		    break;
		case 0x4C3D2CFA: //ChatRequestRoomList
			handleChatRequestRoomList(pack);
			break;
		case 0x9CA80F98: // AbortTradeMsg
			handleAbortTradeMessage(pack);
			break;
		case 0xB131CA17: // AcceptTransactionMessage
			handleAcceptTransactionMessage(pack);
			break;
		case 0xE81E4382: // UnAcceptTransactionMessage
			handleUnAcceptTransactionMessage(pack);
			break;
		case 0x9AE247EE: // VerifyTradeMessage
			handleVerifyTradeMessage(pack);
			break;
		}

		break;
	case 2:
		switch (opcode) {
		case 0xB5098D76: //SelectCharacter Request/zone insert.
			handleSelectCharacter(pack);
			break;
		case 0x8F251641: //ChatDeletePersistentMessage
			handleDeletePersistentMsg(pack);
			break;
		case 0x81EB4EF7: //GuildRequestMessage
		    handleGuildRequestMessage(pack);
		    break;
		case 0x1E8D1356: // AddItemMessage
			handleAddItemMessage(pack);
			break;
		case 0xD1527EE8: // GiveMoneyMessage
			handleGiveMoneyMessage(pack);
			break;
		case 0xD36EFAE4: //GetAuctionDetails
			handleGetAuctionItemAttributes(pack);
			break;
		case 0xD6D1B6D1: //ClientRandomNameRequest
			handleClientRandomNameRequest(pack);
			break;
		case 0x2E365218: //ConnectPlayerMessage
			handleConnectPlayerMessage(pack);
			break;
		case 0x274F4E78: //NewTicketActivityMessage
			handleNewTicketActivityMessage(pack);
			break;
		case 0xF898E25F: //RequestCategoriesMessage
			handleRequestCategoriesMessage(pack);
			break;
		case 0x0F5D5325: //ClientInactivityMessage
			handleClientInactivityMessage(pack);
			break;
		case 0x48F493C5: //CommoditiesItemTypeListRequest
			handleCommoditiesItemTypeListRequest(pack);
			break;
		}

		break;
	case 3:
		switch (opcode) {
		case 0xD5899226: //	ClientIdMsg
			handleClientPermissionsMessage(pack);
			break;
		case 0x07E3559F: //ChatRequestPersistentMessage
			handleRequestPersistentMsg(pack);
			break;
		case 0x7CA18726:
			handleRadialSelect(pack);
		    break;
		case 0x96405D4D: //Travel Points list
		    handleTravelListRequest(pack);
		    break;
		case 0xBC6BDDF2: // ChatEnterRoomById
			handleChatEnterRoomById(pack);
			break;
		case 0x94B2A77: // ChatDestroyRoom
			handleChatDestroyRoom(pack);
			break;
		case 0x493E3FFA: //  ChatRemoveAvatarFromRoom
			handleChatRemoveAvatarFromRoom(pack);
			break;
		case 0x12B0D449: //RetrieveAuctionItemMessage
			handleRetrieveAuctionItem(pack);
			break;
		case 0xBB8CAD45: // VerifyPlayerNameMessage
			handleVerifyPlayerNameMessage(pack);
			break;
		case 0x5E7B4846: // GetArticleMessage
			handleGetArticleMessage(pack);
			break;
		case 0x962E8B9B: //SearchKnowledgebaseMessage
			handleSearchKnowledgebaseMessage(pack);
			break;
		}

		break;
	case 04:
		switch (opcode) {
		case 0xD5899226:
			handleClientPermissionsMessage(pack);
			break;
		case 0x092D3564: //SuiEventNotification
			handleSuiEventNotification(pack);
			break;
		case 0x91125453: //BidAuctionMessage
			handleBazaarBuy(pack);
			break;
		case 0xC9A5F98D: // GetTicketsMessage
			handleGetTicketsMessage(pack);
			break;
		}
		break;
	case 05:
		switch (opcode) {
		case 0x80CE5E46:
			handleObjectControllerMessage(pack);
			break;
		case 0x84BB21F7: //ChatInstantMessageToCharacter
			handleTellMessage(pack);
			break;
		case 0xD6D1B6D1: //ClientRandomNameRequest
			handleClientRandomNameRequest(pack);
			break;
		case 0x1A7AB839: //GetMapLocationsRequestMessage
			handleGetMapLocationsRequestMessage(pack);
			break;
		case 0x20E4DBE3: //ChatSendToRoom
			handleChatRoomMessage(pack);
			break;
		}

		break;
	case 6:
		switch(opcode) {
		case 0x25A29FA6: //	ChatPersistentMessageToServer
			handleSendMail(pack);
			break;
		}
		break;
	case 7:
		switch (opcode) {
		case 0x35366BED: //ChatCreateRoom
			handleChatCreateRoom(pack);
			break;
		case 0xAD47021D: //CreateAuctionMessage
			handleBazaarAddItem(pack, true);
			break;
		}

		break;
	case 8:
		switch (opcode) {
		case 0x1E9CE308: //CreateImmediateAuctionMessage
			handleBazaarAddItem(pack, false);
			break;
		}
		break;
	case 10:
		switch (opcode) {
		case 0x40E64DAC: //CreateTicketMessage
			handleCreateTicketMessage(pack);
			break;
		}
		break;
	case 12:
		switch (opcode) {
		case 0xB97F3074: //ClientCreateCharacter
			handleClientCreateCharacter(pack);
			break;
		}
		break;
	case 14:
		switch (opcode) {
		case 0x679E0D00: //AuctionQueryHeadersMessage
			handleBazaarScreens(pack);
			break;
		}
		break;
	default:
		//error("unhandled operand count" + pack->toString());
		break;
	}
}

void ZonePacketHandler::handleClientPermissionsMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	uint32 accountID = ClientIDMessage::parse(pack);
	client->setSessionKey(accountID);

	BaseMessage* cpm = new ClientPermissionsMessage();
	client->sendMessage(cpm);

}


void ZonePacketHandler::handleSelectCharacter(Message* pack) {
	PlayerManager* playerManager = server->getPlayerManager();

	ZoneClientSessionImplementation* clientimpl = (ZoneClientSessionImplementation*) pack->getClient();
	ZoneClientSession* client = (ZoneClientSession*) clientimpl->_getStub();

	uint64 characterID = SelectCharacter::parse(pack);
	uint64 playerID = (characterID << 32) + 0x15;

	Player* player = NULL;

	if (server->isServerLocked()) {
		if (!playerManager->hasAdminRights(characterID)) {
			ErrorMessage* msg = new ErrorMessage("Server", "Server is locked. Please try again later.", 0);
			client->sendMessage(msg);
			return;
		}
	}

	try {
		server->lock();

		SceneObject* obj = server->getObject(playerID, false);

		if (obj == NULL)
			obj = server->getCachedObject(playerID, false);

		if (obj != NULL) {
			if (!obj->isPlayer()) {
				server->unlock();
				return;
			}

			player = (Player*) obj;

			server->addObject(player, false);

			server->unlock();

			player->reload(client);

			playerManager->updatePlayerCreditsFromDatabase(player);
			playerManager->putPlayer(player);
		} else {
			player = playerManager->load(characterID);
			player->setZone(server->getZone(player->getZoneIndex()));

			server->addObject(player, false);

			server->unlock();

			try {
				player->wlock();

				player->load(client);

				player->unlock();
			} catch (...) {
				player->unlock();
			}
		}

		clientimpl->setLockName("ZoneClientSession = " + player->getFirstName());
	} catch (Exception& e) {
		System::out << "unreported exception caught in ZonePacketHandler::handleSelectCharacter(Message* pack)\n";
		e.printStackTrace();

		server->unlock();
	}
}

void ZonePacketHandler::handleCmdSceneReady(Message* pack) {
	info("ZonePacketHandler::handleCmdSceneReady");
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	BaseMessage* csr = new CmdSceneReady();
	client->sendMessage(csr);

	client->resetPacketCheckupTime();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	try {
		player->wlock();

		player->notifySceneReady();

		//If they are on the tutorial terrain, send audio.

		if (player->getZoneID() == 42) {
			TutorialAudioWelcomeEvent* tutorialStepWelcome = new TutorialAudioWelcomeEvent(player->getZone()->getPlanetManager(), player);
			TutorialAudioStatMigrationEvent* tutorialStepStatMigration = new TutorialAudioStatMigrationEvent(player->getZone()->getPlanetManager(), player);


			player->getZoneProcessServer()->addEvent(tutorialStepWelcome, 1000);
			player->getZoneProcessServer()->addEvent(tutorialStepStatMigration, 5000);
		}

		player->unlock();
	} catch (...) {
		player->unlock();
		System::out << "unreported exception on ZonePacketHandler::handleCmdSceneReady(Message* pack)\n";
	}
}

void ZonePacketHandler::handleClientCreateCharacter(Message* pack) {
	PlayerManager* playerManager = server->getPlayerManager();

	ZoneClientSessionImplementation* clientimpl = (ZoneClientSessionImplementation*) pack->getClient();
	ZoneClientSession* client = (ZoneClientSession*) clientimpl->_getStub();

	if (server->isServerLocked()) {
		ErrorMessage* msg = new ErrorMessage("Server", "Sever is locked. Please try again later.", 0);
		client->sendMessage(msg);

		return;
	}

	Player* player = new Player();
	player->initializePlayer();

	player->setZoneProcessServer(processServer);

	ClientCreateCharacter::parse(pack, player);

	player->create(client);

	String species = player->getStfName();
	String firstName = player->getFirstName();
	String name = player->getCharacterName().toString();

	player->info("attempting to create Player " + firstName);


	//Check name for invalid characters and profanity
	BaseMessage* msg = playerManager->checkPlayerName(name, species);

	try {
		server->lock();

		if (msg != NULL || (DistributedObjectBroker::instance()->lookUp("Player " + firstName) != NULL)) {
			if (msg == NULL)
				msg = new ClientCreateCharacterFailed("name_declined_in_use");

			server->unlock();
			client->sendMessage(msg);
			//player->disconnect();
			player->finalize();
			return;
		}

		player->deploy("Player " + firstName);

		server->unlock();

		msg = playerManager->attemptPlayerCreation(player, client);
		client->sendMessage(msg);
	} catch (Exception& e) {
		error(e.getMessage());
		server->unlock();
	} catch (...) {
		error("unreported exception caught in ZonePacketHandler::handleClientCreateCharacter(Message* pack)");
		server->unlock();
	}
}

void ZonePacketHandler::handleClientRandomNameRequest(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	NameManager* nameManager = processServer->getNameManager();

	String racefile;
	pack->parseAscii(racefile);

	bool notwook = (racefile.indexOf("wookie") == -1);

	BaseMessage* msg = new ClientRandomNameReponse(racefile, nameManager->makeCreatureName(notwook));
	client->sendMessage(msg);
}

void ZonePacketHandler::handleObjectControllerMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	uint32 header1 = pack->parseInt();
	uint32 header2 = pack->parseInt();

	/*StringBuffer msg;
	msg << "ObjectControllerMessage(0x" << hex << header1 << ", 0x" << header2 << dec << ")";
	player->info(msg.toString());*/

	try {
		player->wlock();

		if (!player->isOnline()) {
			player->unlock();
			return;
		}

		//System::out << "Header 1 = " << hex <<  header1 << "  Header 2 = " << header2 << endl;

		uint64 parent;

		switch (header1) {
		case 0x21:
			switch (header2) {
			case 0x71:
				//msg << "light chaging position (" << player->getPositionX() << ", " << player->getPositionY() << ") ->";

				if (ObjectControllerMessage::parseDataTransform(player, pack)) {
					player->updateZone(true);

					//player->info(msg);
				}

				break;
			case 0xF1:
				uint64 parent = ObjectControllerMessage::parseDataTransformWithParent(player, pack);

				if (parent != 0)
					player->updateZoneWithParent(parent, true);

				break;
			}
			break;
		case 0x23:
			switch (header2) {
			case 0x71:
				//msg << "chaging position (" << player->getPositionX() << ", " << player->getPositionY() << ") ->";

				if (ObjectControllerMessage::parseDataTransform(player, pack)) {
					player->updateZone();

					//player->info(msg);
				}

				break;
			case 0xF1:
				parent = ObjectControllerMessage::parseDataTransformWithParent(player, pack);

				if (parent != 0)
					player->updateZoneWithParent(parent);

				break;
			case 0x115:
				ObjectControllerMessage::parseItemDropTrade(player, pack);
				break;
			case 0x116:
				ObjectControllerMessage::parseCommandQueueEnqueue(player, pack, processServer);
				break;
			case 0x117:
				ObjectControllerMessage::parseCommandQueueClear(player, pack);
				break;
			case 0x146:
				ObjectControllerMessage::parseRadialRequest(player, pack, processServer->getRadialManager());
				break;
			case 0x238:
				ObjectControllerMessage::parseImageDesignChange(player, pack, processServer);
				break;
			case 0x239:
				ObjectControllerMessage::parseImageDesignCancel(player, pack);
				break;
			}
			break;
		case 0x83:
			switch (header2) {
			case 0xED:
				ObjectControllerMessage::parseResourceEmptyHopper(player, pack);
				break;
			case 0xF5:
				ObjectControllerMessage::parseMissionListRequest(player, pack);
				break;
			case 0xF9:
				ObjectControllerMessage::parseMissionAccept(player, pack);
				break;
			case 0x142:
				ObjectControllerMessage::parseMissionAbort(player, pack);
				break;
			case 0x106:
				ObjectControllerMessage::parseExperimentation(player, pack);
				break;
			case 0x107:
				ObjectControllerMessage::parseAddCraftingResource(player, pack);
				break;
			case 0x108:
				ObjectControllerMessage::parseRemoveCraftingResource(player, pack);
				break;
			case 0x126:
				ObjectControllerMessage::parseObjectTargetUpdate(player, pack);
				break;
			case 0x15A:
				ObjectControllerMessage::parseCraftCustomization(player, pack);
				break;
			}
			break;
		default:
			//msg << "unhandled ObjectControllerMessageHeader [" << header2 << "] " << pack->toString();
			//error(msg);
			break;
		}

		player->unlock();
	} catch (Exception& e) {
		player->unlock();

		System::out << "exception on ZonePacketHandler:::handleObjectControllerMessage(Message* pack)\n";
		e.printStackTrace();
	} catch (...) {
		player->unlock();

		System::out << "unreported exception on ZonePacketHandler:::handleObjectControllerMessage(Message* pack)\n";
	}
}

void ZonePacketHandler::handleTellMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	try {
		player->wlock();

		if (player->isOnline()) {
			ChatManager* chatManager = server->getChatManager();
			chatManager->handleTellMessage(player, pack);
		}

		player->unlock();
	} catch (...) {
		player->unlock();
		System::out << "unreported exception on ZonePacketHandler:::handleTellMessage(Message* pack)\n";
	}
}

void ZonePacketHandler::handleSendMail(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	//System::out << pack->toString() << "\n";

	UnicodeString header, body, wpName;
	int wpInfoSize = 0;
	uint32 planetCrc = 0;
	float wpX, wpY = 0.0f;
	String recipientName;

	pack->parseUnicode(body);

	//Handle Attachments: (see docs for more info on unk's)
	wpInfoSize = pack->parseInt();
	if(wpInfoSize > 0) {
		return;
		/*pack->shiftOffset(11); //Shift past the STF param start(7) + unk int(4)
		wpX = pack->parseFloat();
		pack->shiftOffset(4); //skip Z, always 0.0f
		wpY = pack->parseFloat();
		pack->shiftOffset(4); //skip blank WP objid
		planetCrc = pack->parseInt();
		pack->parseUnicode(wpName);
		pack->shiftOffset(11); //skip attachment footer*/
	}

	pack->shiftOffset(4); //skip the string count

	pack->parseUnicode(header); //mail subject
	pack->shiftOffset(4); //skip spacer

	pack->parseAscii(recipientName);

	ChatManager* chatManager = server->getChatManager();
	chatManager->sendMail(player->getFirstName(), header, body, recipientName);
}

void ZonePacketHandler::handleRequestPersistentMsg(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	pack->shiftOffset(4); //skip spacer/unk
	uint32 mailid = pack->parseInt();

	ChatManager* chatManager = server->getChatManager();
	chatManager->sendMailBody(player, mailid);
}

void ZonePacketHandler::handleDeletePersistentMsg(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	uint32 mailid = pack->parseInt();

	ChatManager* chatManager = server->getChatManager();
	chatManager->deleteMail(mailid);
}

void ZonePacketHandler::handleFactionRequestMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();
	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	try {
		player->wlock();
		FactionPointList * list = player->getFactionList();

		FactionResponseMessage* frm = new FactionResponseMessage("", player->getFactionPoints("rebel"), player->getFactionPoints("imperial"));

		frm->addFactionCount(list->size());
		for (int i=0; i < list->size(); i++) {
			String faction = list->get(i);
			frm->addFactionName(faction);
		}

		frm->addFactionCount(list->size());
		for (int i=0; i < list->size(); i++) {
			String faction = list->get(i);
			int points = player->getFactionPoints(faction);
			frm->addFactionPoint(points);
		}
		frm->insertInt(0); //Client crashes with more than one faction if this isn't included

		player->sendMessage(frm);

		player->unlock();
	} catch (...) {
		player->unlock();
		System::out << "unreported exception on ZonePacketHandler:::handleTellMessage(Message* pack)\n";
	}
}

void ZonePacketHandler::handleGetMapLocationsRequestMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	String planet;
    pack->parseAscii(planet);

	GetMapLocationsResponseMessage* gmlr = new GetMapLocationsResponseMessage(planet);

	try {
		ResultSet* result;
		StringBuffer query;
		query << "SELECT * FROM planetmap WHERE lower(planet) = '" << planet << "';";
		result = ServerDatabase::instance()->executeQuery(query);

		while (result->next()) {
			gmlr->addMapLocation(result->getInt(1),result->getString(2), result->getFloat(3), result->getFloat(4),
			(uint8)result->getInt(5), (uint8)result->getInt(6), (uint8)result->getInt(7));
		}

		delete result;

	} catch (DatabaseException& e) {
		System::out << e.getMessage() << "\n";

		return;
	}

	//gmlr->dumpLocationList();

	//these will be used for other locations on the planet map
	gmlr->addBlankList();
	gmlr->addBlankList();

	//unknown
	gmlr->addFooter();

	client->sendMessage(gmlr);
}

void ZonePacketHandler::handleStomachRequestMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();
	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	try {
		player->wlock();

		PlayerObjectDeltaMessage9* delta = new PlayerObjectDeltaMessage9(player->getPlayerObject());
		delta->updateStomachFilling();
		delta->close();

		player->sendMessage(delta);

		player->unlock();
	} catch (...) {
		player->error("unreported exception in ZonePacketHandler::handleStomachRequestMessage(Message* pack)");
		player->unlock();
	}
}

void ZonePacketHandler::handleGuildRequestMessage(Message* pack) {
    ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();
    Player* player = client->getPlayer();

	if (player == NULL)
		return;

	try {
		player->wlock();

   		uint64 objectid = pack->parseLong();

    	SceneObject* obj = player->getZone()->lookupObject(objectid);

    	if (obj == NULL) {
    		player->unlock();
    		return;
    	}

    	if (obj->isNonPlayerCreature() || obj->isPlayer()) {

    		CreatureObject* creo = (CreatureObject*) obj;

    		if (creo != player)
    			creo->wlock(player);

			GuildResponseMessage* grm = new GuildResponseMessage(creo, objectid);
			client->sendMessage(grm);

			if (creo != player)
				creo->unlock();
    	}

		player->unlock();
	} catch (...) {
		player->unlock();
		System::out << "unreported exception on ZonePacketHandler:::handleGuildRequest(Message* pack)\\\\\\\\n";
	}
}

void ZonePacketHandler::handlePlayerMoneyRequest(Message* pack) {
    ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();
	Player* player = client->getPlayer();

	if (player == NULL)
		return;

	try {
		player->wlock();

		PlayerMoneyResponseMessage* pmrm = new PlayerMoneyResponseMessage(player);
		client->sendMessage(pmrm);

		player->unlock();
	} catch (...) {
		player->unlock();
		System::out << "unreported exception on ZonePacketHandler:::handlePlayerMoneyRequest(Message* pack)\n";
	}
}

void ZonePacketHandler::handleTravelListRequest(Message* pack) {
    ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();
    Player* player = client->getPlayer();

    if (player == NULL)
    	return;


	uint64 objectid;
	objectid = pack->parseLong();
	String planet;
	pack->parseAscii(planet);

	int id = Planet::getPlanetID(planet);

	Zone* zone = server->getZone(id);

	if (zone != NULL) {
		PlanetManager* planetManager = zone->getPlanetManager();

		planetManager->sendPlanetTravelPointListResponse(player);
	}
}

void ZonePacketHandler::handleRadialSelect(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();
    Player* player = client->getPlayer();

    if (player == NULL)
		return;

    processServer->getRadialManager()->handleRadialSelect(player, pack);
}

void ZonePacketHandler::handleChatRoomMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	ChatManager* chatManager = server->getChatManager();
	chatManager->handleChatRoomMessage(player, pack);
}

void ZonePacketHandler::handleChatRequestRoomList(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	ChatManager* chatManager = server->getChatManager();
	chatManager->sendRoomList(player);
}

void ZonePacketHandler::handleChatCreateRoom(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	ChatManager* chatManager = server->getChatManager();
	chatManager->handleCreateRoom(player, pack);
}

void ZonePacketHandler::handleChatEnterRoomById(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	ChatManager* chatManager = server->getChatManager();
	chatManager->handleChatEnterRoomById(player, pack);
}

void ZonePacketHandler::handleChatDestroyRoom(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	ChatManager* chatManager = server->getChatManager();
	chatManager->handleChatDestroyRoom(player, pack);
}

void ZonePacketHandler::handleChatRemoveAvatarFromRoom(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	ChatManager* chatManager = server->getChatManager();
	chatManager->handleChatRemoveAvatarFromRoom(player, pack);
}

void ZonePacketHandler::handleSuiEventNotification(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();
	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	uint32 opcode = pack->parseInt();

	uint32 cancel = pack->parseInt();
	uint32 unk1 = pack->parseInt();
	uint32 unk2 = pack->parseInt();
	UnicodeString value;
	UnicodeString value2;

	if (unk2 != 0)
		pack->parseUnicode(value);
	if (unk2 > 1)
		pack->parseUnicode(value2);

	processServer->getSuiManager()->handleSuiEventNotification(opcode, player, cancel, value.toString(), value2.toString());
}

void ZonePacketHandler::handleAbortTradeMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();
	Player* player = client->getPlayer();

	if (player == NULL)
		return;

	server->getPlayerManager()->handleAbortTradeMessage(player);
}

void ZonePacketHandler::handleAddItemMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();
	Player* player = client->getPlayer();

	if (player == NULL)
		return;

	uint64 id = pack->parseLong();

	server->getPlayerManager()->handleAddItemToTradeWindow(player, id);
}

void ZonePacketHandler::handleGiveMoneyMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();
	Player* player = client->getPlayer();

	if (player == NULL)
		return;

	uint32 value = pack->parseInt();

	server->getPlayerManager()->handleGiveMoneyMessage(player, value);
}

void ZonePacketHandler::handleAcceptTransactionMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();
	Player* player = client->getPlayer();

	if (player == NULL)
		return;

	server->getPlayerManager()->handleAcceptTransactionMessage(player);
}

void ZonePacketHandler::handleUnAcceptTransactionMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();
	Player* player = client->getPlayer();

	if (player == NULL)
		return;

	server->getPlayerManager()->handleUnAcceptTransactionMessage(player);
}

void ZonePacketHandler::handleVerifyTradeMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();
	Player* player = client->getPlayer();

	if (player == NULL)
		return;

	server->getPlayerManager()->handleVerifyTradeMessage(player);
}

void ZonePacketHandler::handleBazaarAddItem(Message* pack, bool auction) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

   	 uint64 objectid = pack->parseLong(); // object for sale
   	 uint64 bazaarid = pack->parseLong(); // bazaar

   	uint32 price = pack->parseInt(); // Sale price
   	uint32 duration = pack->parseInt(); // How long to sell for in minutes

   	UnicodeString description;
   	pack->parseUnicode(description);

   	BazaarManager* bazaarManager = server->getBazaarManager();
   	bazaarManager->addSaleItem(player, objectid, bazaarid, description, price, duration, auction);
}

void ZonePacketHandler::handleBazaarScreens(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;
	//Bazaar screen requests
	int extent = pack->parseInt();
	// 0 - galaxy, 1 - planet, 2 - region, 3 - vendor
	int counter = pack->parseInt();
	int screen = pack->parseInt();
	// 2 - all items, 3 - my sales, 4 - my bids, 5 - available items,
	// 7 - for sale, 9 - offers to vendor
	uint32 category = pack->parseInt();  // Bitmask
	pack->shiftOffset(21);
	uint64 bazaarId = pack->parseLong();
	char unk1 = pack->parseByte();
	int offset = pack->parseShort();

   	BazaarManager* bazaarManager = server->getBazaarManager();
   	if (extent == 0)
   		bazaarManager->getBazaarData(player, bazaarId, screen, extent, category, counter, offset);
   	else if (extent == 1) {
   		BazaarPlanetManager* planetManager = bazaarManager->getPlanet(bazaarId);
   		planetManager->getBazaarData(player, bazaarId, screen, extent, category, counter, offset);
   	}
   	else if (extent == 2) {
   		RegionBazaar* bazaar = bazaarManager->getBazaar(bazaarId);
   		if (bazaar != NULL)
   			bazaar->getBazaarData(player, bazaarId, screen, extent, category, counter, offset);
   	}
}

void ZonePacketHandler::handleBazaarBuy(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	uint64 objectId = pack->parseLong();
	uint32 price1 = pack->parseInt();
	uint32 price2 = pack->parseInt();

   	BazaarManager* bazaarManager = server->getBazaarManager();
   	bazaarManager->buyItem(player, objectId, price1, price2);

}

void ZonePacketHandler::handleRetrieveAuctionItem(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	uint64 objectId = pack->parseLong();
	uint64 bazaarId = pack->parseLong();

   	BazaarManager* bazaarManager = server->getBazaarManager();
   	bazaarManager->retrieveItem(player, objectId, bazaarId);

}

void ZonePacketHandler::handleGetAuctionItemAttributes(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	uint64 objectId = pack->parseLong();

   	BazaarManager* bazaarManager = server->getBazaarManager();
   	bazaarManager->getItemAttributes(player, objectId);
}

void ZonePacketHandler::handleVerifyPlayerNameMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	UnicodeString name;
	uint32 mystery1;
	uint32 mystery2;
	pack->parseUnicode(name);
	mystery1 = pack->parseInt();
	mystery2 = pack->parseInt();

	//TODO: Write code here to check for player name in the Database.
	//TODO: Find out what that int is.
	VerifyPlayerNameResponseMessage* vpnrm = new VerifyPlayerNameResponseMessage(true, mystery1);
	client->sendMessage(vpnrm);

}

void ZonePacketHandler::handleConnectPlayerMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	ConnectPlayerResponseMessage* cprm = new ConnectPlayerResponseMessage();
	client->sendMessage(cprm);
}

void ZonePacketHandler::handleNewbieTutorialResponse(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	//The string is just "ClientReady" - meant to serve as a ClientReady for Tutorial
	String req;
	pack->parseAscii(req);

	NewbieTutorialRequest* ntr = new NewbieTutorialRequest(req);
	client->sendMessage(ntr);
}

void ZonePacketHandler::handleGetArticleMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	String articleid;
	bool foundarticle;
	String body;
	pack->parseAscii(articleid);

	 StringBuffer query;
	 query << "SELECT * FROM knowledgebase WHERE article_id = '" << articleid << "';";

		 try {
		   		ResultSet* result = ServerDatabase::instance()->executeQuery(query);

		   		while (result->next()) {
		   			foundarticle = true;
		   			body = result->getString(2);
		   			UnicodeString var(body);
		   		}

		   		delete result;
		   	} catch (DatabaseException& e) {
		   		error(e.getMessage());
		   		foundarticle = false;

		   	} catch (...) {
		   		error("unreported exception caught in PlanetManagerImplementation::loadStaticBuildings()\n");
		   		foundarticle = false;
		   	}
	//TODO:
		   	GetArticleResponseMessage* garm = new GetArticleResponseMessage(foundarticle);

		   	if (foundarticle == true) {
		   		garm->insertArticle(body);
		   	}

			client->sendMessage(garm);
}

void ZonePacketHandler::handleSearchKnowledgebaseMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	UnicodeString searchtext;
	String title;
	String articleid;
	bool foundarticle;

	pack->parseUnicode(searchtext);

	//Setup the message.
	SearchKnowledgebaseResponseMessage* kbrm = new SearchKnowledgebaseResponseMessage(false);

	StringBuffer query;
		 query << "SELECT * FROM knowledgebase WHERE article_title LIKE '%" << searchtext.toString() << "%';";

			 try {
			   		ResultSet* result = ServerDatabase::instance()->executeQuery(query);

			   		while (result->next()) {
			   			foundarticle = true;

			   			articleid = result->getString(0);
			   			title = result->getString(1);
			   			UnicodeString var(title);

			   			kbrm->addArticle(title, articleid);

			   		}

			   		delete result;
			   	} catch (DatabaseException& e) {
			   		error(e.getMessage());
			   		foundarticle = false;

			   	} catch (...) {
			   		error("unreported exception caught in PlanetManagerImplementation::loadStaticBuildings()\n");
			   		foundarticle = false;
			   	}

	//If we found an article, update the packet.
	if (foundarticle == true) {
		kbrm->updateFound(true);
	}

	client->sendMessage(kbrm);


}

void ZonePacketHandler::handleAppendCommentMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;


	//TODO: ADD RESPONSE.
}

void ZonePacketHandler::handleGetCommentsMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;


	//TODO: ADD RESPONSE.
}

void ZonePacketHandler::handleCreateTicketMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	//TODO: I don't know!

	//Ok. Lets first create all the vars to hold this crap.
	String playerName;
	uint32 bugMainCategoryID;
	uint32 bugSubCategoryID;
	pack->parseAscii(playerName);
	bugMainCategoryID = pack->parseInt();
	bugSubCategoryID = pack->parseInt();

	//GIANT UNICODE STRING
	UnicodeString giantUnicode;
	pack->parseUnicode(giantUnicode);

	String str = giantUnicode.toString();
	//System::out << str;

    /*
	StringTokenizer st = new StringTokenizer(str, "a");

	//Here is where we seperate everything by 0xA
	string stationid; //convert to uint64?
	string bugtype;
	string repeatable;
	string gameSystem;
	string severity;
	string positionX; // convert to float?
	string positionY; // convert to float?
	string positionZ; // convert to float?
	string heading;
	string planet;
	string cluster;
	string character;
	string race;
	string clientVersion;
	string dateAndTime;
	string additionalInfo;

	*/
	CreateTicketResponseMessage* ctrm = new CreateTicketResponseMessage(true);
	player->sendMessage(ctrm);
}

void ZonePacketHandler::handleGetTicketsMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	//TODO: Pull tickets from the database.
	GetTicketsResponseMessage* gtrm = new GetTicketsResponseMessage();
	gtrm->addTicket("test name", "test body", 31337, 0x85, false, false);
	client->sendMessage(gtrm);
}

void ZonePacketHandler::handleNewTicketActivityMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	uint32 ticketid;
	ticketid = pack->parseInt();

	NewTicketActivityResponseMessage* ntar = new NewTicketActivityResponseMessage(0,ticketid);
	client->sendMessage(ntar);
}

void ZonePacketHandler::handleRequestCategoriesMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	//Make sure the client is actually sending this. Then add support
	String lang;
	//lang = pack->parseAscii(); //should be "en"

	RequestCategoriesResponseMessage* rcrm = new RequestCategoriesResponseMessage();
	rcrm->addMainCategory("Account/Billing", 0xB808, 1, 1, 1);
	client->sendMessage(rcrm);
}

void ZonePacketHandler::handleClientInactivityMessage(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	byte flag;
	flag = pack->parseByte();

	//TODO: Put code here to set player AFK.
}

void ZonePacketHandler::handleCommoditiesItemTypeListRequest(Message* pack) {
	ZoneClientSessionImplementation* client = (ZoneClientSessionImplementation*) pack->getClient();

	Player* player = client->getPlayer();
	if (player == NULL)
		return;

	String request;
	pack->parseAscii(request);

	//TODO: Rework this. Right now sending blank list.
	CommoditiesItemTypeListResponse* citlr = new CommoditiesItemTypeListResponse();
	player->sendMessage(citlr);
}


