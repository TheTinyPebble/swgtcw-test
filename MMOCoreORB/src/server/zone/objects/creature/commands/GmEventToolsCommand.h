/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef GmEventToolsCommand_H_
#define GmEventToolsCommand_H_

#include "server/zone/managers/director/DirectorManager.h"

class GmEventToolsCommand : public QueueCommand {
public:

	GmEventToolsCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		Lua* lua = DirectorManager::instance()->getLuaInstance();

		Reference<LuaFunction*> staffTools = lua->createFunction("StaffTools", "openToolsSUI", 0);
		*staffTools << creature;

		staffTools->callFunction();

		return SUCCESS;
	}

};

#endif //GmEventToolsCommand_H_
