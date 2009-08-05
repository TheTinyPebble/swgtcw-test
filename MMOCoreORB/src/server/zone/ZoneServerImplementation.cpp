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

#include "ZoneServer.h"

#include "ZoneClientSession.h"

#include "Zone.h"

#include "../db/ServerDatabase.h"

#include "managers/object/ObjectManager.h"
#include "managers/player/PlayerManager.h"

#include "server/chat/ChatManager.h"

#include "ZoneProcessServerImplementation.h"

ZoneServerImplementation::ZoneServerImplementation(int processingThreads, int galaxyid) :
		ManagedObjectImplementation(), DatagramServiceThread("ZoneServer") {
	galaxyID = galaxyid;

	name = "Core3";

	phandler = NULL;

	processor = NULL;
	procThreadCount = processingThreads;

	objectManager = NULL;
	playerManager = NULL;
	chatManager = NULL;

	totalSentPackets = 0;
	totalResentPackets = 0;

	currentPlayers = 0;
	maximumPlayers = 0;
	totalPlayers = 0;
	totalDeletedPlayers = 0;

	nextCreatureID = 0x10000000;
	nextCellID = 9995371; // last objectid in static objects // 0x00;

	serverState = OFFLINE;

	setLogging(false);
	DatagramServiceThread::setLockName("ZoneServerLock");

	taskManager->setLogging(false);

	zones = new Vector<Zone*>();
}

void ZoneServerImplementation::start(int a, int b) {
	DatagramServiceThread::start(a, b);
}

void ZoneServerImplementation::stop() {
	DatagramServiceThread::stop();
}

void ZoneServerImplementation::lock() {
	DatagramServiceThread::lock();
}

void ZoneServerImplementation::unlock() {
	DatagramServiceThread::unlock();
}

void ZoneServerImplementation::lock(bool doLock) {
	DatagramServiceThread::lock(doLock);
}

void ZoneServerImplementation::unlock(bool doLock) {
	DatagramServiceThread::unlock(doLock);
}

String ZoneServerImplementation::getServerName() {
	return name;
}

void ZoneServerImplementation::setServerName(const String& na) {
	name = na;
}

void ZoneServerImplementation::setServerStateLocked() {
	lock();

	serverState = LOCKED;

	StringBuffer msg;
	msg << dec << "server locked";
	info(msg, true);

	unlock();
}

void ZoneServerImplementation::setServerStateOnline() {
	lock();

	serverState = ONLINE;

	StringBuffer msg;
	msg << dec << "server unlocked";
	info(msg, true);

	unlock();
}

String ZoneServerImplementation::getMessageoftheDay() {
	return messageoftheDay;
}

void ZoneServerImplementation::loadMessageoftheDay() {
	lock();

	File* file;
	FileReader* reader;

	try {
		file = new File("motd.txt");
		reader = new FileReader(file);

		String line;
		while(reader->readLine(line)) {
			messageoftheDay += line;
		}

		reader->close();
	} catch (FileNotFoundException& e) {
		file = NULL;
		reader = NULL;
	}

	unlock();
}

void ZoneServerImplementation::changeMessageoftheDay(const String& newMOTD) {
	lock();

	File* file;
	FileWriter* writer;

	String finalMOTD = "";

	try {
		file = new File("motd.txt");
		writer = new FileWriter(file);

		for(int i = 0; i < newMOTD.length(); i++) {
			if(i+1 < newMOTD.length()) {
				char currentLetter = newMOTD.charAt(i);
				char nextLetter = newMOTD.charAt(i+1);
				if(currentLetter == '\\' && nextLetter == 'n') {
					finalMOTD += "\n";
					i++;
				} else {
					finalMOTD += currentLetter;
				}
			} else {
				finalMOTD += newMOTD.charAt(i);
			}
		}

		writer->write(finalMOTD);

		writer->close();
	} catch (FileNotFoundException& e) {
		file = NULL;
		writer = NULL;
	}

	messageoftheDay = finalMOTD;

	unlock();
}

