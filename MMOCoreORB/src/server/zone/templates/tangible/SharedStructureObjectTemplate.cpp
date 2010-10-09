/*
 * SharedStructureObjectTemplate.cpp
 *
 *  Created on: May 22, 2010
 *      Author: crush
 */


#include "SharedStructureObjectTemplate.h"


void SharedStructureObjectTemplate::readObject(LuaObject* templateData) {
	SharedTangibleObjectTemplate::readObject(templateData);

	lotSize = templateData->getByteField("lotSize");

	baseMaintenanceRate = templateData->getIntField("baseMaintenanceRate");

	basePowerRate = templateData->getIntField("basePowerRate");

	LuaObject allowzones = templateData->getObjectField("allowedZones");

	for (int i = 1; i < allowzones.getTableSize() + 1; ++i)
		allowedZones.put(allowzones.getIntAt(i));

	allowzones.pop();

	length = templateData->getByteField("length");

	width = templateData->getByteField("width");

	cityRankRequired = templateData->getByteField("cityRankRequired");

	constructionMarkerTemplate = templateData->getStringField("constructionMarker");
}
