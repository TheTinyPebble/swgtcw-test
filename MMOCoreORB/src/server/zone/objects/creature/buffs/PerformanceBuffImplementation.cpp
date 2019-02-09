/*
 * PerformanceBuffImplementation.cpp
 *
 *  Created on: 04/03/2011
 *      Author: Itac
 */

#include "server/zone/objects/creature/buffs/PerformanceBuff.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "templates/params/creature/CreatureAttribute.h"
#include "server/zone/objects/creature/buffs/PerformanceBuffType.h"

void PerformanceBuffImplementation::activate(bool applyModifiers) {
	ManagedReference<CreatureObject*> strongCreo = creature.get();

	if(type == PerformanceBuffType::DANCE_MIND) {
		int mindStrength = round(strength * (float)creature.get()->getBaseHAM(CreatureAttribute::MIND));
		creature.get()->sendSystemMessage("Your Faction point gain rate has been enhanced by a Dancer");
		strongCreo->addSkillMod(SkillModManager::BUFF, "ent_faction_gain", mindStrength, true);

	}
	else if(type == PerformanceBuffType::MUSIC_FOCUS) {
		int focusStrength = round(strength * (float)creature.get()->getBaseHAM(CreatureAttribute::FOCUS));
		creature.get()->sendSystemMessage("Your Experience point gain rate has been enhanced by a Musician");
		strongCreo->addSkillMod(SkillModManager::BUFF, "ent_xp_gain", focusStrength, true);

	}
	else if(type == PerformanceBuffType::MUSIC_WILLPOWER) {
		int willStrength = round(strength * (float)creature.get()->getBaseHAM(CreatureAttribute::WILLPOWER));
		creature.get()->sendSystemMessage("Your Experience point gain rate has been enhanced by a Musician");
		strongCreo->addSkillMod(SkillModManager::BUFF, "ent_cw_gain", willStrength, true);
	}

	BuffImplementation::activate(true);

}

void PerformanceBuffImplementation::deactivate(bool removeModifiers) {
	BuffImplementation::deactivate(true);
}
