/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef COMPLETEQUESTCOMMAND_H_
#define COMPLETEQUESTCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"

class CompleteQuestCommand : public QueueCommand {
public:

	CompleteQuestCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		StringTokenizer args(arguments.toString());

		try {
			String commandType;
			args.getStringToken(commandType);

			ManagedReference<SceneObject*> obj = server->getZoneServer()->getObject(target);

			if (obj == NULL || !obj->isCreatureObject()) {
				return INVALIDTARGET;
			}

			CreatureObject* targetCreature = cast<CreatureObject*>(obj.get());

			if (targetCreature == NULL) {
				return INVALIDTARGET;
			}

			Locker targetLock(targetCreature, creature);

			if (commandType.beginsWith("screenplaystate")) {
				String screenPlayName;
				args.getStringToken(screenPlayName);
				uint64 state = args.getLongToken();

				targetCreature->setScreenPlayState(screenPlayName, state | targetCreature->getScreenPlayState(screenPlayName));

				creature->sendSystemMessage(targetCreature->getFirstName() + " " + screenPlayName + " set to " + String::valueOf(targetCreature->getScreenPlayState(screenPlayName)));

			} else if (commandType.beginsWith("quest")) {
				PlayerObject* ghost = targetCreature->getPlayerObject();

				if (ghost == NULL)
					return INVALIDTARGET;

				int quest = args.getIntToken();

				ghost->completeQuest(quest);

			} else if (commandType.beginsWith("spdata")){
				PlayerObject* ghost = targetCreature->getPlayerObject();

				if (ghost == NULL)
					return INVALIDTARGET;

				String screenPlayName, screenPlayVariable, value;
				args.getStringToken(screenPlayName);
				args.getStringToken(screenPlayVariable);
				args.getStringToken(value);

				ghost->setScreenPlayData(screenPlayName, screenPlayVariable, value);

			} else if (commandType.beginsWith("resetHolo")){
				PlayerObject* ghost = targetCreature->getPlayerObject();

				if (ghost == NULL)
					return INVALIDTARGET;

				String screenPlayName, screenPlayVariable, value;
				screenPlayName = "CustomJediProgression";
				screenPlayVariable = "HolocronTimer";
				value = "";

				ghost->setScreenPlayData(screenPlayName, screenPlayVariable, value);

			} else if (commandType.beginsWith("read")){
				PlayerObject* ghost = targetCreature->getPlayerObject();

				if (ghost == NULL)
					return INVALIDTARGET;

				String screenPlayName, screenPlayVariable, value;
				args.getStringToken(screenPlayName);
				args.getStringToken(screenPlayVariable);

				value = ghost->getScreenPlayData(screenPlayName, screenPlayVariable);

				creature->sendSystemMessage(targetCreature->getFirstName() + " " + screenPlayVariable + " is " + value);

			} else {
				creature->sendSystemMessage("SYNTAX: /completeQuest screenplaystate <screenPlayStateName> <state>");
				creature->sendSystemMessage("SYNTAX: /completeQuest spdata <screenPlayName> <screenPlayVariable> <data>");
				creature->sendSystemMessage("SYNTAX: /completeQuest quest <quest>");
				creature->sendSystemMessage("SYNTAX: /completeQuest resetHolo");
				creature->sendSystemMessage("SYNTAX: /completeQuest read <screenPlayName> <screenPlayVariable>");

				return INVALIDPARAMETERS;
			}
		} catch (Exception& e) {
			creature->sendSystemMessage("SYNTAX: /completeQuest screenplaystate <screenPlayStateName> <state>");
			creature->sendSystemMessage("SYNTAX: /completeQuest spdata <screenPlayName> <screenPlayVariable> <data>");
			creature->sendSystemMessage("SYNTAX: /completeQuest quest <quest>");
			creature->sendSystemMessage("SYNTAX: /completeQuest resetHolo");
			creature->sendSystemMessage("SYNTAX: /completeQuest read <screenPlayName> <screenPlayVariable>");

			return INVALIDPARAMETERS;
		}

		return SUCCESS;
	}

};

#endif //COMPLETEQUESTCOMMAND_H_
