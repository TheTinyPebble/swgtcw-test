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
 * \file ResourceMap.h
 * \author Kyle Burkhardt
 * \date 5-03-10
 */

#ifndef RESOURCEMAP_H_
#define RESOURCEMAP_H_

#include "engine/engine.h"
#include "server/zone/objects/resource/ResourceSpawn.h"

#include "server/zone/objects/player/sui/listbox/SuiListBox.h"

/**
 * TypeResourceMap is a container class for VectorMap<String, ManagedReference<ResourceSpawn* > >
 * It indexes
 */
class TypeResourceMap : public Vector<ManagedReference<ResourceSpawn* > > {
public:
	TypeResourceMap() {

	}
	~TypeResourceMap() {

	}
};

/**
 * ZoneResourceMap is a container class for VectorMap<String, ManagedReference<ResourceSpawn* > >
 */
class ZoneResourceMap : public VectorMap<String, ManagedReference<ResourceSpawn* > > {
public:
	ZoneResourceMap() {
		setNoDuplicateInsertPlan();
		setNullValue(NULL);
	}
	~ZoneResourceMap() {

	}
};

/**
 * ResourceMap contains all resources ever spawned indexed
 * by unique spawn name.  Also contains a map of active
 * resources separated by a zone id
 */
class ResourceMap : public VectorMap<String, ManagedReference<ResourceSpawn* > > {
private:

	VectorMap<uint32, ZoneResourceMap*> zoneResourceMap;
	VectorMap<String, TypeResourceMap*> typeResourceMap;

public:
	ResourceMap();
	~ResourceMap();

	/**
	 * Adds the resource spawn to the global spawn map
	 * and if spawned, it add it to the individual region
	 * map for surveying and sampling/.
	 * \param resname The unique name of the resource spawn
	 * \param resourceSpawn The ResourceSpawn object to be added
	*/
	void add(const String& resname, ManagedReference<ResourceSpawn* > resourceSpawn);

	/**
	 * Removes resource from  global spawn map
	 * \param resourceSpawn The ResourceSpawn object to be removed
	*/
	void remove(ManagedReference<ResourceSpawn* > resourceSpawn);

	/**
	 * Removes resource from the zone spawn map
	 * \param resourceSpawn The ResourceSpawn object to be removed
	 * \param zoneid The zone that is despawning resource
	*/
	void remove(ManagedReference<ResourceSpawn* > resourceSpawn, uint32 zoneid);

	/**
	 * Get's the density value of resource at given point
	 * \param resourcename The name of the resource
	 * \param zoneid The zone map id
	 * \param x The value of the x coordinate
	 * \param y The value of the y coordinate
	 * \return Value between -1 and 1 indicating density
	*/
	float getDensityAt(const String& resourcename, int zoneid, float x, float y);

	/**
	 * Get's the density value of resource at given point
	 * \param zoneid ID of zone being requesting
	 * \return ZoneResourceMap* value of the zoneid requested
	*/
	inline ZoneResourceMap* getZoneResourceList(uint32 zoneid) {
		if(zoneResourceMap.contains(zoneid))
			return zoneResourceMap.get(zoneid);
		else
			return NULL;
	}
	/**
	 * Adds the resources in particular map to SUI for resource deed
	 * \param name name of resource
	 * \param suil Listbox
	*/
	void addToSuiListBox(const String& name, SuiListBox* suil);
};


#endif /* RESOURCEMAP_H_ */
