/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef GENERALCHATCOMMAND_H_
#define GENERALCHATCOMMAND_H_

#include "server/chat/ChatManager.h"

class GeneralChatCommand : public QueueCommand {
public:

	GeneralChatCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		ChatManager* chatManager = server->getZoneServer()->getChatManager();
		chatManager->handleGeneralChat( creature, arguments);

		return SUCCESS;
	}

};

#endif //GENERALCHATCOMMAND_H_
