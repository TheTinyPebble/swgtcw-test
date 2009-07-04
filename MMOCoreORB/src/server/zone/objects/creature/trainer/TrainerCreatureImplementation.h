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

#ifndef TRAINERCREATUREIMPLEMENTATION_H_
#define TRAINERCREATUREIMPLEMENTATION_H_

class Player;
class Profession;
class SceneObject;
class SkillBox;

#include "TrainerCreature.h"

class TrainerCreatureImplementation : public TrainerCreatureServant {
	Profession* profession;
	
public:
	TrainerCreatureImplementation(uint64 oid, Profession* prof);
	
	~TrainerCreatureImplementation();
	
	/**
	 * Trains a player's skillbox.
	 * \param skillBox Skill box to be trained.
	 * \param player Player to be trained.
	 * \return Success boolean.
	 */
	bool train(SkillBox* skillBox, Player* player);	

	/**
	 * Sends the initial trainer NPC blurb.
	 * \param player The player to send the conversation to.
	 */
	void sendInitialMessage(Player* player);
	/**
	 * Sends the initial trainer NPC options.
	 * \param player The player to send the conversation to.
	 */
	void sendInitialChoices(Player* player);
	/**
	 * Sends the intial message to start the
	 * training conversation. Checks for
	 * qualificactions.
	 * \param player The player to send the conversation to (in SceneObject form).
	 */
	void sendConversationStartTo(SceneObject* obj);
	/**
	 * Sends skill box options for player for training,
	 * and as such can check experience.
	 * \param player The player to send the conversation to.
	 * \param chackXp Whether or not to check experience to determine if each skillbox should be listed.
	 */
	void sendSkillBoxes(Player* player, bool checkXp);
	/**
	 * Sends skill boxes that the particular trainer 
	 * can train, regardless of intentionor ability 
	 * to learn.
	 * \param player The player to send the conversation to.
	 * \param checkLearned Whether or not you want to check if the box has been learned already.
	 */
	void sendSkillBoxList(Player* player, bool checkLearned);
	/**
	 * Sends the Yes/No options to the player to
	 * confirm their choice in skill acquisition.
	 * \param player The player to send the conversation to.
	 */
	void sendConfirmation(Player* player);

	/**
	 * Handles the options that the player has selected
	 * and sets the last conversation strings to be used
	 * to determine how to parse the option selected.
	 * \param option The numerical selection the player has made (0indexed).
	 * \param obj The player to send the conversation to (in SceneObject form).
	 */
	void selectConversationOption(int option, SceneObject* obj);
	
};


#endif
