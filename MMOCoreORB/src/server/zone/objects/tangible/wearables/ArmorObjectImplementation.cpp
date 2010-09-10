/*
 * ArmorObjectImplementation.cpp
 *
 *  Created on: 02/08/2009
 *      Author: victor
 */

#include "ArmorObject.h"
#include "server/zone/templates/tangible/ArmorObjectTemplate.h"
#include "server/zone/objects/manufactureschematic/ManufactureSchematic.h"
#include "server/zone/objects/tangible/weapon/WeaponObject.h"

void ArmorObjectImplementation::initializeTransientMembers() {
	TangibleObjectImplementation::initializeTransientMembers();

	setLoggingName("ArmorObject");
}

void ArmorObjectImplementation::loadTemplateData(SharedObjectTemplate* templateData) {
	WearableObjectImplementation::loadTemplateData(templateData);

	if (!templateData->isArmorObjectTemplate())
		return;

	ArmorObjectTemplate* armorTemplate = (ArmorObjectTemplate*) templateData;

	vulnerabilites = armorTemplate->getVulnerabilites();

	healthEncumbrance = armorTemplate->getHealthEncumbrance();
	actionEncumbrance = armorTemplate->getActionEncumbrance();
	mindEncumbrance = armorTemplate->getMindEncumbrance();

	rating = armorTemplate->getRating();

	kinetic = armorTemplate->getKinetic();
	energy = armorTemplate->getEnergy();
	electricity = armorTemplate->getElectricity();
	stun = armorTemplate->getStun();
	blast = armorTemplate->getBlast();
	heat = armorTemplate->getHeat();
	cold = armorTemplate->getCold();
	acid = armorTemplate->getAcid();
	lightSaber = armorTemplate->getLightSaber();

	specialBase = armorTemplate->getSpecialBase();

}

