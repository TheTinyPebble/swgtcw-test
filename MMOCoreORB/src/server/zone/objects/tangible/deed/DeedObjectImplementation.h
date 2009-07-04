#ifndef DEEDOBJECTIMPLEMENTATION_H_
#define DEEDOBJECTIMPLEMENTATION_H_

#include "../../player/Player.h"
#include "../../../packets.h"
#include "DeedObject.h"

class DeedObjectImplementation : public DeedObjectServant {
protected:
	String targetFile;
	String targetTemplate;
	String targetTempFile;

	UnicodeString targetName;

	String defaultTemplateName;
public:
	// Sub Types

	// Installation
	static const int HARVESTER = 1;
	static const int FACTORY = 2;
	static const int GENERATOR = 3;
	static const int TURRET = 4;
	static const int MINEFIELD = 5;

	// Player City Building Types
	static const int THEATER = 6;
	static const int SHUTTLEPORT = 7;
	static const int HOSPITAL = 8;
	static const int GARDEN = 9;
	static const int BANK = 10;
	static const int CANTINA = 11;
	static const int CITYHALL = 12;
	static const int GARAGE = 13;
	static const int CLONING = 14;

public:
	DeedObjectImplementation(uint64 oid, uint32 tempCRC, const UnicodeString& name, const String& tempname);
	DeedObjectImplementation(CreatureObject* creature, uint32 tempCRC, const UnicodeString& name, const String& tempname);
	DeedObjectImplementation(uint64 oid, uint32 tempCRC, const UnicodeString& name, const String& tempname, int type);
	DeedObjectImplementation(CreatureObject* creature, uint32 tempCRC, const UnicodeString& name, const String& tempname, int type);
	DeedObjectImplementation(uint64 oid, int type);

	~DeedObjectImplementation();

	void init();

	int useObject(Player * player);

	void generateAttributes(SceneObject* obj);

	virtual int getLotSize() {
		return 0;
	}

	virtual void setLotSize() {

	}

	virtual int getSize() {
		return 0;
	}

	virtual void parseItemAttributes();
	virtual void addAttributes(AttributeListMessage* alm);
	void addHeaderAttributes(AttributeListMessage* alm);
	void addFooterAttributes(AttributeListMessage* alm);

	static int getSubType(uint32 objCRC);
	int getHarvesterType();

	//inline DeedObject* deploy() {
	//	return (DeedObject*) SceneObjectImplementation::deploy();
	//}

	virtual String& getDefaultTemplateName(uint32 objCRC);

	inline UnicodeString& getTargetName() {
		return targetName;
	}

	inline String& getTargetFile() {
		return targetFile;
	}

	inline String& getTargetTemplate() {
		return targetTemplate;
	}

	inline String& getTargetTempFile() {
		return targetTempFile;
	}

	inline void setTargetFile(String path) {
		targetFile = path;
	}

	inline void setTargetTemplate(String temp) {
		targetTemplate = temp;
	}


private:

};

#endif /*DEEDOBJECTIMPLEMENTATION_H_*/
