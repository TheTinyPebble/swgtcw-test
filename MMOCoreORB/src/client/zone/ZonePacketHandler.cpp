#include "Zone.h"
#include "ZonePacketHandler.h"

/*#include "packets/scene/SceneObjectCreateMessage.h"
#include "packets/scene/UpdateTransformMessage.h"*/
#include "ZoneClient.h"
#include "../../server/zone/packets/zone/SelectCharacter.h"
#include "../../server/zone/packets/zone/CmdSceneReady.h"
#include "managers/object/ObjectManager.h"
#include "managers/objectcontroller/ObjectController.h"

ZonePacketHandler::ZonePacketHandler(const String& s, Zone * z) : Logger(s) {
	zone = z;

	setLogging(false);
	setGlobalLogging(true);
}

void ZonePacketHandler::handleMessage(Message* pack) {
	//info("parsing " + pack->toStringData());

	sys::uint16 opcount = pack->parseShort();
	sys::uint32 opcode = pack->parseInt();

	switch (opcount) {
	case 02:
		switch (opcode) {
		case 0x1DB575CC: // char create success
			handleCharacterCreateSucessMessage(pack);
			break;
		}
		break;
	case 03:
		switch (opcode) {

		case 0xDF333C6E: // char create failure
			handleCharacterCreateFailureMessage(pack);
			break;

		case 0x4D45D504:
			handleSceneObejctDestroyMessage(pack);
			break;

		}
		break;

	case 04:
		switch (opcode) {

		case 0x56CBDE9E:
			handleUpdateContainmentMessage(pack);
			break;
		}
		break;
	case 05:
		switch (opcode) {
		case 0xFE89DDEA: // scene create
			handleSceneObjectCreateMessage(pack);
			break;

		case 0x68A75F0C: // baseline
			handleBaselineMessage(pack);
			break;

		case 0x3C565CED: // instant msg
			handleChatInstantMessageToClient(pack);
			break;

		case 0x6D2A6413: // chat system message
			handleChatSystemMessage(pack);
			break;

		case 0x80CE5E46: // objc
			handleObjectControllerMessage(pack);
			break;
		}
		break;
	case 8:
		switch (opcode) {
		case 0x1B24F808: // update transform message
			handleUpdateTransformMessage(pack);
			break;
		}
		break;
	case 9:
		switch (opcode) {
		case 0x3AE6DFAE: // cmd start scene
			handleCmdStartScene(pack);
			break;
		}
	break;
	default:
		//error("unhandled operand count" + pack->toString());
		break;
	}
}

void ZonePacketHandler::handleCmdStartScene(Message* pack) {
	ZoneClient* client = (ZoneClient*) pack->getClient();

	client->info("received start scene", true);

	uint8 unknown = pack->parseByte();
	uint64 selfPlayerObjectID = pack->parseLong();
	String terrain;
	pack->parseAscii(terrain);

	float x = pack->parseFloat();
	float z = pack->parseFloat();
	float y = pack->parseFloat();

	String race;
	pack->parseAscii(race);

	uint64 galacticTime = pack->parseLong();

	zone->setCharacterID(selfPlayerObjectID);

	BaseMessage* msg = new CmdSceneReady();
	client->sendMessage(msg);
}

void ZonePacketHandler::handleSceneObjectCreateMessage(Message* pack) {
	ZoneClient* client = (ZoneClient*) pack->getClient();
	uint64 objectID = pack->parseLong();
	pack->shiftOffset(16);

	float x = pack->parseFloat();
	float z = pack->parseFloat();
	float y = pack->parseFloat();

	uint32 crc = pack->parseInt();

	ObjectManager* objectManager = zone->getObjectManager();

	SceneObject* object = objectManager->createObject(crc, objectID);

	if (object == NULL) {
		StringBuffer infoMsg;
		infoMsg << "unknown crc 0x" << hex << crc << " received in SceneObjectCreateMessage";
		client->info(infoMsg.toString());
		return;
	}

	if (zone->isSelfPlayer(object)) {
		object->setClient(client);
	}
}

void ZonePacketHandler::handleSceneObejctDestroyMessage(Message* pack) {
	uint64 oid = pack->parseLong();

	ObjectManager* objectManager = zone->getObjectManager();
	objectManager->destroyObject(oid);
}

