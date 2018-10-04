/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef DISARMINGSHOT2COMMAND_H_
#define DISARMINGSHOT2COMMAND_H_

#include "CombatQueueCommand.h"

class DisarmingShot2Command : public CombatQueueCommand {

protected:
	String skillName = "disarmShot";		// Skill Name
	String tarSkillName = "targetDisarm";
	String skillNameDisplay = "Disarm Shot";		// Skill Display Name for output message
	int delay = 36; 								//  30 second cool down timer after root expires
	int tarDelay = 20;

public:

	DisarmingShot2Command(const String& name, ZoneProcessServer* server)
		: CombatQueueCommand(name, server) {
	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;
		
		return doCombatAction(creature, target);
	}

};
#endif //DISARMINGSHOT2COMMAND_H_