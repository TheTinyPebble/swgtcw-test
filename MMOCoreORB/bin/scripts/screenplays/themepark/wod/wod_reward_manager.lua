wodPrologueRewardManager = {
	herbs = {
		credits = 2000,
		extraCredits = 100,
		rewardOnce = false, --Award reward only once. Default setting: false
		rewardInterval = 1, --Set how often rewards are granted. Reward is always granted on first completion. Default setting: 1
		rewardType = "all", --Set reward type, "all", "random", "pick"
		reward = {
			"object/tangible/furniture/all/wod_pro_seed_jar.iff",
		},
		collectionRewardOnce = false, --Award reward only once. Default setting: false
		collectionCount = 5,
		collectionRewardType = "random", --Set collection reward type, "all", "random", "pick"
		collectionRewardSM = {
			"object/tangible/furniture/all/wod_pro_sm_seed_jar_01.iff",
			"object/tangible/furniture/all/wod_pro_sm_seed_jar_02.iff",
			"object/tangible/furniture/all/wod_pro_sm_seed_jar_03.iff",
			"object/tangible/furniture/all/wod_pro_sm_seed_jar_04.iff",
			"object/tangible/furniture/all/wod_pro_sm_seed_jar_05.iff",
			"object/tangible/furniture/all/wod_pro_sm_seed_jar_06.iff",
			"object/tangible/furniture/all/wod_pro_sm_seed_jar_07.iff",
			"object/tangible/furniture/all/wod_pro_sm_seed_jar_08.iff",
		},
		collectionRewardNS = {
			"object/tangible/furniture/all/wod_pro_ns_seed_jar_01.iff",
			"object/tangible/furniture/all/wod_pro_ns_seed_jar_02.iff",
			"object/tangible/furniture/all/wod_pro_ns_seed_jar_03.iff",
			"object/tangible/furniture/all/wod_pro_ns_seed_jar_04.iff",
			"object/tangible/furniture/all/wod_pro_ns_seed_jar_05.iff",
			"object/tangible/furniture/all/wod_pro_ns_seed_jar_06.iff",
			"object/tangible/furniture/all/wod_pro_ns_seed_jar_07.iff",
			"object/tangible/furniture/all/wod_pro_ns_seed_jar_08.iff",
		}
	},
	
	enemiesRancor = {
		rewardOnce = false, --Award reward only once. Default setting: false
		rewardInterval = 1, --Set how often rewards are granted. Reward is always granted on first completion. Default setting: 1
		rewardType = "pick",
		reward = { -- Players pick a reward from the list below.
			{"object/tangible/veteran_reward/frn_reptilian_flyer_toy.iff", "Miniature Reptilian Flyer"},
			{"object/tangible/veteran_reward/frn_shear_mite_toy.iff", "Miniature Shear Mite"},
			{"object/tangible/veteran_reward/frn_malkloc_toy.iff", "Miniature Malkloc"},
		},
		collectionRewardOnce = false,
		collectionCount = 5,
		collectionRewardType = "all",
		collectionReward = {
			"object/tangible/veteran_reward/frn_mutated_rancor_toy.iff",
		}
	},
	
	enemiesSpiderclan = {
		rewardOnce = false,
		rewardInterval = 1,
		rewardType = "pick",
		reward = {
			{"object/tangible/veteran_reward/frn_reptilian_flyer_toy.iff", "Miniature Reptilian Flyer"},
			{"object/tangible/veteran_reward/frn_shear_mite_toy.iff", "Miniature Shear Mite"},
			{"object/tangible/veteran_reward/frn_malkloc_toy.iff", "Miniature Malkloc"},
		},
		collectionRewardOnce = false,
		collectionCount = 5,
		collectionRewardType = "all",
		collectionReward = {
			"object/tangible/veteran_reward/frn_gaping_spider_toy.iff",
		}
	},
	
	wisdom = {
		rewardOnce = false,
		rewardInterval = 1,
		rewardType = "pick",
		reward = {
			{"object/tangible/painting/painting_wod_scene_01.iff", "Dathomir Forest Scenery"},
			{"object/tangible/painting/painting_wod_scene_02.iff", "Dathomir Plains Scenery"},
			{"object/tangible/painting/painting_wod_scene_03.iff", "Dathomirian Portal"},
			{"object/tangible/painting/painting_wod_scene_04.iff", "Dathomir Mountain Scenery"},
		},
		collectionRewardOnce = false,
		collectionCount = 5,
		collectionRewardType = "all",
		collectionRewardSM = {
			"object/tangible/painting/painting_wod_sm_01.iff",
		},
		collectionRewardSM = {
			"object/tangible/painting/painting_wod_ns_01.iff",
		}
	},
}

