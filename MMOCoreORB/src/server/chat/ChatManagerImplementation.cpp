/*
 * ChatManagerImplementation.cpp
 *
 *  Created on: 28/07/2009
 *      Author: victor
 */

#include "ChatManager.h"
#include "server/zone/ZoneServer.h"
#include "server/zone/Zone.h"
#include "server/zone/managers/player/PlayerManager.h"
#include "server/zone/managers/player/PlayerMap.h"
#include "server/zone/managers/object/ObjectManager.h"
#include "server/zone/packets/chat/ChatRoomList.h"
#include "server/zone/packets/chat/ChatRoomMessage.h"
#include "server/zone/packets/object/SpatialChat.h"
#include "server/zone/packets/object/Emote.h"
#include "server/zone/packets/chat/ChatInstantMessageToCharacter.h"
#include "server/zone/packets/chat/ChatInstantMessageToClient.h"
#include "server/zone/packets/chat/ChatOnSendInstantMessage.h"
#include "server/zone/packets/chat/ChatOnSendRoomMessage.h"
#include "server/zone/packets/chat/ChatOnDestroyRoom.h"
#include "server/zone/packets/chat/ChatPersistentMessageToClient.h"
#include "server/zone/objects/group/GroupObject.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/chat/StringIdChatParameter.h"
#include "PersistentMessage.h"
#include "server/zone/managers/objectcontroller/ObjectController.h"

#include "room/ChatRoom.h"
#include "room/ChatRoomMap.h"
#include "server/zone/objects/terrain/PlanetNames.h"

ChatManagerImplementation::ChatManagerImplementation(ZoneServer* serv, int initsize) : ManagedServiceImplementation() {
	server = serv;

	//userManager = server->getUserManager();

	playerManager = NULL;
	//guildManager = playerManager->getGuildManager();

	//resourceManager = server->getResourceManager();

	ObjectDatabaseManager::instance()->loadDatabase("mail", true);

	playerMap = new PlayerMap(initsize);
	//playerMap->deploy("ChatPlayerMap");

	roomMap = new ChatRoomMap(10000);

	mute = false;

	roomID = 0;

	setLoggingName("ChatManager");

	//gameRooms = new VectorMap<String, ManagedReference<ChatRoom*> >();

	//gameCommandHandler = new GameCommandHandler();
}

void ChatManagerImplementation::finalize() {
	delete playerMap;
	playerMap = NULL;

	delete roomMap;
	roomMap = NULL;
}

ChatRoom* ChatManagerImplementation::createRoom(const String& roomName, ChatRoom* parent) {
	ManagedReference<ChatRoom*> room = (ChatRoom*) ObjectManager::instance()->createObject("ChatRoom", 0 , "");
	room->init(server, parent, roomName, getNextRoomID());

	addRoom(room);

	return room;
}

void ChatManagerImplementation::initiateRooms() {
	gameRooms.setNullValue(NULL);

	ChatRoom* mainRoom = createRoom("SWG");
	mainRoom->setPrivate();
	gameRooms.put("SWG", mainRoom);

	ChatRoom* core3Room = createRoom(server->getServerName(), mainRoom);
	core3Room->setPrivate();
	mainRoom->addSubRoom(core3Room);

	groupRoom = createRoom("group", core3Room);
	groupRoom->setPrivate();
	core3Room->addSubRoom(groupRoom);

	guildRoom = createRoom("guild", core3Room);
	guildRoom->setPrivate();
	core3Room->addSubRoom(guildRoom);

	ChatRoom* generalRoom = createRoom("general", core3Room);
	core3Room->addSubRoom(generalRoom);

	// Planet Chat
	for (int i = 0; i < server->getZoneCount(); ++i) {
		ManagedReference<Zone*> zone = server->getZone(i);

		if (zone == NULL)
			continue;

		ChatRoom* planetRoom = createRoom(Planet::getPlanetName(i), core3Room);
		core3Room->addSubRoom(planetRoom);

		ChatRoom* planetaryChat = createRoom("chat", planetRoom);
		planetRoom->addSubRoom(planetaryChat);
	}
}

ChatRoom* ChatManagerImplementation::createRoomByFullPath(const String& path) {
	StringTokenizer tokenizer(path);
	tokenizer.setDelimeter(".");

	String game;
	tokenizer.getStringToken(game);

	ChatRoom* gameRoom = getGameRoom(game);

	if (gameRoom == NULL)
		return NULL;

	String channel;

	ChatRoom* room = gameRoom;
	while (tokenizer.hasMoreTokens()) {
		tokenizer.getStringToken(channel);

		if (room->getSubRoom(channel) == NULL)
			break;
		else
			room = room->getSubRoom(channel);
	}

	if (room == gameRoom)
		return NULL;

	if (room->isPrivate())
		return NULL;

	ChatRoom* newRoom = createRoom(channel, room);
	room->addSubRoom(newRoom);

	return newRoom;
}

