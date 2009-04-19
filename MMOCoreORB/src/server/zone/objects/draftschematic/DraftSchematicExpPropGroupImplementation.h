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

#ifndef DRAFTSCHEMATICEXPPROPGROUPIMPLEMENTATION_H_
#define DRAFTSCHEMATICEXPPROPGROUPIMPLEMENTATION_H_

#include "engine/engine.h"

#include "DraftSchematicExpPropGroup.h"

class ObjectControllerMessage;

class DraftSchematicExpPropGroupImplementation: public DraftSchematicExpPropGroupServant {
	Vector<String> keys; // Unfortunately needed when recalculating percentages

	VectorMap<String, uint8> expPropTypes;
	VectorMap<String, uint8> expPropWeights;
	VectorMap<String, float> expPropWeightPercentages;

	uint32 expPropGroupListSize;

	String title, subtitle;

	float minValue, maxValue;

	int decimalPrecision;

	bool filler;

public:
	// When they allow passing of vectors, make this constructor take in a Vector of Strings and a vector
	// of uint32 for the types and weights
	DraftSchematicExpPropGroupImplementation(String Title, String Subtitle);

	DraftSchematicExpPropGroupImplementation(DraftSchematicExpPropGroup* group);

	~DraftSchematicExpPropGroupImplementation();

	void addExperimentalProperty(const String& experimentalPropertyType,
			uint32 weight, float min, float max, int precision);

	void sendBatchToPlayer(ObjectControllerMessage* msg);
	void sendToPlayer(ObjectControllerMessage* msg);

	// Zero is returned if index is out of bounds
	uint8 getBatchTypeAndWeight(uint32 index);
	uint8 getTypeAndWeight(uint32 index);

	bool containsExpPropType(const String& expPropType) {
		return expPropTypes.contains(expPropType);
	}

	// Zero is returned if expPropType is not found
	float getExpPropPercentage(const String& expPropType) {
		if (expPropWeightPercentages.contains(expPropType))
			return expPropWeightPercentages.get(expPropType);
		else
			return 0;
	}

	uint32 getExpPropPercentageListSize() {
		return expPropWeightPercentages.size();
	}

	// Zero is returned if index is out of bounds
	float getExpPropPercentage(uint32 index) {
		if (index < expPropWeightPercentages.size())
			return expPropWeightPercentages.get(index);
		else
			return 0;
	}

	String& getKey(int i) {
		return keys.get(i);
	}

	int getKeyCount() {
		return keys.size();
	}

	String& getExpPropTypesKey(int i) {
		return expPropTypes.elementAt(i)->getKey();
	}

	uint8 getExpPropTypesValue(int i) {
		return expPropTypes.elementAt(i)->getValue();
	}

	int getExpPropTypesSize() {
		return expPropTypes.size();
	}

	String& getExpPropWeightsKey(int i) {
		return expPropWeights.elementAt(i)->getKey();
	}

	uint8 getExpPropWeightsValue(int i) {
		return expPropWeights.elementAt(i)->getValue();
	}

	int getExpPropWeightsSize() {
		return expPropWeights.size();
	}

	String& getExpPropWeightPercentagesKey(int i) {
		return expPropWeightPercentages.elementAt(i)->getKey();
	}

	float getExpPropWeightPercentagesValue(int i) {
		return expPropWeightPercentages.elementAt(i)->getValue();
	}

	int getExpPropWeightPercentagesSize() {
		return expPropWeightPercentages.size();
	}

	String& getSubtitle() {
		return subtitle;
	}

	String& getTitle() {
		return title;
	}

	inline float getMinValue() {
		return minValue;
	}

	inline float getMaxValue() {
		return maxValue;
	}

	inline float getRange() {
		return maxValue - minValue;
	}

	inline int getPrecision() {
		return decimalPrecision;
	}

	inline bool isFiller() {
		return filler;
	}

private:
	void RecalculatePercentages();

};

#endif /*DRAFTSCHEMATICEXPPROPGROUPIMPLEMENTATION_H_*/