/*ZoneServerImplementation::~ZoneServerImplementation() {
	if (missionManager != NULL) {
		missionManager->finalize();
		missionManager = NULL;
	}

	if (phandler != NULL) {
		delete phandler;
		phandler = NULL;
	}

	if (processor != NULL) {
		delete processor;
		processor = NULL;
	}

	if (itemManager != NULL) {
		itemManager->finalize();
		itemManager = NULL;
	}

	if (itemConfigManager != NULL) {
		itemConfigManager->finalize();
		itemConfigManager = NULL;
	}

	if (bazaarManager != NULL) {
		bazaarManager->finalize();
		bazaarManager = NULL;
	}

	if (objectManager != NULL) {
		delete objectManager;
		objectManager = NULL;
	}

	if (userManager != NULL) {
		userManager->finalize();
		userManager = NULL;
	}

	if (playerManager != NULL) {
		playerManager->finalize();
		playerManager = NULL;
	}

	if (guildManager != NULL) {
		guildManager->finalize();
		guildManager = NULL;
	}

	if (resourceManager != NULL) {
		resourceManager->finalize();
		resourceManager = NULL;
	}

	if (lootTableManager != NULL) {
		lootTableManager->finalize();
		lootTableManager = NULL;
	}

	if (craftingManager != NULL) {
		craftingManager->finalize();
		craftingManager = NULL;
	}

	if (bankManager != NULL) {
		bankManager->finalize();
		bankManager = NULL;
	}

	if (chatManager != NULL) {
		chatManager->finalize();
		chatManager = NULL;
	}

	for (int i = 0; i < 45; ++i) {
		Zone* zone = zones.get(i);

		if (zone != NULL)
			zone->finalize();
	}

	zones.removeAll();
}*/

void ZoneServerImplementation::init() {
	serverState = LOADING;

	//Load the galaxy name from the galaxy table.
	try {
		info("Loading galaxy name from the database.");
		String query = "SELECT name FROM galaxy WHERE galaxy_id = " + galaxyID;
		ResultSet* result = ServerDatabase::instance()->executeQuery(query);

		if (result->next())
			name = result->getString(0);

		delete result;

	} catch (DatabaseException& e) {
		info("Unhandled exception when getting galaxy name from database.");
	} catch (...) {
		info("Unhandled exception initializing galaxy name.");
	}

	processor = new ZoneProcessServerImplementation(_this, procThreadCount);
	processor->init();

	objectManager = ObjectManager::instance();
	objectManager->setZoneProcessServerImplementation(processor);

	phandler = new BasePacketHandler("ZoneServer", processor->getMessageQueue());
	phandler->setLogging(false);

	info("Initializing zones", true);

	for (int i = 0; i < 45; ++i) {
		Zone * zone;

		if (i > 10 && i != 42) {
			zone = NULL;
		} else {
			zone = new Zone(_this, processor, i);
			zone->deploy("Zone", i);

			zone->startManagers();
		}

		zones->add(zone);
	}

	startManagers();
/*
	userManager = NULL;
	itemManager = NULL;
	itemConfigManager = NULL;
	playerManager = NULL;
	guildManager = NULL;
	resourceManager = NULL;
	lootTableManager = NULL;
	bazaarManager = NULL;
	bankManager = NULL;
	chatManager = NULL;

	startManagers();

	loadMessageoftheDay();*/

	//startTimestamp = time(NULL);

	//serverState = LOCKED;
	serverState = ONLINE; //Test Center does not need to apply this change, but would be convenient for Dev Servers.

	return;
}

void ZoneServerImplementation::startManagers() {
	info("loading managers..");

	playerManager = new PlayerManager(objectManager, processor);
	playerManager->deploy("PlayerManager");

	chatManager = new ChatManager(_this, 10000);
	chatManager->deploy("ChatManager");
	chatManager->initiateRooms();

	/*userManager = new UserManager(_this);
	userManager->deploy("UserManager");

	itemManager = new ItemManager(_this, processor);
	itemManager->deploy("ItemManager");

	itemConfigManager = new ItemConfigManager();
	itemConfigManager->deploy("ItemConfigManager");

	guildManager = new GuildManager(_this);
	guildManager->deploy("GuildManager");

	guildManager->load();
	playerManager->setGuildManager(guildManager);

	resourceManager = new ResourceManager(_this, processor);
	resourceManager->deploy("ResourceManager");

	lootTableManager = new LootTableManager(_this, processor);
	lootTableManager->deploy("LootTableManager");

	craftingManager = new CraftingManager(_this, processor);
	craftingManager->deploy("CraftingManager");



	bazaarManager = new BazaarManager(_this, processor);
	bazaarManager->deploy("BazaarManager");

	bankManager = new BankManager(_this, processor);
	bankManager->deploy("BankManager");

	missionManager = new MissionManager(_this, processor);
	missionManager->deploy("MissionManager");*/
}

