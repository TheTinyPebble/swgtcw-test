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

#ifndef RESOURCESPAWNER_H_
#define RESOURCESPAWNER_H_

#include "engine/db/ObjectDatabase.h"

#include "server/zone/ZoneServer.h"
#include "server/zone/ZoneProcessServerImplementation.h"
#include "server/zone/managers/name/NameManager.h"
#include "server/zone/managers/object/ObjectManager.h"
#include "resourcetree/ResourceTree.h"
#include "resourcemap/ResourceMap.h"

#include "resourcepool/MinimumPool.h"
#include "resourcepool/FixedPool.h"
#include "resourcepool/RandomPool.h"
#include "resourcepool/NativePool.h"

class ResourceSpawner : public Logger {
private:
	ManagedReference<ZoneServer* > server;
	ZoneProcessServerImplementation* processor;

	NameManager* nameManager;
	ObjectManager* objectManager;

	ResourceTree* resourceTree;
	ObjectDatabaseManager* databaseManager;

	ResourceMap* resourceMap;

	Vector<uint32> activeResourceZones;

	MinimumPool* minimumPool;
	FixedPool* fixedPool;
	RandomPool* randomPool;
	NativePool* nativePool;

	int shiftDuration, lowerGateOverride, maxSpawnAmount;
	float spawnThrottling;

public:
	ResourceSpawner(ManagedReference<ZoneServer* > serv,
			ZoneProcessServerImplementation* impl, ObjectManager* objMan);
	~ResourceSpawner();

	void initializeMinimumPool(const String& includes, const String& excludes);
	void initializeFixedPool(const String& includes, const String& excludes);
	void initializeRandomPool(const String& includes, const String& excludes, const int size);
	void initializeNativePool(const String& includes, const String& excludes);

	void addPlanet(const int planetid);
	void setSpawningParameters(const int dur, const float throt,
			const int override, const int spawnquantity);

	void start();
	void shiftResources();

	ResourceSpawn* createResourceSpawn(const String& type, int zonerestriction = -1);
	ResourceSpawn* createResourceSpawn(const String& type, const Vector<String> excludes = 0, int zonerestriction = -1);
	ResourceSpawn* createResourceSpawn(const Vector<String> includes, const Vector<String> excludes = 0, int zonerestriction = -1);

	void sendResourceListForSurvey(PlayerCreature* playerCreature, const int toolType, const String& surveyType);

	void sendSurvey(PlayerCreature* playerCreature, const String& resname);
private:

	void loadResourceSpawns();
	String makeResourceName(bool isOrganic);
	int randomizeValue(int min, int max);
	long getRandomExpirationTime(ResourceTreeEntry* resourceEntry);
	long getRandomUnixTimestamp(int min, int max);
	Vector<uint32> getActiveResourceZones();

	friend class ResourceManager;
	friend class NativePool;
};

#endif /* RESOURCESPAWNER_H_ */