ChatRoom* ChatManagerImplementation::getChatRoomByGamePath(ChatRoom* game, const String& path) {
	StringTokenizer tokenizer(path);
	tokenizer.setDelimeter(".");

	String channel;
	ChatRoom* room = game;

	while (tokenizer.hasMoreTokens()) {
		tokenizer.getStringToken(channel);

		room = room->getSubRoom(channel);
		if (room == NULL)
			return NULL;
	}

	if (room == game)
		return NULL;
	else
		return room;
}

ChatRoom* ChatManagerImplementation::getChatRoomByFullPath(const String& path) {
	StringTokenizer tokenizer(path);
	tokenizer.setDelimeter(".");

	if (!tokenizer.hasMoreTokens())
		return NULL;

	String game;
	tokenizer.getStringToken(game);

	ChatRoom* gameRoom = getGameRoom(game);

	if (gameRoom == NULL)
		return NULL;

	String gamePath;
	tokenizer.finalToken(gamePath);

	return getChatRoomByGamePath(gameRoom, gamePath);
}


void ChatManagerImplementation::destroyRooms() {
	Locker _locker(_this);

	roomMap->resetIterator();

	while (roomMap->hasNext()) {
		ChatRoom* room = roomMap->next();
		room->finalize();
	}

	roomMap->removeAll();

	gameRooms.removeAll();
}

void ChatManagerImplementation::populateRoomListMessage(ChatRoom* channel, ChatRoomList* msg) {
	if (channel->isPublic())
		msg->addChannel(channel);

	for (int i = 0; i < channel->getSubRoomsSize(); i++) {
		ChatRoom* chan = channel->getSubRoom(i);

		populateRoomListMessage(chan, msg);
	}
}

void ChatManagerImplementation::handleChatRoomMessage(PlayerCreature* sender, const UnicodeString& message, unsigned int roomID, unsigned int counter) {
	/*if (sender->isChatMuted() && !sender->isPrivileged()) {
		sender->sendSystemMessage("Your chat abilities are currently disabled by the server administrators.");
		return;
	}*/

	String name = sender->getFirstName();

	ChatRoom* channel = getChatRoom(roomID);

	if (channel == NULL)
		return;

	if (!channel->hasPlayer(sender))
		return;

	BaseMessage* msg = new ChatRoomMessage(name, message, roomID);
	channel->broadcastMessage(msg);

	BaseMessage* amsg = new ChatOnSendRoomMessage(counter);
	channel->broadcastMessage(amsg);

	/*Vector<Message*> messages;
	messages.add(msg);
	messages.add(amsg);

	channel->broadcastMessage(messages);*/
}

void ChatManagerImplementation::handleChatEnterRoomById(PlayerCreature* player, uint32 counter, uint32 roomID) {
	ManagedReference<ChatRoom*> room = getChatRoom(roomID);

	if (room == NULL)
		return;

	room->addPlayer(player);
}

void ChatManagerImplementation::handleSocialInternalMessage(CreatureObject* sender, const UnicodeString& arguments) {
	Zone* zone = sender->getZone();

	if (zone == NULL)
		return;

	StringTokenizer tokenizer(arguments.toString());
	uint64 targetid;
	uint32 emoteid, unkint, unkint2;

	try {
		targetid = tokenizer.getLongToken();
		emoteid = tokenizer.getIntToken();
		unkint = tokenizer.getIntToken();
		unkint2 = tokenizer.getIntToken();
	} catch (...) {
		return;
	}

	Locker _zone(zone);

	bool showtext = true;

	if (unkint2 == 0)
		showtext = false;

	String firstName;

	if (sender->isPlayerCreature())
		firstName = ((PlayerCreature*)sender)->getFirstName();

	for (int i = 0; i < sender->inRangeObjectCount(); ++i) {
		SceneObject* object = (SceneObject*) (((SceneObjectImplementation*) sender->getInRangeObject(i))->_this);

		if (object->isPlayerCreature()) {
			PlayerCreature* creature = (PlayerCreature*) object;

			PlayerObject* ghost = (PlayerObject*) creature->getSlottedObject("ghost");

			if (ghost == NULL)
				continue;

			if (!ghost->isIgnoring(firstName) && creature->isInRange(sender, 128)) {
				Emote* emsg = new Emote(creature, sender, targetid,
						emoteid, showtext);
				creature->sendMessage(emsg);
			}
		}
	}

}

