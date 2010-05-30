/*
Copyright (C) 2010 <SWGEmu>

This File is part of Core3.

This program is free software; you can redistribute
it and/or modify it under the terms of the GNU Lesser
General Public License as published by the Free Software
Foundation; either version 3 of the License,
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

/**
 * \file ResourcePool.h
 * \author Kyle Burkhardt
 * \date 5-03-10
 */

#ifndef RESOURCEPOOL_H_
#define RESOURCEPOOL_H_

#include "engine/engine.h"
#include "server/zone/objects/resource/ResourceSpawn.h"

class ResourceSpawner;

/**
 * Abstract parent of all ResourcePool objects
 */
class ResourcePool : public Vector<ManagedReference<ResourceSpawn*> >, public Logger {

protected:

	/**
	 * List of resources this pool can spawn
	 */
	Vector<String> includedResources;

	/**
	 * List of resources this pool can't spawn
	 */
	Vector<String> excludedResources;

	/**
	 * resourceSpawner is a pointer to the ResourceSpawner object defined in ResourceManager.
	 */
	ResourceSpawner* resourceSpawner;

public:

	static const short NOPOOL = 0;
	static const short MINIMUMPOOL = 1;
	static const short RANDOMPOOL = 2;
	static const short FIXEDPOOL = 3;
	static const short NATIVEPOOL = 4;
	static const short MANUALPOOL = 5;

public:
	  /** Constructor
	   * \param spawner pointer to the ResourceSpawner object defined in ResourceManager
	   */
	ResourcePool(ResourceSpawner* spawner) : Logger("ResourcePool") {
		resourceSpawner = spawner;

		setGlobalLogging(true);
		setLogging(true);
	}
	/**
	 * Deconstructor
	 */
	~ResourcePool() {
		resourceSpawner = NULL;
		removeAll();
	}

	/**
	 * Initialize pool to contain needed resources
	 */
	void initialize(const String& includes, const String& excludes) {
		StringTokenizer includeTokens(includes);
		includeTokens.setDelimeter(",");

		String token;
		while (includeTokens.hasMoreTokens()) {
			includeTokens.getStringToken(token);
			includedResources.add(token);
		}

		StringTokenizer excludeTokens(excludes);
		excludeTokens.setDelimeter(",");

		while (excludeTokens.hasMoreTokens()) {
			excludeTokens.getStringToken(token);
			excludedResources.add(token);
		}
	}

	void print() {

		for(int ii = 0; ii < this->size(); ++ii) {

			ManagedReference<ResourceSpawn* > spawn = this->get(ii);

			StringBuffer msg;

			if (spawn != NULL) {
				msg << spawn->getName() << " : " << spawn->getType() << endl;
			} else {
				msg << "EMPTY : " << includedResources.get(ii) << endl;
			}

			info(msg.toString());
		}
	}

private:
	/**
	 * Remove expired resources and spawn replacements.
	 * \return Whether update completed successfully
	 */
	virtual bool update() = 0;


	/**
	 * Get the position of incoming resource type
	 * This function should only be used when loading
	 * from database.
	 * \param resourceSpawn The resource to add to this pool
	 */
	virtual void addResource(ManagedReference<ResourceSpawn*> resourceSpawn) = 0;

	friend class ResourceSpawner;
};

#endif /* RESOURCEPOOL_H_ */
