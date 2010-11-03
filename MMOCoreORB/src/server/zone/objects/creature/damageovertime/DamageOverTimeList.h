/*
 * DamageOverTimeList.h
 *
 *  Created on: 04/06/2010
 *      Author: victor
 */

#ifndef DAMAGEOVERTIMELIST_H_
#define DAMAGEOVERTIMELIST_H_

#include "engine/engine.h"
#include "DamageOverTime.h"

class DamageOverTimeList : public VectorMap<uint64, Vector<DamageOverTime> > {
protected:
	Time nextTick;
	bool dot;

public:
	DamageOverTimeList() {
		setNoDuplicateInsertPlan();
	}

	uint64 activateDots(CreatureObject* victim);
	uint32 addDot(CreatureObject* victim, uint32 duration, uint64 dotType, uint8 pool, uint32 strength, float potency, uint32 defense);
	bool healState(CreatureObject* victim, uint64 dotType, float reduction);
	void clear();

	void sendStartMessage(CreatureObject* victim, uint64 type);
	void sendStopMessage(CreatureObject* victim, uint64 type);
	void sendIncreaseMessage(CreatureObject* victim, uint64 type);
	void sendDecreaseMessage(CreatureObject* victim, uint64 type);

	int getStrength(uint8 pool, uint64 dotType);

	inline void setNextTick(Time time) {
		nextTick = time;
	}

	inline void setNextTick(uint32 delay) {
		nextTick.addMiliTime(delay * 1000);
	}

	inline Time getNextTick() {
		return nextTick;
	}

	bool hasDot() {
		return (!isEmpty() && dot);
	}

	inline bool isNextTickPast() {
		return nextTick.isPast();
	}

};


#endif /* DAMAGEOVERTIMELIST_H_ */
