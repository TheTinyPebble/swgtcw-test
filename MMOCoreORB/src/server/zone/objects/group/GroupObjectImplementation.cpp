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

#include "../../Zone.h"
#include "../../ZoneClientSession.h"
#include "../creature/CreatureObject.h"

#include "../../packets.h"

#include "GroupObjectImplementation.h"

#include "../../../chat/ChatManager.h"

GroupObjectImplementation::GroupObjectImplementation(uint64 oid, Player* Leader) : GroupObjectServant(oid, GROUP) {
	objectCRC = 0x788CF998; //0x98, 0xF9, 0x8C, 0x78,

	objectType = SceneObjectImplementation::GROUP;

	listCount = 0;

	leader = Leader;

	groupMembers.add(Leader);
	addSquadLeaderBonuses(Leader);

	StringBuffer name;
	name << "Group :" << oid;
	setLoggingName(name.toString());

	setLogging(false);
	setGlobalLogging(true);

	startChannel();
}

void GroupObjectImplementation::startChannel() {
	ChatManager* chatManager = leader->getZone()->getChatManager();

	groupChannel = chatManager->createGroupRoom(objectID, leader);
}

void GroupObjectImplementation::sendTo(Player* player, bool doClose) {
	ZoneClientSession* client = player->getClient();
	if (client == NULL)
		return;

	create(client);

	BaseMessage* grup3 = new GroupObjectMessage3((GroupObject*) _this);
	client->sendMessage(grup3);

	BaseMessage* grup6 = new GroupObjectMessage6((GroupObject*) _this);
	client->sendMessage(grup6);

	if (doClose)
		close(client);

	if (groupChannel != NULL)
		groupChannel->sendTo(player);
}

void GroupObjectImplementation::addPlayer(Player* player) {
	int index = groupMembers.size();

	groupMembers.add(player);
	calcGroupLevel();
	addSquadLeaderBonuses(player);

	GroupObjectDeltaMessage6* grp = new GroupObjectDeltaMessage6((GroupObject*) _this);
	grp->addMember(player, index);
	grp->updateLevel(groupLevel);
	grp->close();

	broadcastMessage(grp);

	//groupMembers.add(player);
	//calcGroupLevel();

	sendTo(player);
}

void GroupObjectImplementation::calcGroupLevel() {
	groupLevel = 0;

	for (int i = 0; i < getGroupSize(); i++) {
		int currentlevel = groupLevel - getGroupSize();
		int memberlevel = getGroupMember(i)->getLevel();
		if (memberlevel > currentlevel)
			groupLevel = memberlevel + getGroupSize();
	}
}

void GroupObjectImplementation::removePlayer(Player* player) {
	int size = groupMembers.size();

	for (int i = 0; i < size; i++) {
		Player* play = groupMembers.get(i);

		if (play == player) {
			groupMembers.remove(i);

			calcGroupLevel();
			removeSquadLeaderBonuses(play);

			GroupObjectDeltaMessage6* grp = new GroupObjectDeltaMessage6((GroupObject*) _this);
			grp->removeMember(i);
			grp->updateLevel(groupLevel);
			grp->close();

			broadcastMessage(grp);

			break;
		}
	}

	if ((player == leader) && groupMembers.size() > 0)
		leader = groupMembers.get(0);

	calcGroupLevel();
}

bool GroupObjectImplementation::hasMember(Player* player) {
	for (int i = 0; i < groupMembers.size(); i++) {
		Player* play = groupMembers.get(i);

		if (play == player)
			return true;
	}
	return false;
}

void GroupObjectImplementation::disband() {
	// this locked
	for (int i = 0; i < groupMembers.size(); i++) {
		Player* play = groupMembers.get(i);
		try {
			play->wlock((GroupObject*) _this);

			play->removeChatRoom(groupChannel);

			play->setGroup(NULL);
			play->updateGroupId(0);
			removeSquadLeaderBonuses(play);

			BaseMessage* msg = new SceneObjectDestroyMessage((GroupObject*) _this);
			play->sendMessage(msg);

			play->unlock();

		} catch (...) {
			System::out << "Exception in GroupObject::disband(Player* player)\n";
			play->unlock();
		}
	}


	if (groupChannel != NULL) {
		ChatRoom* room = groupChannel->getParent();
		ChatRoom* parent = room->getParent();

		ChatManager* chatManager = getZone()->getChatManager();

		chatManager->destroyRoom(groupChannel);
		chatManager->destroyRoom(room);

		groupChannel = NULL;
	}

	groupMembers.removeAll();
}

void GroupObjectImplementation::broadcastMessage(BaseMessage* msg) {
	for (int i = 0; i < groupMembers.size(); i++) {
		Player* play = groupMembers.get(i);

		play->sendMessage(msg->clone());
	}

	delete msg;
}

