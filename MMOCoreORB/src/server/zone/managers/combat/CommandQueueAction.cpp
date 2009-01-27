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

#include "CommandQueueAction.h"

#include "../../objects/creature/skills/Skill.h"

#include "../../objects/player/Player.h"

#include "../../objects/scene/SceneObject.h"
#include "../../objects/creature/CreatureObject.h"
#include "../../objects/tangible/weapons/Weapon.h"
#include "../../objects/attackable/AttackableObject.h"
#include "../../objects/tangible/pharmaceutical/Pharmaceutical.h"
#include "../../objects/creature/skills/target/HealDamageTargetSkill.h"


CommandQueueAction::CommandQueueAction(CreatureObject* cr, uint64 targid, uint32 acrc, uint32 acntr, const String& amod) {
	actionCRC = acrc;
	actionCounter = acntr;

	targetID = targid;

	actionModifier = amod;

	creature = cr;
	if (creature->isPlayer())
		player = (Player*)cr;
	else
		player = NULL;

	target = NULL;
	skill = NULL;
	weapon = NULL;
}

bool CommandQueueAction::check() {
	if (creature->isIncapacitated() || creature->isDead()) {
		clearError(1, 19);
		return false;
	}

	// TODO: Default attacks can be performed from mounts
	if (creature->isMounted()) {
		clearError(1, 16);
		return false;
	}

	if (skill->isTargetSkill()) {
		target = player->getTarget();

		if (creature->isKnockedDown()) {
			clearError(1, 18);
			return false;
		}

		if (skill->isHealSkill()) {
			if (target == NULL || !target->isAttackable())
				target = creature;
		}
		else {
			if (target == NULL || !target->isAttackable()) {
				clearError(3);
				return false;
			}
		}
	}
	return true;
}

bool CommandQueueAction::validate() {
	if (creature->hasAttackDelay()) {
		clearError(0);
		return false;
	}

	if (creature->isIncapacitated() || creature->isDead()) {
		clearError(1, 19);
		return false;
	}

	if (creature->isMounted()) {
		clearError(1, 16);
		return false;
	}

	if (creature->isKnockedDown()) {
		clearError(1, 18);
		return false;
	}

	if (skill->isTargetSkill()) {
		// are all heal skills target skills ?
		if (target != creature || skill->isHealSkill()) {
			if (skill->isAttackSkill()) {

				if (!checkWeapon())
					return false;

				try {
					target->wlock(creature);

					Weapon* weapon = creature->getWeapon();

					int range;

					if (skill->getRange() != 0)
						range = (int)skill->getRange();
					else if (weapon != NULL)
						range = weapon->getMaxRange();
					else
						range = 5;

					if (!creature->isInRange(target->getPositionX(), target->getPositionY(), range)) {
						target->unlock();
						clearError(4);
						return false;
					}

					SceneObject* sco = target;

					if (sco->isPlayer()) {
						Player* targetPlayer = (Player*) sco;

						if (targetPlayer->isInBuilding() && target->getParent() != creature->getParent()) {
								clearError(0);
								creature->sendSystemMessage("cbt_spam", "los_recycle"); // You cannot see your target

								target->unlock();
								return false;
						}

					} else {
						if (target->getParent() != creature->getParent()) {
							clearError(0);
							creature->sendSystemMessage("cbt_spam", "los_recycle"); // You cannot see your target

							target->unlock();
							return false;
						}
					}

					if (!target->isAttackableObject()) {
						CreatureObject* targetCreature = (CreatureObject*) target.get();

						if (targetCreature->isIncapacitated() || targetCreature->isDead()) {
							clearError(3);
							target->unlock();
							return false;
						}
					} else {
						AttackableObject* targetObject = (AttackableObject*) target.get();

						if (targetObject->isDestroyed()) {
							clearError(3);
							target->unlock();
							return false;
						}
					}

					if (target->isPlayer()) {
						Player* targetPlayer = (Player*) target.get();

						// TODO:  Needs fixing for BH missions
						//if (!player->isHunting(targetPlayer))
						if (!player->isInDuelWith(targetPlayer, false)) {
							if (!player->isOvert() || !targetPlayer->isOvert()) {
								clearError(3);
								target->unlock();
								return false;
							} else if (player->getFaction() == targetPlayer->getFaction()) {
								clearError(3);
								target->unlock();
								return false;
							}
						}
					} else {
						if (!target->isAttackableBy(creature)) {
							clearError(3);
							target->unlock();
							return false;
						}
					}

					target->unlock();
				} catch (...) {
					System::out << "Unreported Exception in CommandQueueAction::validate()\n";
					target->unlock();
				}
			} else if (skill->isHealSkill()) {
				if (target == NULL)
					target = creature;
				return checkHealSkill();
			}
		} else { // target == creature
			if (skill->isAttackSkill()) {
				clearError(3);
				return false;
			}
		}
	}

	return true;
}

