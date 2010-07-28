/*
 * WeaponObjectImplementation.cpp
 *
 *  Created on: 30/07/2009
 *      Author: victor
 */

#include "WeaponObject.h"
#include "server/zone/packets/tangible/WeaponObjectMessage3.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "server/zone/packets/scene/AttributeListMessage.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/zone/templates/tangible/SharedWeaponObjectTemplate.h"
#include "server/zone/managers/templates/TemplateManager.h"
#include "server/zone/objects/manufactureschematic/ManufactureSchematic.h"


void WeaponObjectImplementation::initializeTransientMembers() {
	TangibleObjectImplementation::initializeTransientMembers();

	weaponTemplate = dynamic_cast<SharedWeaponObjectTemplate*>(TemplateManager::instance()->getTemplate(serverObjectCRC));

	setLoggingName("WeaponObject");
}

void WeaponObjectImplementation::loadTemplateData(SharedObjectTemplate* templateData) {
	TangibleObjectImplementation::loadTemplateData(templateData);

	weaponTemplate = dynamic_cast<SharedWeaponObjectTemplate*>(templateData);

	certified = false;

	attackType = weaponTemplate->getAttackType();
	weaponEffect =  weaponTemplate->getWeaponEffect();
	weaponEffectIndex = weaponTemplate->getWeaponEffectIndex();

	//xpType = weaponTemplate->getXpType();

	damageType = weaponTemplate->getDamageType();

	//certificationsRequired = weaponTemplate->getCertificationsRequired();
	//creatureAccuracyModifiers = weaponTemplate->getCreatureAccuracyModifiers();
	//defenderDefenseModifiers = weaponTemplate->getDefenderDefenseModifiers();
	//damageModifiers = weaponTemplate->getDamageModifiers();
	//speedModifiers = weaponTemplate->getSpeedModifiers();
	//defenderSecondaryDefenseModifiers = weaponTemplate->getDefenderSecondaryDefenseModifiers();

	armorPiercing = weaponTemplate->getArmorPiercing();

	healthAttackCost = weaponTemplate->getHealthAttackCost();
	actionAttackCost = weaponTemplate->getActionAttackCost();
	mindAttackCost = weaponTemplate->getMindAttackCost();
	forceCost = weaponTemplate->getForceCost();

	pointBlankAccuracy = weaponTemplate->getPointBlankAccuracy();
	pointBlankRange = weaponTemplate->getPointBlankRange();

	idealRange = weaponTemplate->getIdealRange();
	idealAccuracy = weaponTemplate->getIdealAccuracy();

	maxRange = weaponTemplate->getMaxRange();
	maxRangeAccuracy = weaponTemplate->getMaxRangeAccuracy();

	minDamage = weaponTemplate->getMinDamage();
	maxDamage = weaponTemplate->getMaxDamage();

	woundsRatio = weaponTemplate->getWoundsRatio();

	area = weaponTemplate->getArea();

	attackSpeed = weaponTemplate->getAttackSpeed();
}

void WeaponObjectImplementation::sendBaselinesTo(SceneObject* player) {
	info("sending weapon object baselines");

	BaseMessage* weao3 = new WeaponObjectMessage3(_this);
	player->sendMessage(weao3);
}

