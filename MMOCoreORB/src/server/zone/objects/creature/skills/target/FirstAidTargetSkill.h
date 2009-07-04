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

#ifndef FIRSTAIDTARGETSKILL_H_
#define FIRSTAIDTARGETSKILL_H_

#include "../TargetSkill.h"

#include "../../../../managers/player/PlayerManager.h"

class FirstAidTargetSkill : public TargetSkill {
protected:
	String effectName;

	int mindCost;
	float speed;

public:
	FirstAidTargetSkill(const String& name, const char* aname, ZoneProcessServerImplementation* serv) : TargetSkill(name, aname, HEAL, serv) {
		effectName = aname;
		mindCost = 0;

		speed = 0.0f;
	}

	void doAnimations(CreatureObject* creature, CreatureObject* creatureTarget) {
		if (!effectName.isEmpty())
			creatureTarget->playEffect(effectName, "");

		if (creature == creatureTarget)
			creature->doAnimation("heal_self");
		else
			creature->doAnimation("heal_other");
	}

	int doSkill(CreatureObject* creature, SceneObject* target, const String& modifier, bool doAnimation = true) {
		if (!target->isPlayer() && !target->isNonPlayerCreature()) {
			creature->sendSystemMessage("healing_response", "healing_response_79"); //Target must be a player or a creature pet in order to apply first aid.
			return 0;
		}

		CreatureObject* creatureTarget = (CreatureObject*) target;

		if (creatureTarget->isDead() || creatureTarget->isRidingCreature() || creatureTarget->isMounted())
			creatureTarget = creature;	//If our target is dead, riding a creature, or mounted, then we make ourself target.

		if (creature->isProne()) {
			creature->sendSystemMessage("You cannot apply First Aid while prone.");
			return 0;
		}

		if (creature->isMeditating()) {
			creature->sendSystemMessage("You cannot apply First Aid while Meditating.");
			return 0;
		}

		if (creature->isRidingCreature()) {
			creature->sendSystemMessage("You cannot do that while Riding a Creature.");
			return 0;
		}

		if (creature->isMounted()) {
			creature->sendSystemMessage("You cannot do that while Driving a Vehicle.");
			return 0;
		}

		if (creatureTarget->isOvert() && creatureTarget->getFaction() != creature->getFaction()) {
			creature->sendSystemMessage("healing_response", "unwise_to_help"); //It would be unwise to help such a patient.
			return 0;
		}

		if (creature->getMind() < abs(mindCost)) {
			creature->sendSystemMessage("healing_response", "not_enough_mind"); //You do not have enough mind to do that.
			return 0;
		}

		if (creatureTarget->isBleeding()) {
			if (creatureTarget->isBleeding()) {

				if (creatureTarget != creature) {
					StringBuffer message;
					message << "You apply first aid to " << creatureTarget->getCharacterName().toString() << ".";
					creature->sendSystemMessage(message.toString());
				} else {
					creature->sendSystemMessage("healing_response","first_aid_self"); //You apply first aid to yourself.
				}
				creature->changeMindBar(mindCost);

				doAnimations(creature, creatureTarget);


				uint32 skillMod = creature->getSkillMod("healing_injury_treatment");
				creatureTarget->healDot(CreatureState::BLEEDING,skillMod);
				/*if (creatureTarget->healDot(CreatureState::BLEEDING,skillMod))
					creatureTarget->sendSystemMessage("Bleed stop");
				else
					creatureTarget->sendSystemMessage("Bleed reduced");
				 */
			} else {
				creature->error("Failed clearing bleeding state on player for unknown reason.");
			}
		} else {
			if (creatureTarget != creature) {
				creature->sendSystemMessage("healing_response", "healing_response_80", creatureTarget->getObjectID()); //%NT is not bleeding.
			} else {
				creature->sendSystemMessage("healing_response", "healing_response_78"); //You are not bleeding.
			}
		}

		return 0;
	}

	float getSpeed() {
		return speed;
	}

	virtual bool calculateCost(CreatureObject* creature) {
		return true;
	}

	void setEffectName(const String& name) {
		effectName = name;
	}

	void setMindCost(int cost) {
		mindCost = cost;
	}

	void setSpeed(float spd) {
		speed = spd;
	}

};

#endif /*HEALSTATETARGETSKILL_H_*/