bool CommandQueueAction::checkHealSkill() {
	if (target->isAttackableObject()) {
		clearError(3);
		return false;
	}

	CreatureObject* targetObject = (CreatureObject*) target.get();
	if (targetObject != creature) {
		try {
			targetObject->wlock(creature);

			if (target->isPlayer()) {
				Player* targetPlayer = (Player*) target.get();

				if (player->isInDuelWith(targetPlayer, false))
					target = creature;
				else if (player->isOvert() && targetPlayer->isOvert()
						&& player->getFaction() != targetPlayer->getFaction())
					target = creature;
				else if (!player->isOvert() && targetPlayer->isOvert())
					target = creature;
			} else if (target->isNonPlayerCreature() && !skill->isDiagnoseSkill() && !skill->isDragSkill())
				target = creature;


			// range check stimpacks
			if (skill->getNameCRC() == 0x0A9F00A0) {
				float range = 5.0f;
				float distance = creature->calculateDistance(targetObject);

				bool melee = distance <= 5.0f;

				uint64 objectId = 0;

				if (!actionModifier.isEmpty())
					objectId = Long::valueOf(actionModifier);
				else
					objectId = 0;

				if (objectId != 0) {
					Pharmaceutical* pharma = (Pharmaceutical*) creature->getInventoryItem(objectId);

					if (pharma != NULL) {
						float pharmaRange = pharma->getRange(creature);

						if (pharmaRange > range)
							range = pharmaRange;
					}
				} else if (objectId == 0) {
					HealDamageTargetSkill* hSkill = (HealDamageTargetSkill*) skill;

					StimPack* stim = hSkill->findStimPack(creature,distance);
					if (stim == NULL) {
						String box = "science_combatmedic_novice";

						if (!melee && !player->hasSkillBox(box))
							player->sendSystemMessage("Your target is too far away to Heal Damage.");
						else
							player->sendSystemMessage("healing_response", "healing_response_60");

						targetObject->unlock();

						clearError(0);
						return false;
					} else {
						range = stim->getRange(creature);

						StringBuffer mod;

						mod << stim->getObjectID();
						actionModifier = mod.toString();
					}
				}

				if (!creature->isInRange(target->getPositionX(), target->getPositionY(), range)) {
					player->sendSystemMessage("Your target is too far away to Heal Damage.");

					targetObject->unlock();

					clearError(0);
					return false;
				}

				targetObject->unlock();

				clearError(0);
				return true;
			}

			if (!creature->isInRange(target->getPositionX(), target->getPositionY(), skill->getRange())) {
				targetObject->unlock();

				clearError(4);
				return false;
			}

			if (targetObject->isDead() && !skill->isReviveSkill() && !skill->isDragSkill()) {
				clearError(3);

				targetObject->unlock();
				return false;
			}

			targetObject->unlock();
		} catch (...) {
			targetObject->unlock();
		}
	}

	return true;
}

bool CommandQueueAction::checkWeapon() {
	int requiredWeapon = skill->getRequiredWeaponType();

	if (requiredWeapon != 0xFF) {
		weapon = creature->getWeapon();

		if (weapon != NULL) {
			if (requiredWeapon == 0x10 || requiredWeapon == 0x20 ||
					requiredWeapon == 0x30) {
				if (weapon->getCategory() != requiredWeapon) {
					clearError(0);
					if (player != NULL)
						player->sendSystemMessage("cbt_spam", "no_attack_wrong_weapon"); // Can't be done with this weapon
					return false;
				}
			} else if (weapon->getType() != requiredWeapon) {
				clearError(0);
				if (player != NULL)
					player->sendSystemMessage("cbt_spam", "no_attack_wrong_weapon"); // Can't be done with this weapon
				return false;
			}
		} else if (requiredWeapon != 0) {
			clearError(0);
			if (player != NULL)
				player->sendSystemMessage("cbt_spam", "no_attack_wrong_weapon"); // Can't be done with this weapon
			return false;
		}
	}

	if (creature->isKneeling()) {
		if (requiredWeapon < 4 || requiredWeapon == 0x10) {
			clearError(1,4);
			return false;
		}
	}

	if (creature->isProne()) {
		if (requiredWeapon < 4 || requiredWeapon > 6 || requiredWeapon == 0x10 || requiredWeapon == 0x30) {
			clearError(1,7);
			return false;
		}
	}

	return true;
}

void CommandQueueAction::clear(float timer, uint32 tab1, uint32 tab2) {
	if (player != NULL)
		player->clearQueueAction(actionCounter, timer, tab1, tab2);
}