void WeaponObjectImplementation::fillAttributeList(AttributeListMessage* alm, PlayerCreature* object) {
	TangibleObjectImplementation::fillAttributeList(alm, object);

	bool res = isCertifiedFor(object);

	if (res) {
		alm->insertAttribute("weapon_cert_status", "Yes");
	} else {
		alm->insertAttribute("weapon_cert_status", "No");
	}

	/*if (usesRemaining > 0)
		alm->insertAttribute("count", usesRemaining);*/

	/*int key = 0;
	int value = 0;
	for (int i = 0; i < innateSkillModMap.size(); ++i) {
		key = innateSkillModMap.elementAt(i).getKey();
		value = innateSkillModMap.elementAt(i).getValue();

		if (value > 0)
			generateSkillMods(alm, key, value);
	}*/

	String ap;

	switch (armorPiercing) {
	case NONE:
		ap = "None";
		break;
	case LIGHT:
		ap = "Light";
		break;
	case MEDIUM:
		ap = "Medium";
		break;
	case HEAVY:
		ap = "Heavy";
		break;
	default:
		ap = "Unknown";
		break;
	}

	alm->insertAttribute("wpn_armor_pierce_rating", ap);

	float speed = round(10 * attackSpeed) / 10;

	StringBuffer spdtxt;

	spdtxt << speed;

	if ((int(round(speed * 10)) % 10) == 0)
		spdtxt << ".0";

	alm->insertAttribute("wpn_attack_speed", spdtxt.toString());

	/*if (area != 0.0f)
		alm->insertAttribute("area", Math::getPrecision(area, 0));*/

	//Damage Information
	StringBuffer dmgtxt;

	switch (damageType) {
	case KINETIC:
		dmgtxt << "Kinetic";
		break;
	case ENERGY:
		dmgtxt << "Energy";
		break;
	case ELECTRICITY:
		dmgtxt << "Electricity";
		break;
	case STUN:
		dmgtxt << "Stun";
		break;
	case BLAST:
		dmgtxt << "Blast";
		break;
	case HEAT:
		dmgtxt << "Heat";
		break;
	case COLD:
		dmgtxt << "Cold";
		break;
	case ACID:
		dmgtxt << "Acid";
		break;
	case LIGHTSABER:
		dmgtxt << "Lightsaber";
		break;
	default:
		dmgtxt << "Unknown";
		break;
	}

	alm->insertAttribute("damage.wpn_damage_type", dmgtxt);

	float minDmg = round(getMinDamage());
	float maxDmg = round(getMaxDamage());

	alm->insertAttribute("damage.wpn_damage_min", minDmg);

	alm->insertAttribute("damage.wpn_damage_max", maxDmg);

	StringBuffer woundsratio;

	float wnd = round(10 * getWoundsRatio()) / 10.0f;

	woundsratio << wnd << "%";

	alm->insertAttribute("damage.wpn_wound_chance", woundsratio);

	//Accuracy Modifiers
	StringBuffer pblank;
	if (getPointBlankAccuracy() >= 0)
		pblank << "+";

	pblank << getPointBlankAccuracy() << " @ " << getPointBlankRange() << "m";
	alm->insertAttribute("cat_wpn_rangemods.wpn_range_zero", pblank);

	StringBuffer ideal;
	if (getIdealAccuracy() >= 0)
		ideal << "+";

	ideal << getIdealAccuracy() << " @ " << getIdealRange() << "m";
	alm->insertAttribute("cat_wpn_rangemods.wpn_range_mid", ideal);

	StringBuffer maxrange;
	if (getMaxRangeAccuracy() >= 0)
		maxrange << "+";

	maxrange << getMaxRangeAccuracy() << " @ " << getMaxRange() << "m";
	alm->insertAttribute("cat_wpn_rangemods.wpn_range_max", maxrange);

	//Special Attack Costs
	alm->insertAttribute("cat_wpn_attack_cost.health", getHealthAttackCost());

	alm->insertAttribute("cat_wpn_attack_cost.action", getActionAttackCost());

	alm->insertAttribute("cat_wpn_attack_cost.mind", getMindAttackCost());

	// Force Cost
	if (getForceCost() > 0)
		alm->insertAttribute("forcecost", getForceCost());

	/*if (getDotCount() > 0)
		generateDotAttributes(alm);*/

	if (sliced == 1)
		alm->insertAttribute("wpn_attr", "@obj_attr_n:hacked1");

	//generatePowerup(alm);
}

void WeaponObjectImplementation::updateCraftingValues(ManufactureSchematic* schematic) {
	/*
	 * Incoming Values:					Ranges:
	 * mindamage						Differs between weapons
	 * maxdamage
	 * attackspeed
	 * woundchance
	 * roundsused
	 * hitpoints
	 * zerorangemod
	 * maxrange
	 * maxrangemod
	 * midrange
	 * midrangemod
	 * charges
	 * attackhealthcost
	 * attackactioncost
	 * attackmindcost
	 */
	CraftingValues* craftingValues = schematic->getCraftingValues();

	float value = 0.f;
	setMinDamage(craftingValues->getCurrentValue("mindamage"));
	setMaxDamage(craftingValues->getCurrentValue("maxdamage"));

	setAttackSpeed(craftingValues->getCurrentValue("attackspeed"));
	setHealthAttackCost((int)craftingValues->getCurrentValue("attackhealthcost"));
	setActionAttackCost((int)craftingValues->getCurrentValue("attackactioncost"));
	setMindAttackCost((int)craftingValues->getCurrentValue("attackmindcost"));

	value = craftingValues->getCurrentValue("woundchance");
	if(value != CraftingValues::VALUENOTFOUND)
		setWoundsRatio(value);

	//value = craftingValues->getCurrentValue("roundsused");
	//if(value != DraftSchematicValuesImplementation::VALUENOTFOUND)
		//_this->set_______(value);

	value = craftingValues->getCurrentValue("zerorangemod");
	if(value != CraftingValues::VALUENOTFOUND)
		setPointBlankAccuracy((int)value);

	value = craftingValues->getCurrentValue("maxrange");
	if(value != CraftingValues::VALUENOTFOUND)
		setMaxRange((int)value);

	value = craftingValues->getCurrentValue("maxrangemod");
	if(value != CraftingValues::VALUENOTFOUND)
		setMaxRangeAccuracy((int)value);

	value = craftingValues->getCurrentValue("midrange");
	if(value != CraftingValues::VALUENOTFOUND)
		setIdealRange((int)value);

	value = craftingValues->getCurrentValue("midrangemod");
	if(value != CraftingValues::VALUENOTFOUND)
		setIdealAccuracy((int)value);

	//value = craftingValues->getCurrentValue("charges");
	//if(value != CraftingValues::VALUENOTFOUND)
	//	setUsesRemaining((int)value);

	value = craftingValues->getCurrentValue("hitpoints");
	if(value != CraftingValues::VALUENOTFOUND)
		setMaxCondition((int)value);

	setConditionDamage(0);
}

bool WeaponObjectImplementation::isCertifiedFor(PlayerCreature* object) {
	PlayerObject* ghost = object->getPlayerObject();

	Vector<String>* certificationsRequired = weaponTemplate->getCertificationsRequired();

	for (int i = 0; i < certificationsRequired->size(); ++i) {
		String cert = certificationsRequired->get(i);

		if (!ghost->hasSkill(cert)) {
			return false;
		}
	}

	return true;
}
