wodPrologueRewardManager = {
	herbs = {
		credits = 2000,
		extraCredits = 100,
		rewardOnce = false, --Award reward repeatedly. Default setting: false
		rewardInterval = 1, --Set how often rewards are granted. Reward is always granted on first completion. Default setting: 1
		rewardType = "all", --Set reward type, "all", "random", "pick"
		reward = {
			"object/tangible/furniture/all/wod_pro_seed_jar.iff",
		}
		collectionRewardOnce = false, --Award reward repeatedly. Default setting: false
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
	enemies = {
		rewardOnce = false, --Award reward repeatedly. Default setting: false
		rewardInterval = 1, --Set how often rewards are granted. Reward is always granted on first completion. Default setting: 1
		rewardType = "pick",
		reward = { -- Players pick a reward from the list below.
			{"object/tangible/veteran_reward/frn_reptilian_flyer_toy.iff", "Miniature Reptilian Flyer"},
			{"object/tangible/veteran_reward/frn_shear_mite_toy.iff", "Miniature Shear Mite"},
			{"object/tangible/veteran_reward/frn_malkloc_toy.iff", "Miniature Malkloc"},
		},
		collectionRewardOnce = false, --Award reward repeatedly. Default setting: false
		collectionCount = 5,
		collectionRewardType = "all",
		collectionReward = {
			"object/tangible/veteran_reward/frn_mutated_rancor_toy.iff",
		}
	},
	wisdom = {
		rewardOnce = false, --Award reward repeatedly. Default setting: false
		rewardInterval = 1, --Set how often rewards are granted. Reward is always granted on first completion. Default setting: 1
		rewardType = "pick",
		reward = {
			"object/tangible/painting/painting_wod_scene_01.iff",
			"object/tangible/painting/painting_wod_scene_02.iff",
			"object/tangible/painting/painting_wod_scene_03.iff",
			"object/tangible/painting/painting_wod_scene_04.iff",
		},
		collectionRewardOnce = false, --Award reward repeatedly. Default setting: false
		collectionCount = 5,
		collectionRewardType = "all",
		collectionRewardSM = {
			"object/tangible/painting/painting_wod_sm_01.iff",
		},
		collectionRewardSM = {
			"object/tangible/painting/painting_wod_ns_01.iff",
		}
	},
	collectionCount = 5,
}