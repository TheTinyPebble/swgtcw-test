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

#ifndef MOVEFURNITURECOMMAND_H_
#define MOVEFURNITURECOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/objects/building/BuildingObject.h"
#include "server/zone/packets/object/DataTransform.h"
#include "server/zone/packets/object/DataTransformWithParent.h"

class MoveFurnitureCommand : public QueueCommand {
public:

	MoveFurnitureCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) {
		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidPostures(creature))
			return INVALIDPOSTURE;

		ManagedReference<SceneObject*> rootParent = creature->getRootParent();

		BuildingObject* buildingObject = rootParent != NULL ? (rootParent->isBuildingObject() ? (BuildingObject*)rootParent.get() : NULL) : NULL;

		if (buildingObject == NULL) {
			creature->sendSystemMessage("@player_structure:must_be_in_building"); //You must be in a building to do that.
			return GENERALERROR;
		}

		if (!buildingObject->isOnAdminList(creature)) {
			creature->sendSystemMessage("@player_structure:must_be_admin"); //You must be a building admin to do that.
			return GENERALERROR;
		}

		StringTokenizer tokenizer(arguments.toString());
		tokenizer.setDelimeter(" ");

		if (!tokenizer.hasMoreTokens())
			return GENERALERROR;

		String dir;
		tokenizer.getStringToken(dir);

		if (dir != "up" && dir != "down" && dir != "forward" && dir != "back")
			return GENERALERROR;

		if (!tokenizer.hasMoreTokens())
			return GENERALERROR;

		float dist = tokenizer.getFloatToken();

		if (dist < 1 || dist > 500) {
			creature->sendSystemMessage("@player_structure:movefurniture_params"); //The amount to move must be between 1 and 500.
			return GENERALERROR;
		}

		ZoneServer* zoneServer = creature->getZoneServer();
		ManagedReference<SceneObject*> obj = zoneServer->getObject(target);

		if (obj == NULL || obj->getRootParent() != buildingObject) {
			creature->sendSystemMessage("@player_structure:rotate_what"); //What do you want to rotate?
			return false;
		}

		float degrees = creature->getDirectionAngle();

		dist /= 100.0f;

		float offsetX = dist * sin(Math::deg2rad(degrees));
		float offsetY = dist * cos(Math::deg2rad(degrees));

		float x = obj->getPositionX();
		float y = obj->getPositionY();
		float z = obj->getPositionZ();

		if (dir == "forward") {
			x += (offsetX);
			y += (offsetY);
		}

		if (dir == "back") {
			x -= (offsetX);
			y -= (offsetY);
		}

		if (dir == "up")
			z += dist;
		if (dir == "down")
			z -= dist;

		//TODO: Check to make sure the item is not being moved outside the range of the cell.
		//Need cell dimensions for this...

		obj->setPosition(x, z, y);
		obj->incrementMovementCounter();

		if (obj->getParent() != NULL) {
			DataTransformWithParent* dtwp = new DataTransformWithParent(obj);
			obj->broadcastMessage(dtwp, false, false);
		} else {
			DataTransform* dt = new DataTransform(obj);
			obj->broadcastMessage(dt, false, false);
		}

		return SUCCESS;
	}

};

#endif //MOVEFURNITURECOMMAND_H_
