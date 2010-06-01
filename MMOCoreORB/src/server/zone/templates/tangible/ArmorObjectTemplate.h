/*
 * ArmorObjectTemplate.h
 *
 *  Created on: 01/06/2010
 *      Author: victor
 */

#ifndef ARMOROBJECTTEMPLATE_H_
#define ARMOROBJECTTEMPLATE_H_


#include "../SharedTangibleObjectTemplate.h"

class ArmorObjectTemplate : public SharedTangibleObjectTemplate {
	int healthEncumbrance;
	int actionEncumbrance;
	int mindEncumbrance;

	int rating;

	float kinetic;
	float energy;
	float electricity;
	float stun;
	float blast;
	float heat;
	float cold;
	float acid;
	float lightSaber;

	SortedVector<String> specialResistsVector;
	SortedVector<String> vulnerabilitesVector;

	float specialBase;

public:
	ArmorObjectTemplate() {

	}

	~ArmorObjectTemplate() {

	}

	void readObject(LuaObject* templateData) {
		SharedTangibleObjectTemplate::readObject(templateData);

		healthEncumbrance = templateData->getIntField("healthEncumbrance");
		actionEncumbrance = templateData->getIntField("actionEncumbrance");
		mindEncumbrance = templateData->getIntField("mindEncumbrance");

		rating = templateData->getIntField("rating");

		kinetic = templateData->getFloatField("kinetic");
		energy = templateData->getFloatField("energy");
		electricity = templateData->getFloatField("electricity");
		stun = templateData->getFloatField("stun");
		blast = templateData->getFloatField("blast");
		heat = templateData->getFloatField("heat");
		cold = templateData->getFloatField("cold");
		acid = templateData->getFloatField("acid");
		lightSaber = templateData->getFloatField("lightSaber");

		specialBase = templateData->getFloatField("specialBase");
	}

	inline float getAcid() const {
		return acid;
	}

	inline int getActionEncumbrance() const {
		return actionEncumbrance;
	}

	inline float getBlast() const {
		return blast;
	}

	inline float getCold() const {
		return cold;
	}

	inline float getElectricity() const {
		return electricity;
	}

	inline float getEnergy() const {
		return energy;
	}

	inline int getHealthEncumbrance() const {
		return healthEncumbrance;
	}

	inline float getHeat() const {
		return heat;
	}

	inline float getKinetic() const {
		return kinetic;
	}

	inline float getLightSaber() const {
		return lightSaber;
	}

	inline int getMindEncumbrance() const {
		return mindEncumbrance;
	}

	inline int getRating() const {
		return rating;
	}

	inline float getSpecialBase() const {
		return specialBase;
	}

	SortedVector<String> getSpecialResistsVector() const {
		return specialResistsVector;
	}

	float getStun() const {
		return stun;
	}

	SortedVector<String> getVulnerabilitesVector() const {
		return vulnerabilitesVector;
	}

	void setAcid(float acid) {
		this->acid = acid;
	}

	void setActionEncumbrance(int actionEncumbrance) {
		this->actionEncumbrance = actionEncumbrance;
	}

	void setBlast(float blast) {
		this->blast = blast;
	}

	void setCold(float cold) {
		this->cold = cold;
	}

	void setElectricity(float electricity) {
		this->electricity = electricity;
	}

	void setEnergy(float energy) {
		this->energy = energy;
	}

	void setHealthEncumbrance(int healthEncumbrance) {
		this->healthEncumbrance = healthEncumbrance;
	}

	void setHeat(float heat) {
		this->heat = heat;
	}

	void setKinetic(float kinetic) {
		this->kinetic = kinetic;
	}

	void setLightSaber(float lightSaber) {
		this->lightSaber = lightSaber;
	}

	void setMindEncumbrance(int mindEncumbrance) {
		this->mindEncumbrance = mindEncumbrance;
	}

	void setRating(int rating) {
		this->rating = rating;
	}

	void setSpecialBase(float specialBase) {
		this->specialBase = specialBase;
	}

	void setSpecialResistsVector(SortedVector<String> specialResistsVector) {
		this->specialResistsVector = specialResistsVector;
	}

	void setStun(float stun) {
		this->stun = stun;
	}

	void setVulnerabilitesVector(SortedVector<String> vulnerabilitesVector) {
		this->vulnerabilitesVector = vulnerabilitesVector;
	}

};


#endif /* ARMOROBJECTTEMPLATE_H_ */
