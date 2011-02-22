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

#ifndef GIVEITEMCOMMAND_H_
#define GIVEITEMCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/managers/resource/ResourceManager.h"
#include "../../../managers/player/PlayerManager.h"

class GiveItemCommand : public QueueCommand {
public:

	GiveItemCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidPostures(creature))
			return INVALIDPOSTURE;

		ManagedReference<SceneObject* > object =
				server->getZoneServer()->getObject(target);

		ManagedReference<PlayerCreature*> player = NULL;

		StringTokenizer args(arguments.toString());

		if (object == NULL || !object->isPlayerCreature()) {

			String firstName;

			if (args.hasMoreTokens()) {
				args.getStringToken(firstName);
				player = server->getZoneServer()->getPlayerManager()->getPlayer(
								firstName);
			}

		} else {
			player = (PlayerCreature*) object.get();
		}

		if (player == NULL) {
			creature->sendSystemMessage("invalid target for giveItem command");
			return GENERALERROR;
		}

		if(!args.hasMoreTokens()) {
			creature->sendSystemMessage("Invalid Parameters");
			return INVALIDPARAMETERS;
		}

		try {


			String itemtype;
			args.getStringToken(itemtype);

			if (itemtype.toLowerCase() == "resource") {
				if (!args.hasMoreTokens()) {
					creature->sendSystemMessage( "Invalid Parameters, missing resource name");
					return INVALIDPARAMETERS;
				}

				String resname;
				args.getStringToken(resname);

				int quantity = 100000;

				if (args.hasMoreTokens()) {
					quantity = args.getIntToken();
				}

				ManagedReference<ResourceManager*> resourceManager = server->getZoneServer()->getResourceManager();
				resourceManager->givePlayerResource(player, resname, quantity);

			} else if (itemtype.toLowerCase() == "object") {
				if (!args.hasMoreTokens()) {
					creature->sendSystemMessage( "Usage: /giveItem object path/to/object.iff");
					return INVALIDPARAMETERS;
				}

				ManagedReference<SceneObject*> inventory = creature->getSlottedObject("inventory");
				String object;
				args.getStringToken(object);

				SceneObject* item = creature->getZoneServer()->createObject(object.hashCode(), 1);

				if (item == NULL) {
					player->sendSystemMessage("There was an error creating the requested item.");
					return GENERALERROR;
				}

				inventory->addObject(item, -1);
				item->sendTo(player, true);
			}

			return SUCCESS;
		} catch (Exception& e) {
			creature->sendSystemMessage(
					"Invalid Parameters, missing resource name");
			return INVALIDPARAMETERS;
		}
	}

};

#endif //GIVEITEMCOMMAND_H_
