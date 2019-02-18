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
    if(type == PerformanceBuffType::DANCE_MIND) {
        int mindStrength = strength * 100;
        creature.get()->sendSystemMessage("Your Faction point gain rate has been enhanced by a Dancer");
        ManagedReference<Buff*> buff = new Buff(creature.get(), buffCRC, buffDuration, BuffType::SKILL);
        buff->setSkillModifier("ent_faction_gain", mindStrength);
        creature.get()->addBuff(buff);

    }
    else if(type == PerformanceBuffType::MUSIC_FOCUS) {
        int focusStrength = strength * 100;
        creature.get()->sendSystemMessage("Your Experience point gain rate has been enhanced by a Musician");
        ManagedReference<Buff*> buff = new Buff(creature.get(), buffCRC, buffDuration, BuffType::SKILL);
        buff->setSkillModifier("ent_xp_gain", focusStrength);
        creature.get()->addBuff(buff);

    }
    else if(type == PerformanceBuffType::MUSIC_WILLPOWER) {
        int willStrength = strength * 100;
        creature.get()->sendSystemMessage("Your Experience point gain rate has been enhanced by a Musician");
        ManagedReference<Buff*> buff = new Buff(creature.get(), buffCRC, buffDuration, BuffType::SKILL);
        buff->setSkillModifier("ent_cw_gain", willStrength);
        creature.get()->addBuff(buff);
    }

    BuffImplementation::activate(true);

}

void PerformanceBuffImplementation::deactivate(bool removeModifiers) {
    BuffImplementation::deactivate(true);
}