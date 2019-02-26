THEME_PARK_REBEL_BADGE = 107

c3po_missions =
	{
		{
			missionType = "deliver",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_selonian_female", npcName = "random" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/food/base/side_dish_base.iff", itemName = "Food" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 500 }
--				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_1"},
--				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_boots" },
--				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_2"},
--				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_leggings" },
--				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_3"},
--				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_belt" },
--				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_4"},
--				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_gloves" },
--				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_5"},
--				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_bracer_r" },
--				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_6"},
--				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_bracer_l" },
--				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_7"},
--				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_bicep_r" },
--				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_8"},
--				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_bicep_l" },
--				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_9"},
--				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_chest" },
--				{ rewardType = "loot", lootGroup = "theme_park_reward_cis_banner"},
--				{ rewardType = "loot", lootGroup = "theme_park_reward_cis_ring"},
--				{ rewardType = "loot", lootGroup = "theme_park_reward_republic_banner"},
--				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_helmet" }
			}
		},
		{
			missionType = "deliver",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_cis_battle_droid", npcName = "Battle Droid Captain" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/loot/misc/worklight.iff", itemName = "Supplies" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 1000 }
			}
		},
		{
			missionType = "escort",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_captain", npcName = "Captain Taergle" }
			},
			secondarySpawns = {},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 1500 }
			}
		},
		{
			missionType = "deliver",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_captain", npcName = "Captain Drexsler" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/mission/mission_datadisk.iff", itemName = "Contact Information" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 2000 },
				{ rewardType = "faction", faction = "rebel", amount = 50 },
				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_1"},
				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_boots" }
			}
		}
	}

qualdo_missions =
	{
		{
			missionType = "deliver",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_ithorian", npcName = "I'klee'trao" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/loot/tool/comlink_naboo_broken.iff", itemName = "Comlink" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 2000 }
			}
		},
		{
			missionType = "confiscate",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_imperial_sergeant_montage", npcName = "Sergeant Montage" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" }
			},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/component/item/quest_item/particle_sensor.iff", itemName = "Compound" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 2500 }
			}
		},
		{
			missionType = "assassinate",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_imperial_captain_sargon", npcName = "Captain Sargon" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" },
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 3000 }
			}
		},
		{
			missionType = "escort",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_ithorian", npcName = "I'klee'trao" }
			},
			secondarySpawns = {},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "faction", faction = "rebel", amount = 75 },
				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_2"},
				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_leggings"}
			}
		}
	}

wedge_missions =
	{
		{
			missionType = "deliver",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_officer", npcName = "Officer Devlin" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/mission/mission_datadisk.iff", itemName = "Confirmation Letter" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 3500 }
			}
		},
		{
			missionType = "assassinate",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_iris", npcName = "Iris" }
			},
			secondarySpawns = {},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 4000 }
			}
		},
		{
			missionType = "assassinate",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_imperial_general_graise", npcName = "General Graise" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "imperial_first_lieutenant", npcName = "Republic First Lieutenant" },
				{ npcTemplate = "imperial_staff_corporal", npcName = "Republic Staff Corporal" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 4500 }
			}
		},
		{
			missionType = "confiscate",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_imperial_general_boize", npcName = "General Boize" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" },
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" },
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" },
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" }
			},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/mission/mission_datadisk.iff", itemName = "Documents" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 5000 }
			}
		},
		{
			missionType = "confiscate",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_imperial_officer_emil", npcName = "Officer Emil" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" },
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" }
			},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/loot/misc/key_electronic_s01.iff", itemName = "Code Cylinder" }
			},
			rewards =
			{
				{ rewardType = "faction", faction = "rebel", amount = 100 },
				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_3"},
				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_ring" },
				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_belt" }
			}
		}
	}

