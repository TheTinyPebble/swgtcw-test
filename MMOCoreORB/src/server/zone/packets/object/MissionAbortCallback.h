/*
 * MissionAbortCallback.h
 *
 *  Created on: 22/06/2010
 *      Author: victor
 */

#ifndef MISSIONABORTCALLBACK_H_
#define MISSIONABORTCALLBACK_H_


#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "ObjectControllerMessageCallback.h"
#include "server/zone/managers/mission/MissionManager.h"
#include "server/zone/objects/mission/MissionObject.h"


class MissionAbortCallback : public MessageCallback {
	uint64 missionObjectID;

	ObjectControllerMessageCallback* objectControllerMain;
public:
	MissionAbortCallback(ObjectControllerMessageCallback* objectControllerCallback) :
		MessageCallback(objectControllerCallback->getClient(), objectControllerCallback->getServer()) {

		objectControllerMain = objectControllerCallback;
	}

	void parse(Message* message) {
		//System::out << message->toStringData() << endl;
		message->parseInt();
		missionObjectID = message->parseLong();

	}

	void run() {
		ManagedReference<PlayerCreature*> player = (PlayerCreature*) client->getPlayer();

		ManagedReference<SceneObject*> mission = server->getZoneServer()->getObject(missionObjectID);

		if (mission == NULL)
			return;

		if (!mission->isMissionObject())
			return;

		MissionObject* missionObject = (MissionObject*) mission.get();

		MissionManager* manager = server->getZoneServer()->getMissionManager();
		manager->handleMissionAbort(missionObject, player);

	}
};


#endif /* MISSIONABORTCALLBACK_H_ */