void ArmorObjectImplementation::fillAttributeList(AttributeListMessage* alm, PlayerCreature* object) {
	WearableObjectImplementation::fillAttributeList(alm, object);

	if (socketsLeft() > 0)
		alm->insertAttribute("sockets", socketsLeft());

	wearableSkillModMap.insertStatMods(alm);

	//Armor Rating
	if (rating == LIGHT)
		alm->insertAttribute("armorrating", "@obj_attr_n:armor_pierce_light"); //Light
	else if (rating == MEDIUM)
		alm->insertAttribute("armorrating", "@obj_attr_n:armor_pierce_medium"); //Medium
	else if (rating == HEAVY)
		alm->insertAttribute("armorrating", "@obj_attr_n:armor_pierce_heavy"); //Heavy
	else
		alm->insertAttribute("armorrating", "@obj_attr_n:armor_pierce_none"); //None

	//Check for special protections
	if (isSpecial(WeaponObject::KINETIC) && kinetic >= 0.5) {
		StringBuffer txt;
		txt << round(kinetic) << "%";
		alm->insertAttribute("cat_armor_special_protection.armor_eff_kinetic",
				txt.toString());
	}
	if (isSpecial(WeaponObject::ENERGY) && energy >= 0.5) {
		StringBuffer txt;
		txt << round(energy) << "%";
		alm->insertAttribute("cat_armor_special_protection.armor_eff_energy",
				txt.toString());
	}
	if (isSpecial(WeaponObject::ELECTRICITY) && electricity >= 0.5) {
		StringBuffer txt;
		txt << round(electricity) << "%";
		alm->insertAttribute(
				"cat_armor_special_protection.armor_eff_elemental_electrical",
				txt.toString());
	}
	if (isSpecial(WeaponObject::STUN) && stun >= 0.5) {
		StringBuffer txt;
		txt << round(stun) << "%";
		alm->insertAttribute("cat_armor_special_protection.armor_eff_stun",
				txt.toString());
	}
	if (isSpecial(WeaponObject::BLAST) && blast >= 0.5) {
		StringBuffer txt;
		txt << round(blast) << "%";
		alm->insertAttribute("cat_armor_special_protection.armor_eff_blast",
				txt.toString());
	}
	if (isSpecial(WeaponObject::HEAT) && heat >= 0.5) {
		StringBuffer txt;
		txt << round(heat) << "%";
		alm->insertAttribute(
				"cat_armor_special_protection.armor_eff_elemental_heat",
				txt.toString());
	}
	if (isSpecial(WeaponObject::COLD) && cold >= 0.5) {
		StringBuffer txt;
		txt << round(cold) << "%";
		alm->insertAttribute(
				"cat_armor_special_protection.armor_eff_elemental_cold",
				txt.toString());
	}
	if (isSpecial(WeaponObject::ACID) && acid >= 0.5) {
		StringBuffer txt;
		txt << round(acid) << "%";
		alm->insertAttribute(
				"cat_armor_special_protection.armor_eff_elemental_acid",
				txt.toString());
	}
	if (isSpecial(WeaponObject::LIGHTSABER) && lightSaber >= 0.5) {
		StringBuffer txt;
		txt << round(lightSaber) << "%";
		alm->insertAttribute(
				"cat_armor_special_protection.armor_eff_restraint",
				txt.toString());
	}
	//Check for Effectiveness protections(Normal)
	if (!isSpecial(WeaponObject::KINETIC) && kinetic >= 0.5) {
		StringBuffer txt;
		txt << round(kinetic) << "%";
		alm->insertAttribute("cat_armor_effectiveness.armor_eff_kinetic",
				txt.toString());
	}
	if (!isSpecial(WeaponObject::ENERGY) && energy >= 0.5) {
		StringBuffer txt;
		txt << round(energy) << "%";
		alm->insertAttribute("cat_armor_effectiveness.armor_eff_energy",
				txt.toString());
	}
	if (!isSpecial(WeaponObject::ELECTRICITY) && electricity >= 0.5) {
		StringBuffer txt;
		txt << round(electricity) << "%";
		alm->insertAttribute(
				"cat_armor_effectiveness.armor_eff_elemental_electrical",
				txt.toString());
	}
	if (!isSpecial(WeaponObject::STUN) && stun >= 0.5) {
		StringBuffer txt;
		txt << round(stun) << "%";
		alm->insertAttribute("cat_armor_effectiveness.armor_eff_stun",
				txt.toString());
	}
	if (!isSpecial(WeaponObject::BLAST) && blast >= 0.5) {
		StringBuffer txt;
		txt << round(blast) << "%";
		alm->insertAttribute("cat_armor_effectiveness.armor_eff_blast",
				txt.toString());
	}
	if (!isSpecial(WeaponObject::HEAT) && heat >= 0.5) {
		StringBuffer txt;
		txt << round(heat) << "%";
		alm->insertAttribute(
				"cat_armor_effectiveness.armor_eff_elemental_heat",
				txt.toString());
	}
	if (!isSpecial(WeaponObject::COLD) && cold >= 0.5) {
		StringBuffer txt;
		txt << round(cold) << "%";
		alm->insertAttribute(
				"cat_armor_effectiveness.armor_eff_elemental_cold",
				txt.toString());
	}
	if (!isSpecial(WeaponObject::ACID) && acid >= 0.5) {
		StringBuffer txt;
		txt << round(acid) << "%";
		alm->insertAttribute(
				"cat_armor_effectiveness.armor_eff_elemental_acid",
				txt.toString());
	}
	if (!isSpecial(WeaponObject::LIGHTSABER) && lightSaber >= 0.5) {
		StringBuffer txt;
		txt << round(lightSaber) << "%";
		alm->insertAttribute("cat_armor_effectiveness.armor_eff_restraint",
				txt.toString());
	}

	//Vulnerabilities
	if (kinetic < 0.5)
		alm->insertAttribute("cat_armor_vulnerability.armor_eff_kinetic", "-");

	if (energy < 0.5)
		alm->insertAttribute("cat_armor_vulnerability.armor_eff_energy", "-");

	if (electricity < 0.5)
		alm->insertAttribute(
				"cat_armor_vulnerability.armor_eff_elemental_electrical", "-");

	if (stun < 0.5)
		alm->insertAttribute("cat_armor_vulnerability.armor_eff_stun", "-");

	if (blast < 0.5)
		alm->insertAttribute("cat_armor_vulnerability.armor_eff_blast", "-");

	if (heat < 0.5)
		alm->insertAttribute(
				"cat_armor_vulnerability.armor_eff_elemental_heat", "-");

	if (cold < 0.5)
		alm->insertAttribute(
				"cat_armor_vulnerability.armor_eff_elemental_cold", "-");

	if (acid < 0.5)
		alm->insertAttribute(
				"cat_armor_vulnerability.armor_eff_elemental_acid", "-");

	if (lightSaber < 0.5)
		alm->insertAttribute("cat_armor_vulnerability.armor_eff_restraint", "-");

	//Encumbrances
	alm->insertAttribute("cat_armor_encumbrance.health", healthEncumbrance);

	alm->insertAttribute("cat_armor_encumbrance.action", actionEncumbrance);

	alm->insertAttribute("cat_armor_encumbrance.mind", mindEncumbrance);

	if (craftersName != "") {
		alm->insertAttribute("crafter", craftersName);
	}

	if (craftersSerial != "") {
		alm->insertAttribute("serial_number", craftersSerial);
	}

	if (sliced)
		alm->insertAttribute("arm_attr", "@obj_attr_n:hacked");

}