void ZonePacketHandler::handleBaselineMessage(Message* pack) {
	ZoneClient* client = (ZoneClient*) pack->getClient();

	uint64 oid = pack->parseLong();
	uint32 nametype = pack->parseInt();
	uint8 type = pack->parseByte();

	uint32 size = pack->parseInt();

	uint16 opcount = pack->parseShort();

	SceneObject* object = zone->getObject(oid);

	if (object == NULL) {
		client->info("received baseline for null object");
		return;
	}

	Locker objectLocker(object);

	switch (type) {
	case 3:
		object->parseBaseline3(pack);
		break;
	case 6:
		object->parseBaseline6(pack);
		break;
	default:
		break;
	}
}

void ZonePacketHandler::handleCharacterCreateSucessMessage(Message* pack) {
	ZoneClient* client = (ZoneClient*) pack->getClient();

	uint64 charid = pack->parseLong();

	StringBuffer msg;
	msg << "Character succesfully created - ID = 0x" << hex << charid;
	client->info(msg.toString(), true);

	zone->setCharacterID(charid);

	BaseMessage* selectChar = new SelectCharacter(charid);
	client->sendMessage(selectChar);
}

void ZonePacketHandler::handleUpdateTransformMessage(Message* pack) {
	ZoneClient* client = (ZoneClient*) pack->getClient();

	uint64 objid = pack->parseLong();

	float x = pack->parseSignedShort() / 4;
	float z = pack->parseSignedShort() / 4;
	float y = pack->parseSignedShort() / 4;

	uint32 counter = pack->parseInt();

	SceneObject* scno = zone->getObject(objid);

	if (scno != NULL) {
		Locker _locker(scno);
		scno->setPosition(x, z, y);
		//scno->info("updating position");

		_locker.release();

		PlayerCreature* player = zone->getSelfPlayer();

		Locker _playerLocker(player);

		if (player->getFollowObject() == scno) {
			player->updatePosition(x, z, y);
		}
	}
}

void ZonePacketHandler::handleCharacterCreateFailureMessage(Message* pack) {
	ZoneClient* client = (ZoneClient*) pack->getClient();
	uint32 int1 = pack->parseInt();
	String ui;
	pack->parseAscii(ui);

	uint32 int2 = pack->parseInt();

	String error;
	pack->parseAscii(error);

	client->error(error);
}

void ZonePacketHandler::handleChatInstantMessageToClient(Message* pack) {
	ZoneClient* client = (ZoneClient*) pack->getClient();

	String game, galaxy, name;
	UnicodeString message;

	pack->parseAscii(game);
	pack->parseAscii(galaxy);
	pack->parseAscii(name);
	pack->parseUnicode(message);

	StringBuffer infoMsg;
	infoMsg << "instant message from [" << name << "] : " << message.toString();
	client->info(infoMsg.toString(), true);
}

void ZonePacketHandler::handleChatSystemMessage(Message* pack) {
	ZoneClient* client = (ZoneClient*) pack->getClient();

	uint8 type = pack->parseByte();

	if (type == 1) {
		UnicodeString message;
		pack->parseUnicode(message);

		StringBuffer systemMessage;
		systemMessage << "SystemMessage:[" << message.toString() << "]";

		client->info(systemMessage.toString(), true);
	}

}

void ZonePacketHandler::handleObjectControllerMessage(Message* pack) {
	uint32 header1 = pack->parseInt();
	uint32 header2 = pack->parseInt();

	uint64 objectID = pack->parseLong();

	pack->parseInt();

	SceneObject* object = zone->getObject(objectID);

	if (object != NULL)
		zone->getObjectController()->handleObjectController(object, header1, header2, pack);
}

void ZonePacketHandler::handleUpdateContainmentMessage(Message* pack) {
	uint64 obj = pack->parseLong();
	uint64 par = pack->parseLong();

	int type = pack->parseInt();

	SceneObject* object = zone->getObject(obj);
	SceneObject* parent = zone->getObject(par);

	if (object == NULL)
		return;

	if (par == 0) {
		// remove object from parent
		parent = object->getParent();

		if (parent != NULL) {
			parent->removeObject(object);
		} else {
			object->setParent(NULL);
		}

		return;
	} else if (parent == NULL) {
		return;
	}

	parent->addObject(object, type);
}
