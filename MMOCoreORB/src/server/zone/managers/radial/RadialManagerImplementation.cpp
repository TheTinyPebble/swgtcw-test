/*
 * RadialManagerImplementation.cpp
 *
 *  Created on: 12/08/2009
 *      Author: victor
 */

#include "RadialManager.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "server/zone/packets/object/ObjectMenuResponse.h"
#include "server/zone/ZoneServer.h"

RadialManagerImplementation::RadialManagerImplementation(ZoneServer* server) : ManagedObjectImplementation(), Logger() {
	setLoggingName("RadialManager");

	setGlobalLogging(true);
	setLogging(true);

	zoneServer = server;
}

void RadialManagerImplementation::handleObjectMenuRequest(PlayerCreature* player, ObjectMenuResponse* defaultMenuResponse, uint64 objectID) {
	//Pre: Player is WLOCKED
	//Post: Player is WLOCKED

	ManagedReference<SceneObject*> menuObject = zoneServer->getObject(objectID);

	if (menuObject != NULL) {
		try {
			Locker clocker(menuObject, player);

			//info("entering object menu request ");
			menuObject->fillObjectMenuResponse(defaultMenuResponse, player);

		} catch (...) {
			error("RadialManagerImplementation::handleObjectMenuRequest");
		}
	}

	defaultMenuResponse->finish();

	player->sendMessage(defaultMenuResponse);
}

void RadialManagerImplementation::handleObjectMenuSelect(PlayerCreature* player, byte selectID, uint64 objectID) {
	//Pre: player is NOT wlocked upon entry
	//Post: nothing is WLOCKED

	//System::out << "entering radial call 1" << endl;

	ManagedReference<SceneObject*> selectedObject = zoneServer->getObject(objectID);

	if (selectedObject == NULL) {
		StringBuffer infoMsg;
		infoMsg << "NULL object selected in ObjectMenuSelect objectID: 0x" << hex << objectID;
		error(infoMsg.toString());

		return;
	}

	try {
		Locker locker(player);

		try {
			Locker clocker(selectedObject, player);

			selectedObject->info("entering radial call " + String::valueOf(selectID));
			selectedObject->handleObjectMenuSelect(player, selectID);

		} catch (...) {

			throw;
		}


	} catch (Exception& e) {
		error("exception caught in void RadialManagerImplementation::handleObjectMenuSelect");
		error(e.getMessage());
		e.printStackTrace();
	} catch (...) {

		error("unreported exception caught in void RadialManagerImplementation::handleObjectMenuSelect");
	}

}