void ChatManagerImplementation::sendRoomList(PlayerCreature* player) {
	ChatRoomList* crl = new ChatRoomList();

	String game = "SWG";
	populateRoomListMessage(gameRooms.get(game), crl);

 	crl->insertChannelListCount();
 	player->sendMessage(crl);
}

void ChatManagerImplementation::addPlayer(PlayerCreature* player) {
	Locker _locker(_this);

	String name = player->getFirstName().toLowerCase();
	playerMap->put(name, player, false);
}

PlayerCreature* ChatManagerImplementation::getPlayer(const String& name) {
	Locker _locker(_this);

	PlayerCreature* player = NULL;

	try {
		String lName = name.toLowerCase();

		player = playerMap->get(lName, false);
	} catch (Exception& e) {
		System::out << e.getMessage();
		e.printStackTrace();
	} catch (...) {
		System::out << "unreported exception caught in ChatManagerImplementation::getPlayer";
	}

	return player;
}

PlayerCreature* ChatManagerImplementation::removePlayer(const String& name) {
	Locker _locker(_this);

	String lName = name.toLowerCase();

	PlayerCreature* player = playerMap->remove(lName, false);

	return player;
}

void ChatManagerImplementation::broadcastGalaxy(PlayerCreature* player, const String& message) {
	String firstName = "SKYNET";

	if (player != NULL)
		firstName = player->getFirstName();

	StringBuffer fullMessage;
	fullMessage << "[" << firstName << "] " << message;

	Locker locker(_this);
	//playerMap->lock();

	playerMap->resetIterator(false);

	while (playerMap->hasNext(false)) {
		ManagedReference<PlayerCreature*> playerObject = playerMap->getNextValue(false);

		playerObject->sendSystemMessage(fullMessage.toString());
	}

}

void ChatManagerImplementation::broadcastMessage(BaseMessage* message) {
	Locker _lock(_this);

	playerMap->resetIterator(false);

	while (playerMap->hasNext(false)) {
		ManagedReference<PlayerCreature*> player = playerMap->getNextValue(false);

		if (player == NULL || !player->isOnline())
			continue;

		player->sendMessage(message->clone());
	}

	delete message;
	message = NULL;
}

void ChatManagerImplementation::broadcastMessage(CreatureObject* player, const UnicodeString& message,  uint64 target, uint32 moodid, uint32 mood2) {
	if (player->isPlayerCreature() /*|| !((Player *)player)->isChatMuted() */) {
		PlayerCreature* playerCreature = (PlayerCreature*) player;
		Zone* zone = player->getZone();

		/*if (message.toCharArray() == "LAG") {
			ZoneClientSession* client = player->getClient();

			client->reportStats(true);

			Logger::slog("Client (" + client->getAddress() + ") is experiencing lag", true);
			return;
		} else if (message.toCharArray() == "QUEUE") {
			ZoneClientSession* client = player->getClient();

			client->reportStats(true);

			Logger::slog("Client (" + client->getAddress() + ") is experiencing queue lag", true);
			return;
		}*/

		if (zone == NULL)
			return;

		String firstName = playerCreature->getFirstName().toLowerCase();
		PlayerObject* myGhost = playerCreature->getPlayerObject();

		if (myGhost == NULL)
			return;

		//Locker zoneLocker(zone);
		zone->rlock();

		try {

			for (int i = 0; i < player->inRangeObjectCount(); ++i) {
				SceneObject* object = (SceneObject*) (((SceneObjectImplementation*) player->getInRangeObject(i))->_this);

				if (object->isPlayerCreature()) {
					PlayerCreature* creature = (PlayerCreature*) object;

					if (player->isInRange(creature, 128)) {

						PlayerObject* ghost = creature->getPlayerObject();

						if (ghost == NULL)
							continue;

						if (!ghost->isIgnoring(firstName)) {
							SpatialChat* cmsg = new SpatialChat(player->getObjectID(), creature->getObjectID(), message, target, moodid, mood2, myGhost->getLanguageID());
							creature->sendMessage(cmsg);
						}
					}
				}
			}
		} catch (...) {

		}

		zone->runlock();

	}
}