void GroupObjectImplementation::sendSystemMessage(Player* player,
		const String& message, bool sendToSelf) {
	for (int i = 0; i < groupMembers.size(); i++) {
		Player* play = groupMembers.get(i);

		if (play != player) {

			play->sendSystemMessage(message);

		} else {

			if (sendToSelf)
				play->sendSystemMessage(message);
		}
	}
}

void GroupObjectImplementation::sendSystemMessage(Player* player,
		const String& file, const String& str, uint64 targetid, bool sendToSelf) {
	for (int i = 0; i < groupMembers.size(); i++) {
		Player* play = groupMembers.get(i);

		if (play != player) {

			play->sendSystemMessage(file, str, targetid);

		} else {

			if (sendToSelf)
				play->sendSystemMessage(file, str, targetid);
		}
	}
}

void GroupObjectImplementation::sendSystemMessage(Player* player,
		const String& file, const String& str, StfParameter* param,
		bool sendToSelf) {
	for (int i = 0; i < groupMembers.size(); i++) {
		Player* play = groupMembers.get(i);

		if (play != player) {

			play->sendSystemMessage(file, str, param);

		} else {

			if (sendToSelf)
				play->sendSystemMessage(file, str, param);
		}
	}
}

void GroupObjectImplementation::makeLeader(Player* player) {
	if (groupMembers.size() < 2)
		return;

	for(int i = 0; i < groupMembers.size(); i++) {
		removeSquadLeaderBonuses(groupMembers.get(i));
	}

	Player* temp = leader;
	leader = player;
	int i = 0;
	for (; i < groupMembers.size(); i++) {
		addSquadLeaderBonuses(groupMembers.get(i));

		if (groupMembers.get(i) == player) {
			groupMembers.set(0, player);
			groupMembers.set(i, temp);
			break;
		}
	}

	GroupObjectDeltaMessage6* grp = new GroupObjectDeltaMessage6((GroupObject*) _this);
	grp->updateLeader(player, temp, i);
	grp->close();

	broadcastMessage(grp);
}

float GroupObjectImplementation::getRangerBonusForHarvesting(Player* player) {
	Player* temp;
	String skillBox = "outdoors_ranger_novice";
	String skillBox2 = "outdoors_ranger_master";

	float bonus = .2f;
	bool closeEnough = false;

	int i = 0;
	for (; i < groupMembers.size(); i++) {

		temp = groupMembers.get(i);

		try {
			if (temp != player)
				temp->wlock(player);

			if (temp->getFirstName() != player->getFirstName() && temp->isInRange(player, 64.0f) &&
					player->getZoneID() == temp->getZoneID())
				closeEnough = true;

			if (temp->hasSkillBox(skillBox))
				bonus = .3f;

			if (temp->hasSkillBox(skillBox2))
				bonus = .4f;

			if (temp != player)
				temp->unlock();
		} catch (...) {
			temp->error("unreported exception caught in GroupObjectImplementation::getRangerBonusForHarvesting");

			if (temp != player)
				temp->unlock();
		}

	}

	if (closeEnough)
		return bonus;
	else
		return 0.0f;
}

void GroupObjectImplementation::addSquadLeaderBonuses(CreatureObject* groupMember) {
	int meleeDefenseBonus = leader->getSkillMod("group_melee_defense");
	int rangedDefenseBonus = leader->getSkillMod("group_ranged_defense");
	int burstRunBonus = leader->getSkillMod("group_burst_run");
	int terrainNegotiationBonus = leader->getSkillMod("group_slope_move");

	groupMember->addSkillModBonus("melee_defense", meleeDefenseBonus, false);
	groupMember->addSkillModBonus("ranged_defense", rangedDefenseBonus, false);
	groupMember->addSkillModBonus("burst_run", burstRunBonus, false);
	groupMember->addSkillModBonus("slope_move", terrainNegotiationBonus, false);
}

void GroupObjectImplementation::removeSquadLeaderBonuses(CreatureObject* groupMember) {
	int meleeDefenseBonus = leader->getSkillMod("group_melee_defense");
	int rangedDefenseBonus = leader->getSkillMod("group_ranged_defense");
	int burstRunBonus = leader->getSkillMod("group_burst_run");
	int terrainNegotiationBonus = leader->getSkillMod("group_slope_move");

	groupMember->addSkillModBonus("melee_defense", -meleeDefenseBonus, false);
	groupMember->addSkillModBonus("ranged_defense", -rangedDefenseBonus, false);
	groupMember->addSkillModBonus("burst_run", -burstRunBonus, false);
	groupMember->addSkillModBonus("slope_move", -terrainNegotiationBonus, false);
}
