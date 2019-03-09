local ObjectManager = require("managers.object.object_manager")

local QuestManager = {}

local QUEST_ACTIVE = 1
local QUEST_COMPLETED = 1

-- Activate the quest for the player.
-- @param pCreatureObject pointer to the creature object of the player.
-- @param quest the index number for the quest to activate.
function QuestManager.activateQuest(pCreatureObject, quest)
	local pGhost = CreatureObject(pCreatureObject):getPlayerObject()

	if (pGhost == nil) then
		return
	end

	if (QuestManager.shouldSendSystemMessage(pCreatureObject, quest)) then
		CreatureObject(pCreatureObject):sendSystemMessage("@quest/quests:quest_journal_updated")
	end

	PlayerObject(pGhost):setActiveQuestsBit(quest, QUEST_ACTIVE)
end

-- Checks if the player has a quest active.
-- @param pCreatureObject pointer to the creature object of the player.
-- @param quest the index number for the quest to check if it is active.
function QuestManager.hasActiveQuest(pCreatureObject, quest)
	local pGhost = CreatureObject(pCreatureObject):getPlayerObject()

	if (pGhost == nil) then
		return false
	end

	return PlayerObject(pGhost):hasActiveQuestBitSet(quest)
end

-- Complete the quest for the player.
-- @param pCreatureObject pointer to the creature object of the player.
-- @param quest the index number for the quest to complete.
function QuestManager.completeQuest(pCreatureObject, quest)
	local pGhost = CreatureObject(pCreatureObject):getPlayerObject()

	if (pGhost == nil) then
		return
	end

	if (QuestManager.shouldSendSystemMessage(pCreatureObject, quest)) then
		local summary = QuestManager.getJournalSummary(quest)

		if (summary ~= "") then
			CreatureObject(pCreatureObject):sendSystemMessage(summary)
		end

		CreatureObject(pCreatureObject):sendSystemMessage("@quest/quests:task_complete")
	end

	PlayerObject(pGhost):clearActiveQuestsBit(quest)
	PlayerObject(pGhost):setCompletedQuestsBit(quest, QUEST_COMPLETED)
end

-- Un-Complete the quest for the player and set quest active again.
-- @param pCreatureObject pointer to the creature object of the player.
-- @param quest the index number for the quest to complete.
function QuestManager.uncompleteQuest(pCreatureObject, quest)
	local pGhost = CreatureObject(pCreatureObject):getPlayerObject()

	if (pGhost == nil) then
		return
	end

	PlayerObject(pGhost):clearCompletedQuestsBit(quest)
	PlayerObject(pGhost):setActiveQuestsBit(quest, QUEST_ACTIVE)
end

-- Checks if the player has a quest completed.
-- @param pCreatureObject pointer to the creature object of the player.
-- @param quest the index number for the quest to check if it is completed.
function QuestManager.hasCompletedQuest(pCreatureObject, quest)
	local pGhost = CreatureObject(pCreatureObject):getPlayerObject()

	if (pGhost == nil) then
		return false
	end

	return PlayerObject(pGhost):hasCompletedQuestsBitSet(quest)
end

-- Reset the quest for the player.
-- @param pCreatureObject pointer to the creature object of the player.
-- @param quest the index number for the quest to reset.
function QuestManager.resetQuest(pCreatureObject, quest)
	local pGhost = CreatureObject(pCreatureObject):getPlayerObject()

	if (pGhost == nil) then
		return
	end

	PlayerObject(pGhost):clearActiveQuestsBit(quest)
	PlayerObject(pGhost):clearCompletedQuestsBit(quest)
end

function QuestManager.failQuest(pCreatureObject, quest)
	if (QuestManager.shouldSendSystemMessage(pCreatureObject, quest)) then
		CreatureObject(pCreatureObject):sendSystemMessage("@quest/quests:task_failure")
	end

	QuestManager.resetQuest(pCreatureObject, quest)
end

function QuestManager.shouldSendSystemMessage(pCreatureObject, quest)
	local pQuest = getQuestInfo(quest)

	if (pQuest == nil) then
		return false
	end

	return LuaQuestInfo(pQuest):shouldSendSystemMessage()
end

function QuestManager.getQuestName(questID)
	local pQuest = getQuestInfo(questID)

	if (pQuest == nil) then
		return ""
	end

	return LuaQuestInfo(pQuest):getQuestName()
end

function QuestManager.getJournalSummary(questID)
	local pQuest = getQuestInfo(questID)

	if (pQuest == nil) then
		return ""
	end

	return LuaQuestInfo(pQuest):getJournalSummary()
end

function QuestManager.getCurrentQuestID(pPlayer)
	local id = tonumber(readScreenPlayData(pPlayer, "VillageJediProgression", "CurrentQuestID"))

	if (id == nil) then
		id = -1
	end

	return id
end

function QuestManager.setCurrentQuestID(pPlayer, qid)
	return writeScreenPlayData(pPlayer, "VillageJediProgression", "CurrentQuestID", qid)
