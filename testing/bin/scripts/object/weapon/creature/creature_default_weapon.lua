
object_weapon_creature_creature_default_weapon = object_weapon_creature_shared_creature_default_weapon:new {

	attackType = MELEEATTACK,
	damageType = KINETIC,
	
	certificationsRequired = {  },
	
	creatureAccuracyModifiers = { "unarmed_accuracy" },
	defenderDefenseModifiers = { "melee_defense" },
	speedModifiers = { "unarmed_speed" },
	damageModifiers = { "unarmed_damage" }
	
}

ObjectTemplates:addTemplate(object_weapon_creature_creature_default_weapon, "object/weapon/creature/creature_default_weapon.iff")
