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

#ifndef RESOURCESLOT_H_
#define RESOURCESLOT_H_

#include "IngredientSlot.h"
#include "server/zone/objects/resource/ResourceSpawn.h"
#include "server/zone/objects/resource/ResourceContainer.h"

class ResourceSlot: public IngredientSlot {

	ManagedReference<ResourceContainer* > contents;

public:
	ResourceSlot(String t, int q) :
		IngredientSlot(t, q) {


		slottype = RESOURCESLOT;
		contents = NULL;

		setLoggingName("ResourceSlot");

		optional = false;
	}

	~ResourceSlot() {

		cleanup();
	}

	inline void cleanup() {
		contents = NULL;
	}

	inline int getQuantity() {

		if (contents != NULL)
			return contents->getQuantity();
		else
			return 0;
	}

	bool add(PlayerCreature* player, TangibleObject* tano) {

		/// Must be a resource container to proceed
		if (tano->isResourceContainer() && getQuantity() < requiredQuantity) {

			previousParent = tano->getParent();

			ResourceContainer* incomingResource = (ResourceContainer*) tano;

			/// Verify the resource is the right type
			if(!incomingResource->getSpawnObject()->isType(type))
				return false;

			bool removeFromParent = false;

			if (contents != NULL) {
				int needs = requiredQuantity - contents->getQuantity();

				if(needs < incomingResource->getQuantity()) {

					incomingResource->setQuantity(incomingResource->getQuantity() - needs, player);
					contents->setQuantity(contents->getQuantity() + needs);

				} else {

					contents->setQuantity(contents->getQuantity() + incomingResource->getQuantity());
					removeFromParent = true;

				}
			}

			if (contents == NULL && incomingResource->getQuantity() > requiredQuantity) {

				ResourceSpawn* spawn = incomingResource->getSpawnObject();

				incomingResource->setQuantity(incomingResource->getQuantity() - requiredQuantity, player);

				contents = spawn->createResource(requiredQuantity);

				contents->sendTo(player, true);
				contents->sendAttributeListTo(player);

			} else {

				contents = incomingResource;
				removeFromParent = true;

			}

			if(removeFromParent && previousParent != NULL)
				previousParent->removeObject(incomingResource, true);

			return true;
		}

		return false;
	}

	inline bool remove(PlayerCreature* player) {

		return returnObjectToParent();
	}

	inline TangibleObject* get() {

		return (TangibleObject*) contents;
	}

	inline bool isComplete() {
		return (contents->getQuantity() == requiredQuantity);
	}

	inline bool hasItem() {
		return contents != NULL;
	}

	inline uint64 getObjectID() {
		if(contents == NULL)
			return 0;
		else
			return contents->getObjectID();
	}

	inline bool returnObjectToParent() {

		if(contents == NULL || previousParent == NULL)
			return false;

		/// Find out where the item was located
		ManagedReference<PlayerCreature* > player = (PlayerCreature*)previousParent->getParentRecursively(SceneObject::PLAYERCREATURE);

		// Check inventory for resource and add if existing
		for (int i = 0; i < previousParent->getContainerObjectsSize(); ++i) {
			ManagedReference<SceneObject*> object =
					previousParent->getContainerObject(i);

			if (object->isResourceContainer()) {
				ManagedReference<ResourceContainer*> resource = (ResourceContainer*) object.get();

				if (resource->getSpawnName() == contents->getSpawnName()) {
					int newStackSize = resource->getQuantity() + contents->getQuantity();

					resource->setQuantity(newStackSize, player);
					contents = NULL;
					return true;
				}
			}
		}

		previousParent->addObject(contents, -1, true);
		contents = NULL;
		return true;
	}

	void print() {
		if (contents == NULL) {

			System::out << "Slot is EMPTY" << endl;

		} else {

			System::out << "Name: "
					<< contents->getCustomObjectName().toString() << endl;
			System::out << "Quantity: " << contents->getQuantity() << endl;
		}
	}
};
#endif /*RESOURCESLOT_H_*/