end

function QuestManager.getStoredVillageValue(pPlayer, key)
	return readScreenPlayData(pPlayer, "VillageJediProgression", key)
end

function QuestManager.setStoredVillageValue(pPlayer, key, value)
	return writeScreenPlayData(pPlayer, "VillageJediProgression", key, value)
end

QuestManager.quests = {}

QuestManager.quests.TEST_SIMPLE 						= 0
QuestManager.quests.TEST_GOTO_01 						= 1
QuestManager.quests.TEST_GOTO_02 						= 2
QuestManager.quests.TEST_GOTO_03 						= 3
QuestManager.quests.TEST_FIND_01 						= 4
QuestManager.quests.TEST_ENCOUNTER_01 					= 5
QuestManager.quests.TEST_DESTROY_01 					= 6
QuestManager.quests.TEST_ESCORT_01 						= 7
QuestManager.quests.TEST_ESCORT_LOCATION 				= 8
QuestManager.quests.TEST_RANDOM 						= 9
QuestManager.quests.TEST_GIVE 							= 10
QuestManager.quests.SCT1 								= 11
QuestManager.quests.SCT2 								= 12
QuestManager.quests.SCT3 								= 13
QuestManager.quests.SCT4 								= 14
QuestManager.quests.FS_QUESTS_SAD_TASKS 				= 15
QuestManager.quests.FS_QUESTS_SAD_TASK1 				= 16
QuestManager.quests.FS_QUESTS_SAD_RETURN1 				= 17
QuestManager.quests.FS_QUESTS_SAD_TASK2 				= 18
QuestManager.quests.FS_QUESTS_SAD_RETURN2 				= 19
QuestManager.quests.FS_QUESTS_SAD_TASK3 				= 20
QuestManager.quests.FS_QUESTS_SAD_RETURN3 				= 21
QuestManager.quests.FS_QUESTS_SAD_TASK4 				= 22
QuestManager.quests.FS_QUESTS_SAD_RETURN4 				= 23
QuestManager.quests.FS_QUESTS_SAD_TASK5 				= 24
QuestManager.quests.FS_QUESTS_SAD_RETURN5 				= 25
QuestManager.quests.FS_QUESTS_SAD_TASK6 				= 26
QuestManager.quests.FS_QUESTS_SAD_RETURN6 				= 27
QuestManager.quests.FS_QUESTS_SAD_TASK7 				= 28
QuestManager.quests.FS_QUESTS_SAD_RETURN7 				= 29
QuestManager.quests.FS_QUESTS_SAD_TASK8 				= 30
QuestManager.quests.FS_QUESTS_SAD_RETURN8 				= 31
QuestManager.quests.FS_QUESTS_SAD_FINISH 				= 32
QuestManager.quests.FS_QUESTS_SAD2_TASKS 				= 33
QuestManager.quests.FS_QUESTS_SAD2_TASK1				= 34
QuestManager.quests.FS_QUESTS_SAD2_RETURN1 				= 35
QuestManager.quests.FS_QUESTS_SAD2_TASK2 				= 36
QuestManager.quests.FS_QUESTS_SAD2_RETURN2 				= 37
QuestManager.quests.FS_QUESTS_SAD2_TASK3 				= 38
QuestManager.quests.FS_QUESTS_SAD2_RETURN3 				= 39
QuestManager.quests.FS_QUESTS_SAD2_TASK4 				= 40
QuestManager.quests.FS_QUESTS_SAD2_RETURN4 				= 41
QuestManager.quests.FS_QUESTS_SAD2_TASK5 				= 42
QuestManager.quests.FS_QUESTS_SAD2_RETURN5 				= 43
QuestManager.quests.FS_QUESTS_SAD2_TASK6 				= 44
QuestManager.quests.FS_QUESTS_SAD2_RETURN6 				= 45
QuestManager.quests.FS_QUESTS_SAD2_TASK7 				= 46
QuestManager.quests.FS_QUESTS_SAD2_RETURN7 				= 47
QuestManager.quests.FS_QUESTS_SAD2_TASK8 				= 48
QuestManager.quests.FS_QUESTS_SAD2_RETURN8 				= 49
QuestManager.quests.FS_QUESTS_SAD2_FINISH 				= 50
QuestManager.quests.FS_MEDIC_PUZZLE_QUEST_01 			= 51
QuestManager.quests.FS_MEDIC_PUZZLE_QUEST_02 			= 52
QuestManager.quests.FS_MEDIC_PUZZLE_QUEST_03 			= 53
QuestManager.quests.FS_PHASE_2_CRAFT_DEFENSES_02 		= 54
QuestManager.quests.FS_PHASE_3_CRAFT_SHIELDS_02 		= 55
QuestManager.quests.FS_REFLEX_RESCUE_QUEST_00 			= 56
QuestManager.quests.FS_REFLEX_RESCUE_QUEST_01 			= 57
QuestManager.quests.FS_REFLEX_RESCUE_QUEST_02 			= 58
QuestManager.quests.FS_REFLEX_RESCUE_QUEST_03 			= 59
QuestManager.quests.FS_REFLEX_RESCUE_QUEST_04 			= 60
QuestManager.quests.FS_REFLEX_RESCUE_QUEST_05 			= 61
QuestManager.quests.FS_REFLEX_RESCUE_QUEST_06 			= 62
QuestManager.quests.FS_REFLEX_FETCH_QUEST_00 			= 63
QuestManager.quests.FS_REFLEX_FETCH_QUEST_01 			= 64
QuestManager.quests.FS_REFLEX_FETCH_QUEST_02 			= 65
QuestManager.quests.FS_REFLEX_FETCH_QUEST_03 			= 66
QuestManager.quests.FS_REFLEX_FETCH_QUEST_04 			= 67
QuestManager.quests.FS_REFLEX_FETCH_QUEST_05 			= 68
QuestManager.quests.FS_REFLEX_FETCH_QUEST_06 			= 69
QuestManager.quests.FS_CRAFT_PUZZLE_QUEST_00 			= 70
QuestManager.quests.FS_CRAFT_PUZZLE_QUEST_01 			= 71
QuestManager.quests.FS_CRAFT_PUZZLE_QUEST_02 			= 72
QuestManager.quests.FS_CRAFT_PUZZLE_QUEST_03 			= 73
QuestManager.quests.OLD_MAN_INITIAL 					= 74
QuestManager.quests.FS_THEATER_CAMP 					= 75
QuestManager.quests.DO_NOT_USE_BAD_SLOT 				= 76
QuestManager.quests.FS_GOTO_DATH 						= 77
QuestManager.quests.FS_VILLAGE_ELDER 					= 78
QuestManager.quests.OLD_MAN_FORCE_CRYSTAL 				= 79
QuestManager.quests.FS_DATH_WOMAN 						= 80
QuestManager.quests.FS_PATROL_QUEST_1 					= 81
QuestManager.quests.FS_PATROL_QUEST_2 					= 82
QuestManager.quests.FS_PATROL_QUEST_3 					= 83
QuestManager.quests.FS_PATROL_QUEST_4 					= 84
QuestManager.quests.FS_PATROL_QUEST_5 					= 85
QuestManager.quests.FS_PATROL_QUEST_6 					= 86
QuestManager.quests.FS_PATROL_QUEST_7 					= 87
QuestManager.quests.FS_PATROL_QUEST_8 					= 88
QuestManager.quests.FS_PATROL_QUEST_9 					= 89
QuestManager.quests.FS_PATROL_QUEST_10 					= 90
QuestManager.quests.FS_PATROL_QUEST_11 					= 91
QuestManager.quests.FS_PATROL_QUEST_12 					= 92
QuestManager.quests.FS_PATROL_QUEST_13 					= 93
QuestManager.quests.FS_PATROL_QUEST_14 					= 94
QuestManager.quests.FS_PATROL_QUEST_15 					= 95
QuestManager.quests.FS_PATROL_QUEST_16 					= 96
QuestManager.quests.FS_PATROL_QUEST_17 					= 97
QuestManager.quests.FS_PATROL_QUEST_18 					= 98
QuestManager.quests.FS_PATROL_QUEST_19 					= 99
QuestManager.quests.FS_PATROL_QUEST_20 					= 100
QuestManager.quests.FS_COMBAT_HEALING_1 				= 101
QuestManager.quests.FS_COMBAT_HEALING_2 				= 102
QuestManager.quests.FS_DEFEND_SET_FACTION 				= 103
QuestManager.quests.FS_DEFEND_01 						= 104
QuestManager.quests.FS_DEFEND_02 						= 105
QuestManager.quests.FS_DEFEND_REwARD_01 				= 106
QuestManager.quests.FS_DEFEND_03 						= 107
QuestManager.quests.FS_DEFEND_04 						= 108
QuestManager.quests.FS_CS_INTRO 						= 109
QuestManager.quests.FS_CS_KILL5_GUARDS 					= 110
QuestManager.quests.FS_CS_ENSURE_CAPTURE 				= 111
QuestManager.quests.FS_CS_LAST_CHANCE 					= 112
QuestManager.quests.FS_CS_ESCORT_COMMANDER_PRI 			= 113
QuestManager.quests.FS_CS_ESCORT_COMMANDER_SEC 			= 114
QuestManager.quests.FS_CS_QUEST_DONE 					= 115
QuestManager.quests.FS_THEATER_FINAL 					= 116
QuestManager.quests.OLD_MAN_FINAL 						= 117
QuestManager.quests.FS_CRAFTING4_QUEST_00 				= 118
QuestManager.quests.FS_CRAFTING4_QUEST_01 				= 119
QuestManager.quests.FS_CRAFTING4_QUEST_02 				= 120
QuestManager.quests.FS_CRAFTING4_QUEST_03 				= 121
QuestManager.quests.FS_CRAFTING4_QUEST_04 				= 122
QuestManager.quests.FS_CRAFTING4_QUEST_05 				= 123
QuestManager.quests.FS_CRAFTING4_QUEST_06 				= 124
QuestManager.quests.FS_CRAFTING4_QUEST_07 				= 125
QuestManager.quests.TWO_MILITARY 						= 126
QuestManager.quests.FS_DEFEND_REwARD_02 				= 127
QuestManager.quests.FS_DEFEND_REwARD_03 				= 128
QuestManager.quests.SURVEY_PHASE2_MAIN 					= 129
QuestManager.quests.SURVEY_PHASE2_01 					= 130
QuestManager.quests.SURVEY_PHASE2_02 					= 131
QuestManager.quests.SURVEY_PHASE2_03 					= 132
QuestManager.quests.SURVEY_PHASE2_04 					= 133
QuestManager.quests.SURVEY_PHASE2_05 					= 134
QuestManager.quests.SURVEY_PHASE2_06 					= 135
QuestManager.quests.SURVEY_PHASE2_07 					= 136
QuestManager.quests.SURVEY_PHASE2_08 					= 137
QuestManager.quests.SURVEY_PHASE3_MAIN 					= 138
QuestManager.quests.SURVEY_PHASE3_01 					= 139
QuestManager.quests.SURVEY_PHASE3_02 					= 140
QuestManager.quests.SURVEY_PHASE3_03 					= 141
QuestManager.quests.SURVEY_PHASE3_04 					= 142
QuestManager.quests.SURVEY_PHASE3_05 					= 143
QuestManager.quests.SURVEY_PHASE3_06 					= 144
QuestManager.quests.SURVEY_PHASE3_07 					= 145
QuestManager.quests.SURVEY_PHASE3_08 					= 146
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_01 		= 147
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_02 		= 148
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_03 		= 149
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_04 		= 150
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_05 		= 151
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_06 		= 152
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_07 		= 153
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_08 		= 154
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_09 		= 155
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_10 		= 156
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_11 		= 157
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_12 		= 158
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_13 		= 159
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_14 		= 160
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_15 		= 161
QuestManager.quests.FS_SURVEY_SPECIAL_RESOURCE_16 		= 162
QuestManager.quests.FS_DATH_wOMAN_TALK 					= 163
QuestManager.quests.FS_PATROL_QUEST_START 				= 164
QuestManager.quests.FS_REFLEX_RESCUE_QUEST_07 			= 165
QuestManager.quests.FS_SURVEY_PHASE2_REwARD 			= 166
QuestManager.quests.FS_SURVEY_PHASE3_REwARD 			= 167
QuestManager.quests.FS_DEFEND_SET_FACTION_02 			= 168
QuestManager.quests.LOOT_DATAPAD_1 						= 169
QuestManager.quests.GOT_DATAPAD 						= 170
QuestManager.quests.FS_PHASE_2_CRAFT_DEFENSES_01 		= 171
QuestManager.quests.FS_PHASE_3_CRAFT_SHIELDS_01 		= 172
QuestManager.quests.FS_PHASE_2_CRAFT_DEFENSES_MAIN 		= 173
QuestManager.quests.FS_PHASE_3_CRAFT_SHIELDS_MAIN 		= 174
QuestManager.quests.LOOT_DATAPAD_2 						= 175
QuestManager.quests.GOT_DATAPAD_2 						= 176
QuestManager.quests.FS_CS_QUEST_FAILED_ESCORT 			= 177
QuestManager.quests.FS_PATROL_QUEST_FINISH 				= 178
QuestManager.quests.FS_MEDIC_PUZZLE_QUEST_FINISH 		= 179
QuestManager.quests.FS_COMBAT_HEALING_FINISH 			= 180
QuestManager.quests.FS_COMBAT_REWARD_PHASE2 			= 181
QuestManager.quests.FS_REFLEX_REWARD_PHASE3 			= 182
QuestManager.quests.FS_DEFEND_WAIT_01 					= 183
QuestManager.quests.FS_DEFEND_WAIT_02 					= 184
QuestManager.quests.FS_CRAFTING4_QUEST_FINISH 			= 185
QuestManager.quests.FS_CRAFT_PUZZLE_QUEST_04 			= 186
QuestManager.quests.FS_CS_QUEST_DONE_NOTIFYONLY 		= 187
QuestManager.quests.WOD_PROLOGUE_WALKABOUT				= 188
QuestManager.quests.WOD_PROLOGUE_WALKABOUT_01			= 189
QuestManager.quests.WOD_PROLOGUE_WALKABOUT_02			= 190
QuestManager.quests.WOD_PROLOGUE_WALKABOUT_03			= 191
QuestManager.quests.WOD_PROLOGUE_WALKABOUT_04			= 192
QuestManager.quests.WOD_PROLOGUE_WALKABOUT_05			= 193
QuestManager.quests.WOD_PROLOGUE_WALKABOUT_06			= 194
QuestManager.quests.WOD_PROLOGUE_WALKABOUT_07			= 195
QuestManager.quests.WOD_PROLOGUE_WALKABOUT_08			= 196
QuestManager.quests.WOD_PROLOGUE_WALKABOUT_09			= 197
QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING			= 198
QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_01		= 199
QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_02		= 200
QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_03		= 201
QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_04		= 202
QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_05		= 203
QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_06		= 204
QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_07		= 205
QuestManager.quests.WOD_PROLOGUE_HERB_GATHERING_08		= 206
QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR			= 207
QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_01			= 208
QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_02			= 209
QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_03			= 210
QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_04			= 211
QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_05			= 212
QuestManager.quests.WOD_PROLOGUE_KILL_RANCOR_06			= 213
QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN		= 214
QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_01	= 215
QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_02	= 216
QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_03	= 217
QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_04	= 218
QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_05	= 219
QuestManager.quests.WOD_PROLOGUE_KILL_SPIDER_CLAN_05	= 220
QuestManager.quests.WOD_PROLOGUE_OUTCAST_1 				= 221
QuestManager.quests.WOD_PROLOGUE_OUTCAST_1_01			= 222
QuestManager.quests.WOD_PROLOGUE_OUTCAST_1_02			= 223
QuestManager.quests.WOD_PROLOGUE_OUTCAST_1_03			= 224
QuestManager.quests.WOD_PROLOGUE_OUTCAST_2 				= 225
QuestManager.quests.WOD_PROLOGUE_OUTCAST_2_01			= 226
QuestManager.quests.WOD_PROLOGUE_OUTCAST_2_02			= 227
QuestManager.quests.WOD_PROLOGUE_OUTCAST_2_03			= 228
QuestManager.quests.WOD_PROLOGUE_OUTCAST_3 				= 229
QuestManager.quests.WOD_PROLOGUE_OUTCAST_3_01			= 230
QuestManager.quests.WOD_PROLOGUE_OUTCAST_3_02			= 231
QuestManager.quests.WOD_PROLOGUE_OUTCAST_3_03			= 232
QuestManager.quests.WOD_PROLOGUE_OUTCAST_4 				= 233
QuestManager.quests.WOD_PROLOGUE_OUTCAST_4_01			= 234
QuestManager.quests.WOD_PROLOGUE_OUTCAST_4_02			= 235
QuestManager.quests.WOD_PROLOGUE_OUTCAST_4_03			= 236
QuestManager.quests.WOD_PROLOGUE_OUTCAST_5 				= 237
QuestManager.quests.WOD_PROLOGUE_OUTCAST_5_01			= 238
QuestManager.quests.WOD_PROLOGUE_OUTCAST_5_02			= 239
QuestManager.quests.WOD_PROLOGUE_OUTCAST_5_03			= 240
QuestManager.quests.WOD_PROLOGUE_OUTCAST_6 				= 241
QuestManager.quests.WOD_PROLOGUE_OUTCAST_6_01			= 242
QuestManager.quests.WOD_PROLOGUE_OUTCAST_6_02			= 243
QuestManager.quests.WOD_PROLOGUE_OUTCAST_6_03			= 244
QuestManager.quests.WOD_PROLOGUE_OUTCAST_7			 	= 245
QuestManager.quests.WOD_PROLOGUE_OUTCAST_7_01			= 246
QuestManager.quests.WOD_PROLOGUE_OUTCAST_7_02			= 247
QuestManager.quests.WOD_PROLOGUE_OUTCAST_7_03			= 248
QuestManager.quests.WOD_RUBINA_GOTO_NS					= 249
QuestManager.quests.WOD_NS_REPAIR_ALTAR_01				= 250
QuestManager.quests.WOD_NS_REPAIR_ALTAR_01_01			= 251
QuestManager.quests.WOD_NS_REPAIR_ALTAR_01_02			= 252
QuestManager.quests.WOD_NS_REPAIR_ALTAR_01_03			= 253
QuestManager.quests.WOD_NS_REPAIR_ALTAR_01_04			= 254
QuestManager.quests.WOD_NS_REPAIR_ALTAR_02				= 255
QuestManager.quests.WOD_NS_REPAIR_ALTAR_02_01			= 256
QuestManager.quests.WOD_NS_REPAIR_ALTAR_02_02			= 257
QuestManager.quests.WOD_NS_REPAIR_ALTAR_02_03			= 258
QuestManager.quests.WOD_NS_REPAIR_ALTAR_02_04			= 259
QuestManager.quests.WOD_NS_REPAIR_ALTAR_03				= 260
QuestManager.quests.WOD_NS_REPAIR_ALTAR_03_01			= 261
QuestManager.quests.WOD_NS_REPAIR_ALTAR_03_02			= 262
QuestManager.quests.WOD_NS_REPAIR_ALTAR_03_03			= 263
QuestManager.quests.WOD_NS_REPAIR_ALTAR_03_04			= 264
QuestManager.quests.WOD_NS_REPAIR_ALTAR_04				= 265
QuestManager.quests.WOD_NS_REPAIR_ALTAR_04_01			= 266
QuestManager.quests.WOD_NS_REPAIR_ALTAR_04_02			= 267
QuestManager.quests.WOD_NS_REPAIR_ALTAR_04_03			= 268
QuestManager.quests.WOD_NS_REPAIR_ALTAR_04_04			= 269
QuestManager.quests.WOD_NS_LOST_E01						= 270
QuestManager.quests.WOD_NS_LOST_E01_01					= 271
QuestManager.quests.WOD_NS_LOST_E01_02					= 272
QuestManager.quests.WOD_NS_LOST_E01_03					= 273
QuestManager.quests.WOD_NS_LOST_E01_04					= 274
QuestManager.quests.WOD_NS_LOST_E01_05					= 275
QuestManager.quests.WOD_NS_LOST_E02						= 276
QuestManager.quests.WOD_NS_LOST_E02_01					= 277
QuestManager.quests.WOD_NS_LOST_E02_02					= 278
QuestManager.quests.WOD_NS_LOST_E02_03					= 279
QuestManager.quests.WOD_NS_LOST_E02_04					= 280
QuestManager.quests.WOD_NS_EHS							= 281
QuestManager.quests.WOD_NS_EHS_01						= 282
QuestManager.quests.WOD_NS_EHS_02						= 283
QuestManager.quests.WOD_NS_EHS_03						= 284
QuestManager.quests.WOD_NS_EHS_04						= 285
QuestManager.quests.WOD_NS_QUEEN_MOTHER_FIGHT			= 286
QuestManager.quests.WOD_NS_QUEEN_MOTHER_FIGHT_01		= 287
QuestManager.quests.WOD_NS_QUEEN_MOTHER_FIGHT_02		= 288
QuestManager.quests.WOD_NS_QUEEN_MOTHER_FIGHT_03		= 289
QuestManager.quests.WOD_NS_HUNTING						= 290
QuestManager.quests.WOD_NS_HUNTING_01					= 291
QuestManager.quests.WOD_NS_HUNTING_02					= 292
QuestManager.quests.WOD_NS_FISHING						= 293
QuestManager.quests.WOD_NS_FISHING_01					= 294
QuestManager.quests.WOD_NS_FISHING_02					= 295
QuestManager.quests.WOD_NS_HERB_GATHERING				= 296
QuestManager.quests.WOD_NS_HERB_GATHERING_01 			= 297
QuestManager.quests.WOD_NS_HERB_GATHERING_02			= 298
QuestManager.quests.WOD_NS_HERB_GATHERING_03 			= 299
QuestManager.quests.WOD_NS_HERB_GATHERING_04 			= 300
QuestManager.quests.WOD_NS_HERB_GATHERING_05 			= 301
QuestManager.quests.WOD_NS_HERB_GATHERING_06 			= 302
QuestManager.quests.WOD_NS_HERB_GATHERING_07 			= 303
QuestManager.quests.WOD_NS_HERB_GATHERING_08			= 304
QuestManager.quests.WOD_NS_WHOLE_TRUTH					= 305
QuestManager.quests.WOD_NS_WHOLE_TRUTH_01				= 306
QuestManager.quests.WOD_NS_WHOLE_TRUTH_02				= 307
QuestManager.quests.WOD_NS_WHOLE_TRUTH_03				= 308
QuestManager.quests.WOD_NS_WHOLE_TRUTH_04				= 309
QuestManager.quests.WOD_NS_WHOLE_TRUTH_05				= 310
QuestManager.quests.WOD_NS_WHOLE_TRUTH_06				= 311
QuestManager.quests.WOD_NS_KYRISA_BOSS_FIGHT 			= 312
QuestManager.quests.WOD_NS_KYRISA_BOSS_FIGHT_01			= 313
QuestManager.quests.WOD_NS_KYRISA_BOSS_FIGHT_02			= 314
QuestManager.quests.WOD_NS_KYRISA_BOSS_FIGHT_03			= 315
QuestManager.quests.WOD_NS_RANCOR_TAMER					= 316
QuestManager.quests.WOD_NS_RANCOR_TAMER_01 				= 317
QuestManager.quests.WOD_NS_RANCOR_TAMER_02 				= 318
QuestManager.quests.WOD_NS_RANCOR_TAMER_03 				= 319
QuestManager.quests.WOD_NS_RANCOR_TAMER_04				= 320
QuestManager.quests.WOD_NS_KILL_CLAN					= 321
QuestManager.quests.WOD_NS_KILL_CLAN_01					= 322
QuestManager.quests.WOD_NS_KILL_CLAN_02					= 323
QuestManager.quests.WOD_NS_KILL_SPIDERCLAN				= 324
QuestManager.quests.WOD_NS_KILL_SPIDERCLAN_01			= 325
QuestManager.quests.WOD_NS_KILL_SPIDERCLAN_02			= 326
QuestManager.quests.WOD_NS_RECON						= 327
QuestManager.quests.WOD_NS_RECON_01 					= 328
QuestManager.quests.WOD_NS_RECON_02						= 329
QuestManager.quests.WOD_NS_SISTER1						= 330
QuestManager.quests.WOD_NS_SISTER1_01 					= 331
QuestManager.quests.WOD_NS_SISTER1_02					= 332
QuestManager.quests.WOD_NS_SISTER1_03 					= 333
QuestManager.quests.WOD_NS_SISTER1_04 					= 334
QuestManager.quests.WOD_NS_SISTER1_05					= 335
QuestManager.quests.WOD_NS_SISTER2						= 336
QuestManager.quests.WOD_NS_SISTER2_01 					= 337
QuestManager.quests.WOD_NS_SISTER2_02					= 338
QuestManager.quests.WOD_NS_SISTER2_03 					= 339
QuestManager.quests.WOD_NS_SISTER2_04 					= 340
QuestManager.quests.WOD_NS_SISTER2_05 					= 341
QuestManager.quests.WOD_NS_SISTER2_06 					= 342
QuestManager.quests.WOD_NS_SISTER2_07 					= 343
QuestManager.quests.WOD_NS_SISTER2_08					= 344
QuestManager.quests.WOD_NS_SISTER3						= 345
QuestManager.quests.WOD_NS_SISTER3_01 					= 346
QuestManager.quests.WOD_NS_SISTER3_02					= 347
QuestManager.quests.WOD_NS_SISTER3_03 					= 348
QuestManager.quests.WOD_NS_GHOST_REWARD					= 349
QuestManager.quests.WOD_RUBINA_GOTO_SM					= 350
QuestManager.quests.WOD_SM_REPAIR_ALTAR_01				= 351
QuestManager.quests.WOD_SM_REPAIR_ALTAR_01_01			= 352
QuestManager.quests.WOD_SM_REPAIR_ALTAR_01_02			= 353
QuestManager.quests.WOD_SM_REPAIR_ALTAR_01_03			= 354
QuestManager.quests.WOD_SM_REPAIR_ALTAR_01_04			= 355
QuestManager.quests.WOD_SM_REPAIR_ALTAR_02				= 356
QuestManager.quests.WOD_SM_REPAIR_ALTAR_02_01			= 357
QuestManager.quests.WOD_SM_REPAIR_ALTAR_02_02			= 358
QuestManager.quests.WOD_SM_REPAIR_ALTAR_02_03			= 359
QuestManager.quests.WOD_SM_REPAIR_ALTAR_02_04			= 360
QuestManager.quests.WOD_SM_REPAIR_ALTAR_03				= 361
QuestManager.quests.WOD_SM_REPAIR_ALTAR_03_01			= 362
QuestManager.quests.WOD_SM_REPAIR_ALTAR_03_02			= 363
QuestManager.quests.WOD_SM_REPAIR_ALTAR_03_03			= 364
QuestManager.quests.WOD_SM_REPAIR_ALTAR_03_04			= 365
QuestManager.quests.WOD_SM_REPAIR_ALTAR_04				= 366
QuestManager.quests.WOD_SM_REPAIR_ALTAR_04_01			= 367
QuestManager.quests.WOD_SM_REPAIR_ALTAR_04_02			= 368
QuestManager.quests.WOD_SM_REPAIR_ALTAR_04_03			= 369
QuestManager.quests.WOD_SM_REPAIR_ALTAR_04_04			= 370
QuestManager.quests.WOD_SM_LOST_E01						= 371
QuestManager.quests.WOD_SM_LOST_E01_01					= 372
QuestManager.quests.WOD_SM_LOST_E01_02					= 373
QuestManager.quests.WOD_SM_LOST_E01_03					= 374
QuestManager.quests.WOD_SM_LOST_E01_04					= 375
QuestManager.quests.WOD_SM_LOST_E01_05					= 376
QuestManager.quests.WOD_SM_LOST_E02						= 377
QuestManager.quests.WOD_SM_LOST_E02_01					= 378
QuestManager.quests.WOD_SM_LOST_E02_02					= 379
QuestManager.quests.WOD_SM_LOST_E02_03					= 380
QuestManager.quests.WOD_SM_LOST_E02_04					= 381
QuestManager.quests.WOD_SM_EHS							= 382
QuestManager.quests.WOD_SM_EHS_01						= 383
QuestManager.quests.WOD_SM_EHS_02						= 384
QuestManager.quests.WOD_SM_EHS_03						= 385
QuestManager.quests.WOD_SM_EHS_04						= 386
QuestManager.quests.WOD_SM_QUEEN_MOTHER_FIGHT			= 387
QuestManager.quests.WOD_SM_QUEEN_MOTHER_FIGHT_01		= 388
QuestManager.quests.WOD_SM_QUEEN_MOTHER_FIGHT_02		= 389
QuestManager.quests.WOD_SM_QUEEN_MOTHER_FIGHT_03		= 390
QuestManager.quests.WOD_SM_HUNTING						= 391
QuestManager.quests.WOD_SM_HUNTING_01					= 392
QuestManager.quests.WOD_SM_HUNTING_02					= 393
QuestManager.quests.WOD_SM_FISHING						= 394
QuestManager.quests.WOD_SM_FISHING_01					= 395
QuestManager.quests.WOD_SM_FISHING_02					= 396
QuestManager.quests.WOD_SM_HERB_GATHERING				= 397
QuestManager.quests.WOD_SM_HERB_GATHERING_01 			= 398
QuestManager.quests.WOD_SM_HERB_GATHERING_02			= 399
QuestManager.quests.WOD_SM_HERB_GATHERING_03 			= 400
QuestManager.quests.WOD_SM_HERB_GATHERING_04 			= 401
QuestManager.quests.WOD_SM_HERB_GATHERING_05 			= 402
QuestManager.quests.WOD_SM_HERB_GATHERING_06 			= 403
QuestManager.quests.WOD_SM_HERB_GATHERING_07 			= 404
QuestManager.quests.WOD_SM_HERB_GATHERING_08			= 405
QuestManager.quests.WOD_SM_WHOLE_TRUTH					= 406
QuestManager.quests.WOD_SM_WHOLE_TRUTH_01				= 407
QuestManager.quests.WOD_SM_WHOLE_TRUTH_02				= 408
QuestManager.quests.WOD_SM_WHOLE_TRUTH_03				= 409
QuestManager.quests.WOD_SM_WHOLE_TRUTH_04				= 410
QuestManager.quests.WOD_SM_WHOLE_TRUTH_05				= 411
QuestManager.quests.WOD_SM_WHOLE_TRUTH_06				= 412
QuestManager.quests.WOD_SM_KYRISA_BOSS_FIGHT 			= 413
QuestManager.quests.WOD_SM_KYRISA_BOSS_FIGHT_01			= 414
QuestManager.quests.WOD_SM_KYRISA_BOSS_FIGHT_02			= 415
QuestManager.quests.WOD_SM_KYRISA_BOSS_FIGHT_03			= 416
QuestManager.quests.WOD_SM_RANCOR_TAMER					= 417
QuestManager.quests.WOD_SM_RANCOR_TAMER_01 				= 418
QuestManager.quests.WOD_SM_RANCOR_TAMER_02 				= 419
QuestManager.quests.WOD_SM_RANCOR_TAMER_03 				= 420
QuestManager.quests.WOD_SM_RANCOR_TAMER_04				= 421
QuestManager.quests.WOD_SM_KILL_CLAN					= 422
QuestManager.quests.WOD_SM_KILL_CLAN_01					= 423
QuestManager.quests.WOD_SM_KILL_CLAN_02					= 424
QuestManager.quests.WOD_SM_KILL_SPIDERCLAN				= 425
QuestManager.quests.WOD_SM_KILL_SPIDERCLAN_01			= 426
QuestManager.quests.WOD_SM_KILL_SPIDERCLAN_02			= 427
QuestManager.quests.WOD_SM_RECON						= 428
QuestManager.quests.WOD_SM_RECON_01 					= 429
QuestManager.quests.WOD_SM_RECON_02						= 430
QuestManager.quests.WOD_SM_SISTER1						= 431
QuestManager.quests.WOD_SM_SISTER1_01 					= 432
QuestManager.quests.WOD_SM_SISTER1_02					= 433
QuestManager.quests.WOD_SM_SISTER1_03 					= 434
QuestManager.quests.WOD_SM_SISTER1_04 					= 435
QuestManager.quests.WOD_SM_SISTER1_05					= 436
QuestManager.quests.WOD_SM_SISTER2						= 437
QuestManager.quests.WOD_SM_SISTER2_01 					= 438
QuestManager.quests.WOD_SM_SISTER2_02					= 439
QuestManager.quests.WOD_SM_SISTER2_03 					= 440
QuestManager.quests.WOD_SM_SISTER2_04 					= 441
QuestManager.quests.WOD_SM_SISTER2_05 					= 442
QuestManager.quests.WOD_SM_SISTER2_06 					= 443
QuestManager.quests.WOD_SM_SISTER2_07 					= 444
QuestManager.quests.WOD_SM_SISTER2_08					= 445
QuestManager.quests.WOD_SM_SISTER3						= 446
QuestManager.quests.WOD_SM_SISTER3_01 					= 447
QuestManager.quests.WOD_SM_SISTER3_02					= 448
QuestManager.quests.WOD_SM_SISTER3_03 					= 449
QuestManager.quests.WOD_SM_GHOST_REWARD					= 450
QuestManager.quests.WOD_RUBINA_CHEST					= 451
QuestManager.quests.WOD_LEFT_BEHIND						= 452
QuestManager.quests.WOD_LEFT_BEHIND_01					= 453
QuestManager.quests.WOD_LEFT_BEHIND_02					= 454
QuestManager.quests.WOD_LEFT_BEHIND_03					= 455

return QuestManager