leia_missions =
	{
		{
			missionType = "escort",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_deasie_afresel", npcName = "Deasie A'Fresel" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 5500 }
			}
		},
		{
			missionType = "escort",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_officer_tennelt", npcName = "Officer Tennelt" }
			},
			secondarySpawns = {},
			itemSpawns = { },
			rewards =
			{
				{ rewardType = "credits", amount = 6000 }
			}
		},
		{
			missionType = "escort",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_selonian_female", npcName = "random" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" },
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 6500 }
			}
		},
		{
			missionType = "deliver",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_bothan", npcName = "Fnast" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/mission/mission_datadisk.iff", itemName = "Republic Codes" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 7000 }
			}
		},
		{
			missionType = "escort",
			planetName = "corellia",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_imperial_commander", npcName = "Republic Undercover Commander" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" },
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "faction", faction = "rebel", amount = 125 },
				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_4"},
				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_bracer_l" }
			}
		}
	}

nien_missions =
	{
		{
			missionType = "escort",
			planetName = "lok",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_engineer", npcName = "Engineer" }
			},
			secondarySpawns = {},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 7500 }
			}
		},
		{
			missionType = "assassinate",
			planetName = "lok",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_bounty_hunter", npcName = "Bounty Hunter" }
			},
			secondarySpawns = {},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 8000 }
			}
		},
		{
			missionType = "assassinate",
			planetName = "lok",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_pirate", npcName = "Pirate" }
			},
			secondarySpawns = {},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 8500 }
			}
		},
		{
			missionType = "retrieve",
			planetName = "lok",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_hyperdrive_seller", npcName = "Pirate" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/loot/misc/hyperdrive_part_s01.iff", itemName = "Hyperdrive" }
			},
			rewards =
			{
				{ rewardType = "faction", faction = "rebel", amount = 150 },
				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_5"},
				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_bracer_r" }
			}
		}
	}

han_missions =
	{
		{
			missionType = "escort",
			planetName = "lok",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_edycu", npcName = "E'Dycu" }
			},
			secondarySpawns = {},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 9000 }
			}
		},
		{
			missionType = "confiscate",
			planetName = "lok",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_pirate_holocron", npcName = "random" },
				{ npcTemplate = "theme_park_rebel_pirate", npcName = "random" },
				{ npcTemplate = "theme_park_rebel_pirate", npcName = "random" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/loot/misc/holocron_splinters_sith_s01.iff", itemName = "" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 9500 }
			}
		},
		{
			missionType = "assassinate",
			planetName = "lok",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_pirate", npcName = "Bandit Leader" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_pirate", npcName = "Pirate" },
				{ npcTemplate = "theme_park_rebel_pirate", npcName = "Pirate" },
				{ npcTemplate = "theme_park_rebel_pirate", npcName = "Pirate" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 10000 }
			}
		},
		{
			missionType = "escort",
			planetName = "lok",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_edycu", npcName = "Eso Itrik" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" },
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 10500 }
			}
		},
		{
			missionType = "deliver",
			planetName = "lok",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_nym_contact", npcName = "Nateba Kerr" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/mission/mission_datadisk.iff", itemName = "Payment" }
			},
			rewards =
			{
				{ rewardType = "faction", faction = "rebel", amount = 175 },
				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_6"},
				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_bicep_l" }
			}
		}
	}

ackbar_missions =
	{
		{
			missionType = "assassinate",
			planetName = "dantooine",
			primarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" },
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" },
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" }
			},
			secondarySpawns = {},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 11000 }
			}
		},
		{
			missionType = "confiscate",
			planetName = "dantooine",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_disgruntled_citizen", npcName = "Disgruntled Citizen" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/mission/mission_datadisk.iff", itemName = "Information" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 11500 }
			}
		},
		{
			missionType = "deliver",
			planetName = "dantooine",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_teria_alessie", npcName = "Teria Alessie" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/mission/mission_datadisk.iff", itemName = "Corrupted Disk" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 12000 }
			}
		},
		{
			missionType = "deliver",
			planetName = "dantooine",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_jeremes_kelton", npcName = "Dabudo Nano" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" },
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" }
			},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/mission/mission_datadisk.iff", itemName = "Flight Paths" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 12500 }
			}
		},
		{
			missionType = "assassinate",
			planetName = "dantooine",
			primarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "Clonetrooper" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "CT-437" },
				{ npcTemplate = "clonetrooper", npcName = "CT-871" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "faction", faction = "rebel", amount = 200 },
				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_7"},
				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_bicep_r" }
			}
		}
	}

