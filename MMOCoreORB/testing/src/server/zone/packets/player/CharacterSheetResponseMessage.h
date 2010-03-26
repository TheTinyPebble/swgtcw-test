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

#ifndef CHARACTERSHEETRESPONSEMESSAGE_H_
#define CHARACTERSHEETRESPONSEMESSAGE_H_

#include "engine/engine.h"
#include "server/zone/objects/player/PlayerCreature.h"

class CharacterSheetResponseMessage : public BaseMessage {
public:
    CharacterSheetResponseMessage(PlayerCreature* player) : BaseMessage() {
		insertShort(0x0D);
		insertInt(0x9B3A17C4); // CRC

		insertInt(0); //??
		insertInt(0); //??

		insertFloat(0); //Bind Location X
		insertFloat(0); //Bind Location Y
		insertFloat(0); //Bind Location Z
		insertAscii(""); //Bind Planet

		insertFloat(-4253.09f); //Bank Location X
		insertFloat(3); //Bank Location Y
		insertFloat(-2403.3); //Bank Location Z
		insertAscii("dantooine"); //Bank Planet

		insertFloat(1337.0f); //Home Location X
		insertFloat(1337.0f); //Home Location Y
		insertFloat(1337.0f); //Home Location Z
		insertAscii("tatooine"); //Home Planet

		insertUnicode(""); //Spouse Name
		insertInt(player->getLotsRemaining()); //Lots Remaining

		insertInt(player->getFaction()); //Faction CRC (or hashCode?)
		insertInt(player->getFactionStatus()); //Faction Status
	}

};

#endif /*CHARACTERSHEETRESPONSEMESSAGE_H_*/