wodRewardManager = {
	herbs = {
		extraCredits = 100,
		rewardOnce = false, --Award reward only once. Default setting: false
		rewardInterval = 1, --Set how often rewards are granted. Reward is always granted on first completion. Default setting: 1
		rewardType = "all", --Set reward type, "all", "random", "pick"
		reward = {
			"object/tangible/furniture/all/wod_seed_jar.iff",
			"object/tangible/furniture/all/wod_seed_jar.iff",
		},
		rewardRandomValuable = 2, --Set how many random valuables should be rewarded.
		collectionRewardOnce = false,
		collectionCount = 5,
		collectionRewardType = "all",
		collectionReward = {
			"object/tangible/furniture/all/wod_ns_seed_jar.iff",
		},
	},
	
	enemiesOtherclan = {
		rewardOnce = false,
		rewardInterval = 1,
		rewardType = "pick",
		rewardCount = 3, --Set the amount rewarded (only use for tokens)
		reward = { -- Players pick a reward from the list below.
			{"object/tangible/content/wod_token_1.iff", "Dathomir Amber"},
			{"object/tangible/content/wod_token_2.iff", "Spider Silk"},
			{"object/tangible/content/wod_token_3.iff", "Rancor Teeth"},
			{"object/tangible/content/wod_token_4.iff", "Whuffa Leather"},
			{"object/tangible/content/wod_token_5.iff", "Rare Dried Herbs"},
		},
	},
	
	enemiesSpiderclan = {
		rewardOnce = false,
		rewardInterval = 1,
		rewardType = "pick",
		rewardCount = 3,
		reward = { 
			{"object/tangible/content/wod_token_1.iff", "Dathomir Amber"},
			{"object/tangible/content/wod_token_2.iff", "Spider Silk"},
			{"object/tangible/content/wod_token_3.iff", "Rancor Teeth"},
			{"object/tangible/content/wod_token_4.iff", "Whuffa Leather"},
			{"object/tangible/content/wod_token_5.iff", "Rare Dried Herbs"},
		},
	},
	
	hunting = {
		rewardOnce = false,
		rewardInterval = 1,
		rewardType = "all",
		reward = {
			"object/tangible/content/wod_token_4.iff",
		},
		rewardRandomValuable = 1,
		collectionRewardOnce = true,
		collectionCount = 7,
		collectionNSBadgeToAward = "",
		collectionSMBadgeToAward = "",
	},

	fishing = {
		rewardOnce = false,
		rewardInterval = 1,
		rewardType = "pick",
		rewardCount = 3,
		reward = { 
			{"object/tangible/content/wod_token_1.iff", "Dathomir Amber"},
			{"object/tangible/content/wod_token_2.iff", "Spider Silk"},
			{"object/tangible/content/wod_token_3.iff", "Rancor Teeth"},
			{"object/tangible/content/wod_token_4.iff", "Whuffa Leather"},
			{"object/tangible/content/wod_token_5.iff", "Rare Dried Herbs"},
		},
		collectionRewardOnce = true,
		collectionCount = 7,
		collectionNSBadgeToAward = "",
		collectionSMBadgeToAward = "",
	},
	
	rancorTamer = {
		rewardOnce = false,
		rewardInterval = 1,
		rewardType = "all",
		rewardCount = 2,
		reward = { 
			"object/tangible/content/wod_token_1.iff",
			"object/tangible/content/wod_token_2.iff",
		},
		rewardRandomValuable = 2,
		collectionRewardOnce = true,
		collectionCount = 7,
		collectionNSBadgeToAward = "",
		collectionSMBadgeToAward = "",
	},
	
	repairAltar1 = {
		rewardType = "all",
		rewardCount = 4,
		reward = { 
			"object/tangible/content/wod_token_4.iff",
		},
		rewardRandomValuable = 2,
	},
	
	repairAltar2 = {
		rewardType = "all",
		rewardCount = 4,
		reward = { 
			"object/tangible/content/wod_token_4.iff",
		},
		rewardRandomValuable = 2,
	},
	
	repairAltar3 = {
		rewardType = "all",
		rewardCount = 4,
		reward = { 
			"object/tangible/content/wod_token_2.iff",
		},
		rewardRandomValuable = 2,
	},
	
	repairAltar4 = {
		rewardType = "all",
		rewardCount = 4,
		reward = { 
			"object/tangible/content/wod_token_2.iff",
		},
		rewardRandomValuable = 2,
	},
	
	firstSister = {
		rewardType = "all",
		rewardCount = 4,
		reward = { 
			"object/tangible/content/wod_token_1.iff",
		},
		rewardRandomValuable = 4,
	},
	
	secondSister = {
		rewardType = "all",
		rewardCount = 4,
		reward = { 
			"object/tangible/content/wod_token_1.iff",
		},
		rewardRandomValuable = 4,
	},
	
	thirdSister = {
		rewardType = "all",
		rewardCount = 6,
		reward = { 
			"object/tangible/content/wod_token_1.iff",
		},
		rewardRandomValuable = 4,
	},
	
	ghostReward = {
		rewardType = "all",
		rewardCount = 3,
		reward = { 
			"object/tangible/content/wod_token_1.iff",
		},
		rewardRandomValuable = 3,
	},
	
	ghostReward = {
		rewardType = "all",
		rewardCount = 3,
		reward = { 
			"object/tangible/content/wod_token_1.iff",
		},
		rewardRandomValuable = 3,
	},
	
	wholeTruth1 = {
		rewardType = "all",
		rewardCount = 4,
		reward = { 
			"object/tangible/content/wod_token_3.iff",
		},
		rewardRandomValuable = 4,
	},
	
	wholeTruth2 = {
		rewardType = "all",
		rewardCount = 4,
		reward = { 
			"object/tangible/content/wod_token_3.iff",
		},
		rewardRandomValuable = 4,
	},
	
	greaterGood = {
		credits = 4000,
		rewardType = "all",
		rewardCount = 6,
		reward = { 
			"object/tangible/content/wod_token_3.iff",
		},
		rewardRandomValuable = 3,
	},
	
	lostE01 = {
		rewardType = "all",
		rewardCount = 2,
		reward = { 
			"object/tangible/content/wod_token_2.iff",
		},
		rewardRandomValuable = 2,
	},
	
	lostE02 = {
		rewardType = "all",
		rewardCount = 3,
		reward = { 
			"object/tangible/content/wod_token_2.iff",
		},
		rewardRandomValuable = 3,
	},
	
	ehs = {
		rewardType = "all",
		rewardCount = 3,
		reward = { 
			"object/tangible/content/wod_token_2.iff",
		},
		rewardRandomValuable = 3,
	},
	
	huntingParty = {
		credits = 4000,
		rewardType = "all",
		rewardCount = 6,
		reward = { 
			"object/tangible/content/wod_token_2.iff",
		},
		rewardRandomValuable = 3,
	},
}