mon_missions =
	{
		{
			missionType = "deliver",
			planetName = "dantooine",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_bothan_spy", npcName = "Wala Am'kre" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/mission/mission_datadisk.iff", itemName = "Holovid" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 13000 }
			}
		},
		{
			missionType = "assassinate",
			planetName = "dantooine",
			primarySpawns =
			{
				{ npcTemplate = "clonetrooper_squad_leader", npcName = "Strike Team Leader" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "CT-2210" },
				{ npcTemplate = "clonetrooper", npcName = "CT-9582" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 13500 }
			}
		},
		{
			missionType = "escort",
			planetName = "dantooine",
			missionDescription = "GENERAL GREVIOUS needs you to ESCORT the CAPTAIN of the CIS SHIP back to the SEPARATIST BASE",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_altapi_tmman", npcName = "Alostt Sharn" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "CT-179" },
				{ npcTemplate = "clonetrooper", npcName = "CT-322" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 14000 }
			}
		},
		{
			missionType = "assassinate",
			planetName = "dantooine",
			primarySpawns =
			{
				{ npcTemplate = "clonetrooper_squad_leader", npcName = "CT-1132" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "CT-658" },
				{ npcTemplate = "clonetrooper", npcName = "CT-459" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 14500 }
			}
		},
		{
			missionType = "escort",
			planetName = "dantooine",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_imperial_engineer", npcName = "Engineer" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "CT-134" },
				{ npcTemplate = "clonetrooper", npcName = "CT-873" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 15000 }
			}
		},
		{
			missionType = "assassinate",
			planetName = "dantooine",
			primarySpawns =
			{
				{ npcTemplate = "imperial_general", npcName = "Republic General" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "CT-297" },
				{ npcTemplate = "clonetrooper", npcName = "CT-447" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "faction", faction = "rebel", amount = 225 },
				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_gloves" }
			}
		},
	}

jan_missions =
	{
		{
			missionType = "assassinate",
			planetName = "yavin4",
			primarySpawns =
			{
				{ npcTemplate = "clonetrooper_squad_leader", npcName = "CT-419" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "CT-447" },
				{ npcTemplate = "clonetrooper", npcName = "CT-428" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 15500 }
			}
		},
		{
			missionType = "escort",
			planetName = "yavin4",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_imperial_engineer", npcName = "Republic Engineer" }
			},
			secondarySpawns = {},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 16000 }
			}
		},
		{
			missionType = "assassinate",
			planetName = "yavin4",
			primarySpawns =
			{
				{ npcTemplate = "clonetrooper_squad_leader", npcName = "CT-770" }
			},
			secondarySpawns =
			{
				{ npcTemplate = "clonetrooper", npcName = "CT-400" },
				{ npcTemplate = "clonetrooper", npcName = "CT-105" }
			},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 16500 }
			}
		},
		{
			missionType = "deliver",
			planetName = "yavin4",
			primarySpawns =
			{
				{ npcTemplate = "theme_cis_battle_droid", npcName = "Battle Droid Pilot" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/mission/mission_datadisk.iff", itemName = "Information" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 17000 }
			}
		},
		{
			missionType = "deliver",
			planetName = "yavin4",
			missionDescription = "SAVAGE OPRESS needs you to DELIVER the INFORMATION to BATTLE DROID PILOT",
			primarySpawns =
			{
				{ npcTemplate = "theme_cis_battle_droid", npcName = "Battle Droid Pilot" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/mission/mission_datadisk.iff", itemName = "Information" }
			},
			rewards =
			{
				{ rewardType = "faction", faction = "rebel", amount = 250 },
				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_8"},
				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_helmet" },
				{ rewardType = "permission", permissionGroup = "temple_of_exar_kun2" }
			}
		},
	}

luke_missions =
	{
		{
			missionType = "escort",
			planetName = "yavin4",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_supervisor", npcName = "Supervisor" }
			},
			secondarySpawns = {},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 17500 }
			}
		},
		{
			missionType = "confiscate",
			planetName = "yavin4",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_big_creature", npcName = "Big Creature" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/loot/tool/recording_rod_broken.iff", itemName = "R2 Motivator Unit" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 18000 }
			}
		},
		{
			missionType = "escort",
			planetName = "yavin4",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_supervisor", npcName = "Expidition Team Member" }
			},
			secondarySpawns = {},
			itemSpawns = {},
			rewards =
			{
				{ rewardType = "credits", amount = 18500 }
			}
		},
		{
			missionType = "confiscate",
			planetName = "yavin4",
			primarySpawns =
			{
				{ npcTemplate = "theme_park_rebel_big_creature_cage", npcName = "Big Creature" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/loot/misc/cage_s01.iff", itemName = "" }
			},
			rewards =
			{
				{ rewardType = "credits", amount = 19000 }
			}
		},
		{
			missionType = "deliver",
			planetName = "yavin4",
			primarySpawns =
			{
				{ npcTemplate = "theme_cis_battle_droid", npcName = "Ace Battle Droid Pilot" }
			},
			secondarySpawns = {},
			itemSpawns =
			{
				{ itemTemplate = "object/tangible/loot/misc/cage_s01.iff", itemName = "An Empty Cage" }
			},
			rewards =
			{
				{ rewardType = "faction", faction = "rebel", amount = 4250 },
				{ rewardType = "credits", amount = 19500 },
				{ rewardType = "loot", lootGroup = "theme_park_reward_joint_9"},
				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_chest" },
				{ rewardType = "loot",  lootGroup = "theme_park_reward_cis_banner" },
				{ rewardType = "badge", badge = THEME_PARK_REBEL_BADGE }
			}
		},
	}

