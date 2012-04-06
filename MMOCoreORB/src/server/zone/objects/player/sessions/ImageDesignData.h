/*
 * ImageDesignData.h
 *
 *  Created on: Feb 16, 2011
 *      Author: crush
 */

#ifndef IMAGEDESIGNDATA_H_
#define IMAGEDESIGNDATA_H_

#include "engine/engine.h"

class ImageDesignData : public Object {
protected:
	String hairTemplate;
	CustomizationVariables hairCustomizationVariables;

	uint32 sessionID;
	uint32 timestamp;

	uint32 requiredPayment;
	uint32 offeredPayment;

	uint8 designerAccepted;
	uint32 targetAccepted;

	uint8 statMigrationRequested;

	uint32 unk1;
	uint32 unk2;
	uint32 unk3;
	uint32 unk4;

	VectorMap<String, float> bodyAttributes;
	VectorMap<String, uint32> colorAttributes;

	String holoEmote;

public:
	ImageDesignData() {

	}

	ImageDesignData(const ImageDesignData& idd) : Object() {
		hairTemplate = idd.hairTemplate;
		hairCustomizationVariables = idd.hairCustomizationVariables;
		sessionID = idd.sessionID;
		timestamp = idd.timestamp;
		requiredPayment = idd.requiredPayment;
		offeredPayment = idd.offeredPayment;
		designerAccepted = idd.designerAccepted;
		targetAccepted = idd.targetAccepted;
		statMigrationRequested = idd.statMigrationRequested;
		unk1 = idd.unk1;
		unk2 = idd.unk2;
		unk3 = idd.unk3;
		unk4 = idd.unk4;
		bodyAttributes = idd.bodyAttributes;
		colorAttributes = idd.colorAttributes;
		holoEmote = idd.holoEmote;
	}

	ImageDesignData& operator= (const ImageDesignData& idd) {
		if (this == &idd)
			return *this;

		hairTemplate = idd.hairTemplate;
		hairCustomizationVariables = idd.hairCustomizationVariables;
		sessionID = idd.sessionID;
		timestamp = idd.timestamp;
		requiredPayment = idd.requiredPayment;
		offeredPayment = idd.offeredPayment;
		designerAccepted = idd.designerAccepted;
		targetAccepted = idd.targetAccepted;
		statMigrationRequested = idd.statMigrationRequested;
		unk1 = idd.unk1;
		unk2 = idd.unk2;
		unk3 = idd.unk3;
		unk4 = idd.unk4;
		bodyAttributes = idd.bodyAttributes;
		colorAttributes = idd.colorAttributes;
		holoEmote = idd.holoEmote;

		return *this;
	}

	void parse(Message* message) {
		message->parseAscii(hairTemplate);

		String customizationString;
		message->parseAscii(customizationString);
		hairCustomizationVariables.parseFromString(customizationString);

		timestamp = message->parseInt();
		sessionID = message->parseInt();

		requiredPayment = message->parseInt();
		offeredPayment = message->parseInt();

		designerAccepted = message->parseByte();
		targetAccepted = message->parseInt();

		statMigrationRequested = message->parseByte();

		unk1 = message->parseInt();
		//System::out << "unk1 " << unk1 << "\n";
		unk2 = message->parseInt();
		//System::out << "unk2 " << unk2 << "\n";
		unk3 = message->parseInt();
		//System::out << "unk3 " << unk3 << "\n";
		unk4 = message->parseInt();
		//System::out << "unk4 " << unk4 << "\n";

		int size = message->parseInt();

		//System::out << "body parts " << size << "\n";

		for (int i = 0; i < size; ++i) {
			String attr;
			message->parseAscii(attr);

			float val = message->parseFloat();

			bodyAttributes.put(attr, val);

			//System::out << attr << " " << val << "\n";
		}

		size = message->parseInt();

		//System::out << "color parts " << size << "\n";

		for (int i = 0; i < size; ++i) {
			String attr;
			message->parseAscii(attr);

			uint32 val = message->parseInt();
			////System::out << attr + String::valueOf(val) << "\n";
			//System::out << attr << " " << val << "\n";

			colorAttributes.put(attr, val);
		}

		message->parseAscii(holoEmote);
	}

	void insertToMessage(Message* message) {
		message->insertAscii(hairTemplate);

		String data;
		hairCustomizationVariables.getData(data);
		message->insertAscii(data);

		message->insertInt(timestamp);
		message->insertInt(sessionID);
		message->insertInt(requiredPayment);
		message->insertInt(offeredPayment);
		message->insertByte(designerAccepted);
		message->insertInt(targetAccepted);
		message->insertByte(statMigrationRequested);
		message->insertInt(unk1);
		message->insertInt(unk2);
		message->insertInt(unk3);
		message->insertInt(unk4);

		int size = bodyAttributes.size();

		message->insertInt(size);

		for (int i = 0; i < size; ++i) {
			VectorMapEntry<String, float>* entry = &bodyAttributes.elementAt(i);

			message->insertAscii(entry->getKey());
			message->insertInt(entry->getValue());
		}

		size = colorAttributes.size();

		message->insertInt(size);

		for (int i = 0; i < size; ++i) {
			VectorMapEntry<String, uint32>* entry = &colorAttributes.elementAt(i);

			message->insertAscii(entry->getKey());
			message->insertInt(entry->getValue());
		}

		message->insertAscii(holoEmote);
	}

	inline bool isAcceptedByDesigner() {
		return (bool) designerAccepted;
	}

	inline bool isAcceptedByTarget() {
		return (bool) targetAccepted;
	}

	inline uint32 getRequiredPayment() {
		return requiredPayment;
	}

	inline uint32 getOfferedPayment() {
		return offeredPayment;
	}

	inline String getHairTemplate() {
		return hairTemplate;
	}

	inline void setHairAttribute(String& attr, uint32 val) {
		hairCustomizationVariables.setVariable(attr,val);
	}

	inline String getHairCustomizationString() {
		String hairCustomization;
		hairCustomizationVariables.getData(hairCustomization);
		return hairCustomization;
	}

	inline VectorMap<String, float>* getBodyAttributesMap() {
		return &bodyAttributes;
	}

	inline VectorMap<String, uint32>* getColorAttributesMap() {
		return &colorAttributes;
	}
};

#endif /* IMAGEDESIGNDATA_H_ */