void ZoneServerImplementation::run() {
	processor->start();

	receiveMessages();

	shutdown();
}

void ZoneServerImplementation::shutdown() {
	/*chatManager->broadcastMessage("Server is shutting down in 30 seconds..");
	Thread::sleep(10000);

	chatManager->broadcastMessage("Server is shutting down in 20 seconds..");
	Thread::sleep(10000);

	chatManager->broadcastMessage("Server is shutting down in 10 seconds..");
	Thread::sleep(10000);

	chatManager->broadcastMessage("Server is shutting down in 5 seconds..");
	Thread::sleep(5000);*/

	processor->stop();

	stopManagers();

	info("shutting down zones", true);

	for (int i = 0; i < 45; ++i) {
		Zone* zone = zones->get(i);
		if (zone != NULL)
			zone->stopManagers();
	}

	info("zones shut down", true);

	printInfo(true);

	info("shut down complete", true);
}

void ZoneServerImplementation::stopManagers() {
	info("stopping managers..");

	/*if (playerManager != NULL)
		playerManager->stop();*/

	/*if (missionManager != NULL)
		missionManager->unloadManager();

	if (resourceManager != NULL)
		resourceManager->stop();*/

	info("managers stopped", true);
}

ServiceClient* ZoneServerImplementation::createConnection(Socket* sock, SocketAddress& addr) {
	/*if (!userManager->checkUser(addr.getIPID()))
		return NULL;*/

	ZoneClientSession* client = new ZoneClientSession(this, sock, &addr);
	client->deploy("ZoneClientSession " + addr.getFullIPAddress());

	ZoneClientSessionImplementation* clientImpl = (ZoneClientSessionImplementation*) client->_getImplementation();

	String address = client->getAddress();

	info("client connected from \'" + address + "\'");

	return clientImpl;
}

void ZoneServerImplementation::handleMessage(ServiceClient* client, Packet* message) {
	ZoneClientSessionImplementation* zclient = (ZoneClientSessionImplementation*) client;

	try {
		/*if (zclient->simulatePacketLoss())
			return;*/

		if (zclient->isAvailable())
			phandler->handlePacket(zclient, message);

	} catch (PacketIndexOutOfBoundsException& e) {
		error(e.getMessage());

		error("incorrect packet - " + message->toStringData());
	} catch (DatabaseException& e) {
		error(e.getMessage());
	} catch (ArrayIndexOutOfBoundsException& e) {
		error(e.getMessage());
	} catch (Exception& e) {
		error(e.getMessage());
	}
}

bool ZoneServerImplementation::handleError(ServiceClient* client, Exception& e) {
	ZoneClientSessionImplementation* zclient = (ZoneClientSessionImplementation*) client;
	zclient->setError();

	zclient->disconnect();

	return true;
}

/*void ZoneServerImplementation::addObject(SceneObject* obj, bool doLock) {
	try {
		lock(doLock);

		SceneObject* conflictedObj = objectManager->add(obj);

		if (conflictedObj != NULL && conflictedObj != obj) {
			error("Object id conflict");
			StackTrace::printStackTrace();
		}

		obj->setZoneProcessServer(processor);

		if (conflictedObj == NULL && obj->isPlayer()) {
			Player* player = (Player*) obj;

			chatManager->addPlayer(player);

			if (++currentPlayers > maximumPlayers)
				maximumPlayers = currentPlayers;

			++totalPlayers;
		}

		unlock(doLock);
	} catch (...) {
		unlock(doLock);
	}
}*/