void ArmorObjectImplementation::updateCraftingValues(ManufactureSchematic* schematic) {

	WearableObjectImplementation::updateCraftingValues(schematic);

	/*
	 * Incoming Values:					Ranges:
	 * sockets							All depend on type of armor
	 * hit_points
	 * armor_effectiveness
	 * armor_integrity
	 * armor_health_encumbrance
	 * armor_action_encumbrance
	 * armor_mind_encumbrance
	 * armor_rating
	 * armor_special_type
	 * armor_special_effectiveness
	 * armor_special_integrity
	 */
	CraftingValues* craftingValues = schematic->getCraftingValues();
	//craftingValues->toString();

	if(schematic->getFirstCraftingUpdate()) {

		specialResists += craftingValues->getCurrentValue("armor_special_type");
		calculateSpecalProtection(schematic);

		setRating((int) craftingValues->getCurrentValue("armor_rating"));

		setMaxCondition((int) craftingValues->getCurrentValue("armor_integrity"));
		setConditionDamage(0);
	}

	setHealthEncumbrance((int) craftingValues->getCurrentValue(
			"armor_health_encumbrance"));
	setActionEncumbrance((int) craftingValues->getCurrentValue(
			"armor_action_encumbrance"));
	setMindEncumbrance((int) craftingValues->getCurrentValue(
			"armor_mind_encumbrance"));

	float base = craftingValues->getCurrentValue("armor_effectiveness");

	setProtection(schematic, WeaponObject::KINETIC, base);
	setProtection(schematic, WeaponObject::ENERGY, base);
	setProtection(schematic, WeaponObject::ELECTRICITY, base);
	setProtection(schematic, WeaponObject::STUN, base);
	setProtection(schematic, WeaponObject::BLAST, base);
	setProtection(schematic, WeaponObject::HEAT, base);
	setProtection(schematic, WeaponObject::COLD, base);
	setProtection(schematic, WeaponObject::ACID, base);
	setProtection(schematic, WeaponObject::LIGHTSABER, base);
}

void ArmorObjectImplementation::calculateSpecalProtection(
		ManufactureSchematic* schematic) {

	CraftingValues* craftingValues = schematic->getCraftingValues();

	float base = craftingValues->getCurrentValue("armor_effectiveness");
	float value, min, max, currentValue;
	String title = "exp_resistance";
	String subtitle;
	//float min = craftingValues->getMinValue("armor_effectiveness");
	//float max = craftingValues->getMaxValue("armor_effectiveness");
	float currentPercentage = craftingValues->getCurrentPercentage("armor_effectiveness");
	float maxPercentage = craftingValues->getMaxPercentage("armor_effectiveness");
	int precision = craftingValues->getPrecision("armor_effectiveness");

	for (int i = 0; i <= 8; ++i) {

		int type = pow(2,i);

		if(isSpecial(type)) {

			subtitle = getStringType(type);

			value = craftingValues->getCurrentValue(subtitle);
			min = 2;
			max = (value - min + (min * currentPercentage)) / currentPercentage;
			currentValue = (currentPercentage * (max - min)) + min;

			craftingValues->addExperimentalProperty(title, subtitle, min, max,
				precision, false);
			craftingValues->setMaxPercentage(subtitle, maxPercentage);
			craftingValues->setCurrentPercentage(subtitle, currentPercentage);
			craftingValues->setCurrentValue(subtitle, currentValue);
		}
	}
}

void ArmorObjectImplementation::setProtection(ManufactureSchematic* schematic,
		int type, float base) {

	CraftingValues* craftingValues = schematic->getCraftingValues();

	float value = craftingValues->getCurrentValue(getStringType(type));

	if (value == CraftingValues::VALUENOTFOUND
			&& schematic->getFirstCraftingUpdate()) {
		craftingValues->lockValue(getStringType(type));
	}

	if (value == CraftingValues::VALUENOTFOUND) {
		if (isVulnerable(type))
			setProtectionValue(type, 0.0f);
		else
			setProtectionValue(type, base);
	} else {
		if (value + base > 80.0f)
			setProtectionValue(type, 80.0f);
		else
			setProtectionValue(type, value + base);
	}
}

String ArmorObjectImplementation::getStringType(int type) {

	switch(type) {
	case WeaponObject::KINETIC:
		return "kineticeffectiveness";
		break;
	case WeaponObject::ENERGY:
		return "energyeffectiveness";
	break;
	case WeaponObject::ELECTRICITY:
		return "electricaleffectiveness";
		break;
	case WeaponObject::STUN:
		return "stuneffectiveness";
		break;
	case WeaponObject::BLAST:
		return "blasteffectiveness";
		break;
	case WeaponObject::HEAT:
		return "heateffectiveness";
		break;
	case WeaponObject::COLD:
		return "coldeffectiveness";
		break;
	case WeaponObject::ACID:
		return "acideffectiveness";
		break;
	case WeaponObject::LIGHTSABER:
		return "restraineffectiveness";
		break;
	default:
		return "";
	}
}

void ArmorObjectImplementation::setProtectionValue(int type, float value) {

	if (type & WeaponObject::KINETIC)
		setKinetic(value);
	if (type & WeaponObject::ENERGY)
		setEnergy(value);
	if (type & WeaponObject::BLAST)
		setBlast(value);
	if (type & WeaponObject::STUN)
		setStun(value);
	if (type & WeaponObject::LIGHTSABER)
		setLightSaber(value);
	if (type & WeaponObject::HEAT)
		setHeat(value);
	if (type & WeaponObject::COLD)
		setCold(value);
	if (type & WeaponObject::ACID)
		setAcid(value);
	if (type & WeaponObject::ELECTRICITY)
		setElectricity(value);
}