npcMapRebel =
	{
		{
			spawnData = { planetName = "corellia", npcTemplate = "theme_b1", x = -2.3, z = 2.0, y = 4.0, direction = 150, cellID = 8555472, position = STAND },
			worldPosition = { x = -6507.5, y = 5985.7 },
			npcNumber = 1,
			stfFile = "@theme_park_rebel/c3po",
			missions = c3po_missions
		},
		{
			spawnData = { planetName = "corellia", npcTemplate = "cis_battle_droid", x = -3.98, z = 1.01, y = -0.67, direction = 58, cellID = 8555472, position = STAND },
			npcNumber = -1,
			stfFile = "",
			missions = {}
		},
		{
			spawnData = { planetName = "corellia", npcTemplate = "record_keeper_rebel", x = 6.0, z = 7.00, y = -5.18, direction = 0, cellID = 8555480, position = STAND },
			npcNumber = -2,
			stfFile = "",
			missions = {}
		},
		{
			spawnData = { planetName = "corellia", npcTemplate = "theme_po", x = 14.91, z = 1.01, y = -6.68, direction = 0, cellID = 8555475, position = STAND },
			worldPosition = { x = -6512.3, y = 6005.2 },
			npcNumber = 2,
			stfFile = "@theme_park_rebel/qualdo_herm",
			missions = qualdo_missions
		},
		{
			spawnData = { planetName = "corellia", npcTemplate = "theme_mars_onyo", x = 0.01, z = 1.01, y = -22.01, direction = 0, cellID = 8555477, position = SIT },
			worldPosition = { x = -6491.1, y = 6005.6 },
			npcNumber = 4,
			stfFile = "@theme_park_rebel/wedge_antilles",
			missions = wedge_missions
		},
		{
			spawnData = { planetName = "corellia", npcTemplate = "theme_sevrance_tann", x = -11.13, z = 7.00971, y = 11.31, direction = 175, cellID = 8555481, position = STAND },
			worldPosition = { x = -6506.3, y = 5974.2 },
			npcNumber = 8,
			stfFile = "@theme_park_rebel/princess_leia",
			missions = leia_missions
		},
		{
			spawnData = { planetName = "lok", npcTemplate = "theme_cad_bane", x = -12.12, z = -0.894992, y = 23.08, direction = 80.0024, cellID = 8145384, position = SIT },
			worldPosition = { x = 476.2, y = 5075.7 },
			npcNumber = 16,
			stfFile = "@theme_park_rebel/nien_nunb",
			missions = nien_missions
		},
		{
			spawnData = { planetName = "lok", npcTemplate = "theme_asajj_ventress", x = -30.2, z = -0.519991, y = 7.24, direction = 45.0013, cellID = 8145388, position = STAND },
			worldPosition = { x = 471.5, y = 5052.1 },
			npcNumber = 32,
			stfFile = "@theme_park_rebel/han_solo",
			missions = han_missions
		},
		{
			spawnData = { planetName = "dantooine", npcTemplate = "theme_magnaguard", x = -14.4, z = 1.0, y = -21.7, direction = 0, cellID = 6555566, position = STAND },
			worldPosition = { x = -6812.5, y = 5560.7 },
			npcNumber = 64,
			stfFile = "@theme_park_rebel/captain_ackbar",
			missions = ackbar_missions
		},
		{
			spawnData = { planetName = "dantooine", npcTemplate = "theme_general_grievous", x = -3.4, z = 7.0, y = -12.2, direction = -34, cellID = 6555568, position = STAND },
			worldPosition = { x = -6823.6, y = 5551.2 },
			npcNumber = 128,
			stfFile = "@theme_park_rebel/mon_mothma",
			missions = mon_missions
		},
		{
			spawnData = { planetName = "yavin4", npcTemplate = "theme_savage_opress", x = 0, z = 0, y = -41.9, direction = 0, cellID = 3465388, position = STAND },
			worldPosition = { x = 5014.8, y = 5537.8 },
			npcNumber = 256,
			stfFile = "@theme_park_rebel/jan_dodonna",
			missions = jan_missions
		},
		{
			spawnData = { planetName = "yavin4", npcTemplate = "theme_count_dooku", x = 1.2, z = -6.0, y = -26.8, direction = 180, cellID = 3465390, position = STAND },
			worldPosition = { x = 5029.9, y = 5536.6 },
			npcNumber = 512,
			stfFile = "@theme_park_rebel/luke_skywalker",
			missions = luke_missions
		}
	}

