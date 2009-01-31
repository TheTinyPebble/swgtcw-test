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

#include "Zone.h"

#include "ZoneClientSession.h"
#include "ZoneClientSessionImplementation.h"

#include "objects/player/Player.h"

ZoneClientSessionImplementation::ZoneClientSessionImplementation(DatagramServiceThread* serv, Socket* sock, SocketAddress* addr)
		: BaseClientProxy(sock, *addr), ZoneClientSessionServant() {
	init(serv);

	player = NULL;
	sessionKey = 0;

	disconnecting = false;

	StringBuffer loggingname;
	loggingname << "ZoneClientSession " << addr->getFullIPAddress();

	setLoggingName(loggingname.toString());
	setLogging(false);
}

ZoneClientSessionImplementation::~ZoneClientSessionImplementation() {
	player = NULL;
}

void ZoneClientSessionImplementation::disconnect() {
	BaseClient::disconnect();
}

void ZoneClientSessionImplementation::disconnect(bool doLock) {
	lock(doLock);

	if (disconnecting) {
		unlock(doLock);
		return;
	}

	disconnecting = true;

	if (hasError || !clientDisconnected) {
		if (player != NULL) {
			unlock();

			player->disconnect(false, true);

			lock();
		}

		closeConnection(true, false);
	} else if (player != NULL) {
		unlock();

		if (player->isLoggingOut())
			player->logout();
		else {
			try {
				//player->wlock();

				player->setLinkDead();

				//player->unlock();
			} catch (...) {
				//player->unlock();
			}

			closeConnection(true, true);
		}

		lock();
	}

	unlock(doLock);
}

void ZoneClientSessionImplementation::closeConnection(bool lockPlayer, bool doLock) {
	try {
		lock(doLock);

		info("disconnecting client \'" + ip + "\'");

		ZoneServer* server = NULL;

		if (player != NULL) {
			ZoneServer* srv = NULL;

			ManagedReference<Player> play = player;

			if (lockPlayer)
				unlock();

			try {
				play->wlock(lockPlayer);

				if (play->getZone() != NULL)
					srv = play->getZone()->getZoneServer();

				play->setClient(NULL);

				play->unlock(lockPlayer);
			} catch (...) {
				play->unlock(lockPlayer);
			}

			if (lockPlayer)
				lock();

			server = srv;

			player = NULL;
		}

		BaseClient::disconnect(false);

		if (server != NULL) {
			server->addTotalSentPacket(getSentPacketCount());
			server->addTotalResentPacket(getResentPacketCount());
		}

		unlock(doLock);
	} catch (...) {
		unlock(doLock);
	}
}

void ZoneClientSessionImplementation::acquire() {
	_this->acquire();
}

void ZoneClientSessionImplementation::release() {
	_this->release();
}
