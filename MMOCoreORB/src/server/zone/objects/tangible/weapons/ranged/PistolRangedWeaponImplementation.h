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

#ifndef PISTOLWEAPONIMPLEMENTATION_H_
#define PISTOLWEAPONIMPLEMENTATION_H_

#include "PistolRangedWeaponImplementation.h"

class PistolRangedWeaponImplementation : public PistolRangedWeaponServant {

public:
	PistolRangedWeaponImplementation(uint64 objid, uint32 tempcrc, const UnicodeString& n, const String& tempn, bool eqp = false)
			: PistolRangedWeaponServant(objid, tempcrc, n, tempn, PISTOL, eqp) {
		init();
	}

	PistolRangedWeaponImplementation(CreatureObject* creature, const String& temp, const UnicodeString& n, const String& tempn, bool eqp = false)
			: PistolRangedWeaponServant(creature, temp, n, tempn, PISTOL, eqp) {
		init();
	}

	void init() {
		objectSubType = TangibleObjectImplementation::PISTOL;

		setType(PISTOL);
		setCategory(RANGED);

		setDamageType(ENERGY);
		setMinDamage(89);
		setMaxDamage(232);

		setAttackSpeed(3.0f);

		setRange(45);

		setPointBlankAccuracy(-30);
		setPointBlankRange(0);

		setIdealAccuracy(60);
		setIdealRange(30);

		setMaxRangeAccuracy(-85);
		setMaxRange(44);
		setArmorPiercing(LIGHT);

		setHealthAttackCost(17);
		setActionAttackCost(30);
		setMindAttackCost(17);

		setSpeedSkillMod("pistol_speed");
	}

};


#endif /*PISTOLWEAPONIMPLEMENTATION_H_*/
