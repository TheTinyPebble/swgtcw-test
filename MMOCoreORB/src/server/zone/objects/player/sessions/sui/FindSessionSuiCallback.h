/*
 * FindSessionSuiCallback.h
 *
 *  Created on: Jun 24, 2011
 *      Author: polonel
 */

#ifndef FINDSESSIONSUICALLBACK_H_
#define FINDSESSIONSUICALLBACK_H_

#include "server/zone/objects/player/sui/SuiCallback.h"
#include "server/zone/objects/player/sessions/FindSession.h"

class FindSessionSuiCallback : public SuiCallback {
public:
	FindSessionSuiCallback(ZoneServer* server)
		: SuiCallback(server) {
	}

	void run(PlayerCreature* player, SuiBox* suiBox, bool cancelPressed, Vector<UnicodeString>* args) {
		if (!suiBox->isListBox() || cancelPressed)
				return;

		if (args->size() < 1)
			return;

		ManagedReference<Facade*> facade = player->getActiveSession(SessionFacadeType::FIND);
		ManagedReference<FindSession*> session = dynamic_cast<FindSession*>(facade.get());

		if (session == NULL) {
			ManagedReference<PlayerCreature*> pl = (PlayerCreature*) suiBox->getUsingObject();
			if (pl != NULL)
				pl->dropActiveSession(SessionFacadeType::FIND);

			return;
		}

		if (cancelPressed) {
			session->cancelSession();
			return;
		}

		int index = Integer::valueOf(args->get(0).toString());

		SuiListBox* listBox = (SuiListBox*) suiBox;

		String maploctype = listBox->getMenuItemName(index).subString(14);

		session->findPlanetaryObject(maploctype);
	}
};

#endif /* FINDSESSIONSUICALLBACK_H_ */
