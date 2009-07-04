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

#ifndef DRAFTSCHEMATICATTRIBUTEIMPLEMENTATION_H_
#define DRAFTSCHEMATICATTRIBUTEIMPLEMENTATION_H_


#include "../../packets.h"

#include "DraftSchematicAttribute.h"

class DraftSchematicAttributeImplementation : public DraftSchematicAttributeServant {

	// example: useModifier
	String attributeName;
	String attributeExperimentalProperty;

	float minValue;
	float maxValue;
	float range;

	int precision;

public:
	DraftSchematicAttributeImplementation(const String& attribute, const float minVal, const float maxVal,
			const String& attributeExpProp, const int prec) : DraftSchematicAttributeServant() {

		attributeName = attribute;
		minValue = minVal;
		maxValue = maxVal;
		range = maxValue - minValue;
		attributeExperimentalProperty = attributeExpProp;
		precision = prec;

	}

	DraftSchematicAttributeImplementation(DraftSchematicAttribute* attrib) : DraftSchematicAttributeServant() {

		attributeName = attrib->getAttributeName();
		minValue = attrib->getMinValue();
		maxValue = attrib->getMaxValue();
		range = maxValue - minValue;
		attributeExperimentalProperty = attrib->getAttributeExperimentalProperty();
		precision = attrib->getPrecision();

	}

	// setters
	inline void setAttributeName(const String attribute) {
		attributeName = attribute;
	}

	inline void setMinValue(const float minVal) {
		minValue = minVal;
		range = maxValue - minValue;
	}

	inline void setMaxValue(const float maxVal) {
		maxValue = maxVal;
		range = maxValue - minValue;
	}

	inline void setAttributeExperimentalProperty(const String attributeExpProp){
		attributeExperimentalProperty = attributeExpProp;
	}

	// getters
	inline String& getAttributeName() {
		return attributeName;
	}

	inline float getMinValue() {
		return minValue;
	}

	inline float getMaxValue() {
		return maxValue;
	}

	inline float getRange() {
		return range;
	}

	inline int getPrecision() {
		return precision;
	}

	inline String& getAttributeExperimentalProperty(){
		return attributeExperimentalProperty;
	}


};

#endif /*DRAFTSCHEMATICATTRIBUTEIMPLEMENTATION_H_*/
