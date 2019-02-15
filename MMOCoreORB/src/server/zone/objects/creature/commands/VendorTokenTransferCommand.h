/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef VendorTokenTransfer_H_
#define VendorTokenTransfer_H_

#include "server/zone/managers/director/DirectorManager.h"

class VendorTokenTransferCommand : public QueueCommand {
public:

	VendorTokenTransferCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		return SUCCESS;
	}

};

#endif //VendorTokenTransfer_H_