void ChatManagerImplementation::handleSpatialChatInternalMessage(PlayerCreature* player, const UnicodeString& args) {
	try {
		UnicodeTokenizer tokenizer(args);

		uint64 targetid = tokenizer.getLongToken();
		uint32 mood2 = tokenizer.getIntToken();
		uint32 moodid = tokenizer.getIntToken();
		uint32 unk2 = tokenizer.getIntToken();
		uint32 unk3 = tokenizer.getIntToken();

		UnicodeString msg;

		tokenizer.finalToken(msg);

		/*if (msg[0] == '@') {
			handleGameCommand(player, msg.toString());
		} else {
			if (isMute()) {
				if (player->getAdminLevel() & PlayerImplementation::ADMIN) {
					broadcastMessage(player, msg, targetid, moodid, mood2);
				} else {
					((CreatureObject*) player)->sendSystemMessage("Chat has been muted by the admins");
				}
			} else {
				broadcastMessage(player, msg, targetid, moodid, mood2);
			}
		}*/
		broadcastMessage(player, msg, targetid, moodid, mood2);

	} catch (Exception& e) {
		StringBuffer msg;
		msg << "Exception in ChatManagerImplementation::handleMessage " << e.getMessage() << "\n";
		System::out << msg.toString();
		e.printStackTrace();
	} catch (...) {
		System::out << "unreported exception caught in ChatManagerImplementation::handleMessage\n";
	}
}

void ChatManagerImplementation::handleChatInstantMessageToCharacter(ChatInstantMessageToCharacter* message) {
	ManagedReference<PlayerCreature*> sender = (PlayerCreature*) message->getClient()->getPlayer();

	if (sender == NULL)
		return;

	PlayerCreature* receiver = getPlayer(message->getName());

	if (receiver == NULL || !receiver->isOnline()) {
		BaseMessage* amsg = new ChatOnSendInstantMessage(message->getSequence(), true);
		sender->sendMessage(amsg);

		return;
	}

	BaseMessage* msg = new ChatInstantMessageToClient(message->getGame(), message->getGalaxy(), sender->getFirstName(), message->getMessage());
	receiver->sendMessage(msg);

	BaseMessage* amsg = new ChatOnSendInstantMessage(message->getSequence(), false);
	sender->sendMessage(amsg);
}

ChatRoom* ChatManagerImplementation::createGroupRoom(uint64 groupID, PlayerCreature* creator) {
	// Pre: creator locked;
	// Post: creator locked.

	ManagedReference<ChatRoom*> groupChatRoom;

	StringBuffer name;
	name << groupID;

	ChatRoom* newGroupRoom = createRoom(name.toString(), groupRoom);
	newGroupRoom->setPrivate();
	groupRoom->addSubRoom(newGroupRoom);

	groupChatRoom = createRoom("GroupChat", newGroupRoom);

	groupChatRoom->setTitle(name.toString());
	groupChatRoom->setPrivate();

	groupChatRoom->sendTo(creator);
	groupChatRoom->addPlayer(creator, false);

	newGroupRoom->addSubRoom(groupChatRoom);

	return groupChatRoom;
}

void ChatManagerImplementation::destroyRoom(ChatRoom* room) {
	Locker _locker(_this);

	ChatOnDestroyRoom* msg = new ChatOnDestroyRoom("SWG", server->getServerName(), room->getRoomID());
	room->broadcastMessage(msg);
	room->removeAllPlayers();

	ManagedReference<ChatRoom*> parent = room->getParent();

	if (parent != NULL)
		parent->removeSubRoom(room);

	roomMap->remove(room->getRoomID());
}


void ChatManagerImplementation::handleGroupChat(PlayerCreature* sender, const UnicodeString& message) {
	/*if (sender->isChatMuted()) {
		sender->sendSystemMessage("Your chat abilities are currently disabled by the server administrators.");
		return;
	}*/

	String name = sender->getFirstName();

	ManagedReference<GroupObject*> group = sender->getGroup();
	if (group == NULL)
		return;

	sender->unlock();

	try {
		group->wlock();

		ManagedReference<ChatRoom*> room = group->getGroupChannel();

		if (room != NULL) {
			BaseMessage* msg = new ChatRoomMessage(name, message, room->getRoomID());
			group->broadcastMessage(msg);
		}

		group->unlock();
	} catch (...) {
		System::out << "Exception in ChatManagerImplementation::handleGroupChat(Player* sender, Message* pack)\n";
		group->unlock();
	}

	sender->wlock();
}

