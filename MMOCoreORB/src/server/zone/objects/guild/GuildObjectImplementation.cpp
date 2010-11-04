/*
 * GuildObjectImplementation.cpp
 *
 *  Created on: Oct 27, 2010
 *      Author: crush
 */

#include "GuildObject.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/objects/guild/GuildMemberInfo.h"

void GuildObjectImplementation::sendBaselinesTo(SceneObject* player) {
}

void GuildObjectImplementation::broadcastMessage(BaseMessage* msg) {
}

void GuildObjectImplementation::broadcastMessage(PlayerCreature* player, BaseMessage* msg, bool sendSelf) {
}

void GuildObjectImplementation::addMember(uint64 playerID) {
	Locker locker(_this);

	GuildMemberInfo gmi(playerID);
	guildMembers.put(playerID, gmi);
}

void GuildObjectImplementation::removeMember(uint64 playerID) {
	Locker locker(_this);

	guildMembers.drop(playerID);
}

bool GuildObjectImplementation::hasMember(uint64 playerID) {
	Locker locker(_this);

	return guildMembers.contains(playerID);
}

GuildMemberInfo* GuildObjectImplementation::getMember(uint64 playerID) {
	Locker locker(_this);

	return &guildMembers.get(playerID);
}

void GuildObjectImplementation::startChatRoom() {

}

void GuildObjectImplementation::destroyChatRoom() {

}

bool GuildObjectImplementation::hasMailPermission(uint64 playerID) {
	if (!guildMembers.contains(playerID))
		return false;

	GuildMemberInfo gmi = guildMembers.get(playerID);

	return gmi.hasPermission(GuildObject::PERMISSION_MAIL);
}

bool GuildObjectImplementation::hasSponsorPermission(uint64 playerID) {
	if (!guildMembers.contains(playerID))
		return false;

	GuildMemberInfo* gmi = &guildMembers.get(playerID);

	return gmi->hasPermission(GuildObject::PERMISSION_SPONSOR);
}

bool GuildObjectImplementation::hasAcceptPermission(uint64 playerID) {
	Locker locker(_this);

	if (!guildMembers.contains(playerID))
		return false;

	GuildMemberInfo* gmi = &guildMembers.get(playerID);

	return gmi->hasPermission(GuildObject::PERMISSION_ACCEPT);
}

bool GuildObjectImplementation::hasKickPermission(uint64 playerID) {
	Locker locker(_this);

	if (!guildMembers.contains(playerID))
		return false;

	GuildMemberInfo* gmi = &guildMembers.get(playerID);

	return gmi->hasPermission(GuildObject::PERMISSION_KICK);
}
