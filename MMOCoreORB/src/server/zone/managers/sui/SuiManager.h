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

#ifndef SUIMANAGER_H_
#define SUIMANAGER_H_

#include "engine/engine.h"

#include "server/zone/ZoneProcessServerImplementation.h"

namespace server {
 namespace zone {
  namespace objects {
   namespace player {
    class PlayerCreature;
   }
  }
 }
}

using namespace server::zone::objects::player;

namespace server {
 namespace zone {
  namespace managers {
	  namespace sui {

	  class SuiManager : public Logger {
	  	ZoneProcessServerImplementation* server;

	  public:
	  	SuiManager(ZoneProcessServerImplementation* serv);

	  	void handleSuiEventNotification(uint32 boxID, PlayerCreature* player, uint32 cancel, const String& value, const String& value2);

	  	void handleTuneCrystal(uint32 boxID, PlayerCreature* player, uint32 cancel);
	  	void handleChangeColorCrystal(uint32 boxID, PlayerCreature* player, uint32 cancel, int itemindex);

	  	void handleMessageoftheDay(uint32 boxID, PlayerCreature* player, uint32 cancel);
	  	void handleSetMOTD(uint32 boxID, PlayerCreature* player, uint32 cancel, const String& returnString);

	  	void handleStartMusic(uint32 boxID, PlayerCreature* player, uint32 cancel, const String& song, bool change = false);
	  	void handleStartDancing(uint32 boxID, PlayerCreature* player, uint32 cancel, const String& dance, bool change = false);

	  	void handleSurveyToolRange(uint32 boxID, PlayerCreature* player, uint32 cancel, int range);
	  	void handleSampleRadioactiveConfirm(uint32 boxID, PlayerCreature* player, uint32 cancel, int value);
	  	void handleSurveyConcentratedMinigame(uint32 boxID, PlayerCreature* player, uint32 cancel, int value);
	  	void handleSurveyConcentratedMinigame2(uint32 boxID, PlayerCreature* player, uint32 cancel, int value);

	  	void handleRepairWeapon(uint32 boxID, PlayerCreature* player, uint32 cancel, int itemindex);
	  	void handleRepairArmor(uint32 boxID, PlayerCreature* player, uint32 cancel, int itemindex);

	  	//Structure Stuff
	  	void handleStructureStatus(uint32 boxID, PlayerCreature* player, uint32 cancel, int value);
	  	void handleStructureDestroyConfirm(uint32 boxID, PlayerCreature* player, uint32 cancel, int value);
	  	void handleStructureDestroyCode(uint32 boxID, PlayerCreature* player, uint32 cancel, const String& input);

	  	void handleTicketPurchaseMessageBox(uint32 boxID, PlayerCreature* player);
	  	void handleTicketCollectorRespones(uint32 boxID, PlayerCreature* player, uint32 cancel, int ticketIndex);

	  	void handleCodeForRedeed(uint32 boxID, PlayerCreature* player, uint32 cancel, const String& extra);
	  	void handleRedeedStructure(uint32 boxID, PlayerCreature* player, uint32 cancel, const int extra);
	  	void handleRefreshStatusListBox(uint32 boxID, PlayerCreature* player, uint32 cancel, const int extra);
	  	void handleSetObjectName(uint32 boxID, PlayerCreature* player, uint32 cancel, const String& name);
	  	void handleManageMaintenance(uint32 boxID, PlayerCreature* player,uint32 cancel, const int amount);
	  	void handleAddEnergy(uint32 boxID, PlayerCreature* player,uint32 cancel, const int amount);

	  	void handleColorPicker(uint32 boxID, PlayerCreature* player, uint32 cancel, const String& value, int var);

	  	void handleBankTransfer(uint32 boxID, PlayerCreature* player, int cash, int bank);
	  	void handleFishingAction(uint32 boxID, PlayerCreature* player, uint32 cancel, int index);

	  	void handleBlueFrogItemRequest(uint32 boxID, PlayerCreature* player, uint32 cancel, int itemIndex);
	  	void handleWoundTerminalRequest(uint32 boxID, PlayerCreature* player, uint32 cancel, int itemIndex);
	  	void handleStateTerminalRequest(uint32 boxID, PlayerCreature* player, uint32 cancel, int itemIndex);

	  	void handleDiagnose(uint32 boxID, PlayerCreature* player);
	  	void handleFreeResource(uint32 boxID, PlayerCreature* player, uint32 cancel, int index);
	  	void handleGiveFreeResource(uint32 boxID, PlayerCreature* player, uint32 cancel, bool otherPressed, int index);

	  	void handleCloneConfirm(uint32 boxID, PlayerCreature* player, uint32 cancel, int value);
	  	void handleCloneRequest(uint32 boxID, PlayerCreature* player, uint32 cancel, int value);
	  	void handleConsentBox(uint32 boxID, PlayerCreature* player, uint32 cancel, int value);

	  	void handleDenyTrainingList(uint32 boxID, PlayerCreature* player);

	  	void handleTeachPlayer(uint32 boxID, PlayerCreature* player, int value, uint32 cancel);
	  	void handleTeachSkill(uint32 boxID, PlayerCreature* player, uint32 cancel);

	  	void handleInsuranceMenu(uint32 boxID, PlayerCreature* player, uint32 cancel, int index);
	  	void handleInsureAllConfirm(uint32 boxID, PlayerCreature* player, uint32 cancel);

	  	void handleBankTipConfirm(uint32 boxID, PlayerCreature* player, uint32 cancel);
	  	void handleSlicingMenu(uint32 boxID, PlayerCreature* player, uint32 cancel, int index);
	  	void handleRangerWhatToTrackBox(uint32 boxID, PlayerCreature* player, uint32 cancel, int index);

	  	void handleInsertFactorySchem(uint32 boxID, PlayerCreature* player, uint32 cancel, int index);
	  	void handleInsertFactorySchem(uint32 boxID, PlayerCreature* player, uint32 cancel, bool otherPressed, int index);

	  	void handleSellJunkLootSelection(uint32 boxid, PlayerCreature* player, uint32 cancel, bool otherPressed, int index);
	  	void handleBanListSelection(uint32 boxid, PlayerCreature* player, uint32 cancel, int index);
	  	void handleCommandsListSelection(uint32 boxid, PlayerCreature* player, uint32 cancel, int index);
	  	void handleAccountListSelection(uint32 boxid, PlayerCreature* player, uint32 cancel, int index);
	  	void handleCharacterListSelection(uint32 boxid, PlayerCreature* player, uint32 cancel, int index);

	  	void handleCharacterBuilderSelectItem(uint32 boxid, PlayerCreature* player, int cancel, int index);

	  	void handleSetCityHallName(int boxID, PlayerCreature* player, int cancel, const String& input);

	  	void handleFindCommand(int boxID, PlayerCreature* player, uint32 cancel, int value);

	  	void handleGamblingSlotPayout(uint32 boxID, PlayerCreature* player, uint32 cancel, int index);
	  	void handleGamblingSlot(uint32 boxID, PlayerCreature* player, uint32 cancel, bool otherPressed, int index);
	  	void handleGamblingRoulette(uint32 boxID, PlayerCreature* player, uint32 cancel, int index);

	  };
	  }
  }
 }
}

using namespace server::zone::managers::sui;



#endif /*SUIMANAGER_H_*/
