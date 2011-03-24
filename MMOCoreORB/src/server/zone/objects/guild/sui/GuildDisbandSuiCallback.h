/*
 * GuildDisbandSuiCallback.h
 *
 *  Created on: Nov 3, 2010
 *      Author: crush
 */

#ifndef GUILDDISBANDSUICALLBACK_H_
#define GUILDDISBANDSUICALLBACK_H_


#include "server/zone/managers/guild/GuildManager.h"
#include "server/zone/objects/tangible/terminal/guild/GuildTerminal.h"
#include "server/zone/objects/player/sui/SuiCallback.h"

class GuildDisbandSuiCallback : public SuiCallback {
public:
	GuildDisbandSuiCallback(ZoneProcessServer* server)
		: SuiCallback(server) {
	}

	void run(PlayerCreature* player, SuiBox* suiBox, bool cancelPressed, Vector<UnicodeString>* args) {
		if (!suiBox->isMessageBox() || cancelPressed)
			return;

		ManagedReference<GuildManager*> guildManager = server->getZoneServer()->getGuildManager();

		ManagedReference<SceneObject*> obj = suiBox->getUsingObject();

		if (obj == NULL || !obj->isTerminal())
			return;

		Terminal* terminal = (Terminal*) obj.get();

		if (!terminal->isGuildTerminal())
			return;

		Locker _lock(terminal);

		GuildTerminal* guildTerminal = (GuildTerminal*) terminal;

		ManagedReference<GuildObject*> guild = guildTerminal->getGuildObject();

		if (guild == NULL)
			return;

		guildManager->disbandGuild(player, guild);
	}
};


#endif /* GUILDDISBANDSUICALLBACK_H_ */