void ChatManagerImplementation::sendMail(const String& sendername, const UnicodeString& header, const UnicodeString& body, const String& name) {
	uint64 receiverObjectID = playerManager->getObjectID(name);

	Time expireTime;
	uint64 currentTime = expireTime.getMiliTime() / 1000;

	if (receiverObjectID == 0) {
		error("unexistent name for persistent message");
		return;
	}

	ManagedReference<SceneObject*> receiver = server->getObject(receiverObjectID);

	if (receiver == NULL) {
		error("NULL receiver in send mail");

		return;
	}

	if (!receiver->isPlayerCreature()) {
		error("not player in send mail");

		return;
	}

	PlayerCreature* player = (PlayerCreature*) receiver.get();

	/*StringIdChatParameter test("base_player", "sale_fee");
	test.setDI(100);
	test.setUnknownByte(1);*/

	ManagedReference<PersistentMessage*> mail = new PersistentMessage();
	mail->setSenderName(sendername);
	mail->setSubject(header);
	mail->setBody(body);
	//mail->setParameterizedBody(test);
	mail->setReceiverObjectID(receiverObjectID);
	mail->setTimeStamp(currentTime);

	ObjectManager::instance()->persistObject(mail, 1, "mail");

	Locker _locker(player);

	player->addPersistentMessage(mail->getObjectID());

	if (player->isOnline())
		mail->sendTo(player, true);

	player->updateToDatabase();
}

int ChatManagerImplementation::sendMail(const String& sendername, const UnicodeString& subject, StringIdChatParameter& body, const String& recipientName) {
	uint64 receiverObjectID = playerManager->getObjectID(recipientName);

	ManagedReference<SceneObject*> obj = server->getObject(receiverObjectID);

	if (obj == NULL || !obj->isPlayerCreature())
		return IM_OFFLINE;

	if (body.getCustomString().length() > PM_MAXSIZE)
		return IM_TOOLONG;

	PlayerCreature* receiver = (PlayerCreature*) obj.get();

	if (receiver->getPlayerObject()->isIgnoring(sendername))
		return IM_IGNORED;

	ManagedReference<PersistentMessage*> mail = new PersistentMessage();
	mail->setSenderName(sendername);
	mail->setSubject(subject);
	mail->addChatParameter(body);
	mail->setReceiverObjectID(receiverObjectID);

	ObjectManager::instance()->persistObject(mail, 1, "mail");

	Locker _locker(receiver);

	receiver->addPersistentMessage(mail->getObjectID());

	if (receiver->isOnline())
		mail->sendTo(receiver, false);

	receiver->updateToDatabase();

	return IM_SUCCESS;
}

void ChatManagerImplementation::loadMail(PlayerCreature* player) {
	Locker _locker(player);

	SortedVector<uint64>* messages = player->getPersistentMessages();

	for (int i = 0; i < messages->size(); ++i) {
		uint64 messageObjectID = messages->get(i);

		ManagedReference<PersistentMessage*> mail = (PersistentMessage*) DistributedObjectBroker::instance()->lookUp(messageObjectID);

		if (mail == NULL) {
			messages->drop(messageObjectID);
			continue;
		}

		mail->sendTo(player, false);
	}
}

void ChatManagerImplementation::handleRequestPersistentMsg(PlayerCreature* player, uint32 mailID) {
	Locker _locker(player);

	SortedVector<uint64>* messages = player->getPersistentMessages();

	uint64 messageObjectID = -1;

	for (int i = 0; i < messages->size(); ++i) {
		messageObjectID = messages->get(i);

		if (Long::hashCode(messageObjectID) == mailID)
			break;
	}

	if (messageObjectID == -1) {
		error("could not find mail in handleRequestPersistentMsg");
		return;
	}

	ManagedReference<PersistentMessage*> mail = (PersistentMessage*) DistributedObjectBroker::instance()->lookUp(messageObjectID);

	if (mail == NULL) {
		messages->drop(messageObjectID);
		return;
	}

	_locker.release();

	mail->setStatus('R');
	mail->sendTo(player, true);
}

void ChatManagerImplementation::deletePersistentMessage(PlayerCreature* player, uint32 mailID) {
	Locker _locker(player);

	SortedVector<uint64>* messages = player->getPersistentMessages();

	uint64 messageObjectID = -1;

	for (int i = 0; i < messages->size(); ++i) {
		messageObjectID = messages->get(i);

		if (Long::hashCode(messageObjectID) == mailID)
			break;
	}

	if (messageObjectID == -1) {
		error("could not find mail in deletePersistentMessage");
		return;
	}

	messages->drop(messageObjectID);

	_locker.release();

	ObjectManager::instance()->destroyObjectFromDatabase(messageObjectID);
}