permissionMapRebel = {
	{
		planetName = "corellia",
		regionName = "rebel_hideout",
		permissions =
		{
			{
				cells = { 8555471, 8555472, 8555473, 8555474, 8555475, 8555476, 8555477, 8555478, 8555479, 8555480, 8555481, 8555482 },
				conditions =
				{
					{ permissionType = "faction" }
				}
			}
		}
	},
	{
		planetName = "dantooine",
		regionName = "abandoned_rebel_base_1",
		permissions =
		{
			{
				cells = { 6555559, 6555560, 6555561, 6555562, 6555563, 6555564, 6555565, 6555566, 6555567, 6555568, 6555569, 6555570 },
				conditions =
				{
					{ permissionType = "faction" }
				}
			}
		}
	},
	{
		planetName = "yavin4",
		regionName = "temple_of_exar_kun",
		permissions =
		{
			{
				cells = { 3465380, 3465381, 3465382, 3465383, 3465384, 3465385, 3465386, 3465387, 3465388, 3465389 },
				conditions =
				{
					{ permissionType = "missionState", mission = "theme_park_rebel", missionState = 128 },
					{ permissionType = "faction" }
				}
			},
			{
				cells = { 3465390, 3465391, 3465392, 3465393, 3465394 },
				conditions =
				{
					{ permissionType = "missionState", mission = "theme_park_rebel", missionState = 256 },
					{ permissionType = "faction" }
				}
			}
		}
	}
}

ThemeParkRebel = ThemeParkLogic:new {
	npcMap = npcMapRebel,
	permissionMap = permissionMapRebel,
	className = "ThemeParkRebel",
	screenPlayState = "rebel_theme_park",
	missionDescriptionStf = "@theme_park_rebel/quest_details:rebel_hideout_",
	missionCompletionMessageStf = "@theme_park/messages:rebel_completion_message",
	requiredPlanets = { "corellia", "lok", "dantooine", "yavin4" },
	faction = FACTIONREBEL
}

registerScreenPlay("ThemeParkRebel", true)

theme_park_rebel_mission_giver_conv_handler = mission_giver_conv_handler:new {
	themePark = ThemeParkRebel
}
theme_park_rebel_mission_target_conv_handler = mission_target_conv_handler:new {
	themePark = ThemeParkRebel
}