SceneObject* ZoneServerImplementation::getObject(uint64 oid, bool doLock) {
	SceneObject* obj = NULL;

	try {
		lock(doLock);

		obj = objectManager->get(oid);

		unlock(doLock);
	} catch (...) {
		unlock(doLock);
	}

	return obj;
}
/*
SceneObject* ZoneServerImplementation::removeObject(uint64 oid, bool doLock) {
	SceneObject* obj = NULL;

	try {
		lock(doLock);

		obj = objectManager->remove(oid);
		if (obj == NULL) {
			unlock(doLock);
			return NULL;
		}

		if (obj->isPlayer()) {
			Player* player = (Player*) obj;
			String& name = player->getFirstName();

			chatManager->removePlayer(name);

			--currentPlayers;
		}

		unlock(doLock);
	} catch (...) {
		unlock(doLock);
	}

	return obj;
}

SceneObject* ZoneServerImplementation::removeObject(SceneObject* obj, bool doLock) {
	return removeObject(obj->getObjectID(), doLock);
}

bool ZoneServerImplementation::destroyObject(SceneObject* obj, bool doLock) {
	bool res = false;

	try {
		lock(doLock);

		res = objectManager->destroy(obj);

		unlock(doLock);
	} catch (...) {
		unlock(doLock);
	}

	return res;
}

SceneObject* ZoneServerImplementation::getCachedObject(uint64 oid, bool doLock) {
	SceneObject* obj = NULL;

	try {
		lock(doLock);

		obj = objectManager->getCachedObject(oid);

		unlock(doLock);
	} catch (...) {
		unlock(doLock);
	}

	return obj;
}

SceneObject* ZoneServerImplementation::removeCachedObject(uint64 oid, bool doLock) {
	SceneObject* obj = NULL;

	System::out << "removeCachedObject OID = " << oid << endl;
	try {
		lock(doLock);

		obj = objectManager->removeCachedObject(oid);

		unlock(doLock);
	} catch (...) {
		unlock(doLock);
	}

	return obj;
}

SceneObject* ZoneServerImplementation::removeCachedObject(SceneObject* obj, bool doLock) {
	return removeCachedObject(obj->getObjectID(), doLock);
}

SceneObject* ZoneServerImplementation::createObject(uint32 objectCRC, bool doLock) {
	SceneObject* obj = NULL;

	try {
		lock(doLock);

		obj = objectManager->createObject(objectCRC);

		unlock(doLock);
	} catch (...) {
		unlock(doLock);
	}

	return obj;
}

bool ZoneServerImplementation::banUser(String& name, String& admin) {
	lock();

	bool result = userManager->banUserByName(name, admin);

	unlock();

	return result;
}

bool ZoneServerImplementation::kickUser(String& name, String& admin) {
	lock();

	bool result = userManager->kickUser(name, admin);

	unlock();

	return result;
}*/

void ZoneServerImplementation::changeUserCap(int amount) {
	lock();

	//userManager->changeUserCap(amount);

	unlock();
}

void ZoneServerImplementation::addTotalSentPacket(int count) {
	lock();

	totalSentPackets += count;

	unlock();
}

void ZoneServerImplementation::addTotalResentPacket(int count) {
	lock();

	totalResentPackets += count;

	unlock();
}

int ZoneServerImplementation::getConnectionCount() {
	return currentPlayers;
}

void ZoneServerImplementation::printInfo(bool forcedLog) {
	lock();

	StringBuffer msg;
	msg << "MessageQueue - size = " << messageQueue.size();
	info(msg, forcedLog);

	StringBuffer msg2;
	msg2 << "Scheduler - size = " << taskManager->getScheduledTaskSize();
	info(msg2, forcedLog);

	float packetloss;
	if (totalSentPackets + totalSentPackets == 0)
		packetloss = 0.0f;
	else
		packetloss = (100 * totalResentPackets) / (totalResentPackets + totalSentPackets);

	StringBuffer msg3;
	msg3 << "sent packets = " << totalSentPackets << ", resent packets = "
		<< totalResentPackets << " [" << packetloss << "%]";
	info(msg3, forcedLog);

	StringBuffer msg4;
	msg4 << dec << currentPlayers << " users connected (" << maximumPlayers << " max, " << totalPlayers << " total, "
		 << totalDeletedPlayers << " deleted)";
	info(msg4, forcedLog);

	unlock();
}

void ZoneServerImplementation::printEvents() {
	lock();

	//scheduler->printEvents();

	unlock();
}

uint64 ZoneServerImplementation::getNextCreatureID(bool doLock) {
	lock(doLock);

	uint64 nextID = (nextCreatureID += 0x10000);

	unlock(doLock);

	return nextID;
}

uint64 ZoneServerImplementation::getNextID(bool doLock) {
	lock(doLock);

	uint64 nextID = (nextCreatureID += 0x01);

	unlock(doLock);

	return nextID;
}

uint64 ZoneServerImplementation::getNextCellID(bool doLock) {
	lock(doLock);

	uint64 nextID = (nextCellID += 0x1);

	unlock(doLock);

	return nextID;
}
