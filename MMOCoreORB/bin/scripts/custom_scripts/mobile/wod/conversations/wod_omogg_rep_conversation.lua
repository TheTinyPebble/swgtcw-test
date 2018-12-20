wodOmoggsRepConvoTemplate = ConvoTemplate:new {
	initialScreen = "",
	templateType = "Lua",
	luaClassHandler = "wodOmoggsRepConvoHandler",
	screens = {}
}

wodOmoggsRepConvoTemplate_intro_quest_complete = ConvoScreen:new {
	id = "intro_quest_complete",
	leftDialog = "@conversation/wod_omogg_rep:s_4", -- Thank you for your work. I don't have anything else for you to do, I need to get back to Coronet and get these holograms edited.
	stopConversation = "true",
	options = {
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_intro_quest_complete);

wodOmoggsRepConvoTemplate_intro_in_progress = ConvoScreen:new {
	id = "intro_in_progress",
	leftDialog = "@conversation/wod_omogg_rep:s_17", -- You still have work to do. Return here when you got the pictures.
	stopConversation = "true",
	options = {
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_intro_in_progress);

-- Initial intro

wodOmoggsRepConvoTemplate_intro = ConvoScreen:new {
	id = "intro",
	leftDialog = "@conversation/wod_omogg_rep:s_19", -- Hey you! Are you interested in making some easy credits? 
	stopConversation = "false",
	options = {
		{"@conversation/wod_omogg_rep:s_21", "intro_01"}, -- Easy credits? Excuse me if I'm a little skeptical.
		{"@conversation/wod_omogg_rep:s_48", "intro_decline"}, -- Not right now, maybe later.
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_intro);

wodOmoggsRepConvoTemplate_intro_01 = ConvoScreen:new {
	id = "intro_01",
	leftDialog = "@conversation/wod_omogg_rep:s_26", -- All I need is for you to take a quick trip out to a couple of scenic spots not too far away. I'm collecting pictures, sales material actually, for the planet. I need pictures that will make Dathomir look like a beautiful and peaceful planet.
	stopConversation = "false",
	options = {
		{"@conversation/wod_omogg_rep:s_28", "intro_02"}, -- Dathomir? Beautiful? Peaceful?
		{"@conversation/wod_omogg_rep:s_48", "intro_decline"}, -- Not right now, maybe later.
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_intro_01);

wodOmoggsRepConvoTemplate_intro_02 = ConvoScreen:new {
	id = "intro_02",
	leftDialog = "@conversation/wod_omogg_rep:s_30", -- It's just a little harmless marketing.
	stopConversation = "false",
	options = {
		{"@conversation/wod_omogg_rep:s_32", "start_first_phase"}, -- Why not? I'll take the job.
		{"@conversation/wod_omogg_rep:s_48", "intro_decline"}, -- Not right now, maybe later.
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_intro_02);

wodOmoggsRepConvoTemplate_start_first_phase = ConvoScreen:new {
	id = "start_first_phase",
	leftDialog = "@conversation/wod_omogg_rep:s_34", -- Perfect. Your first stop will be some local waterfalls.
	stopConversation = "true",
	options = {
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_start_first_phase);

wodOmoggsRepConvoTemplate_intro_decline = ConvoScreen:new {
	id = "intro_decline",
	leftDialog = "@conversation/wod_omogg_rep:s_50", -- Perfect. Your first stop will be some local waterfalls.
	stopConversation = "true",
	options = {
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_intro_decline);

-- Complete first phase

wodOmoggsRepConvoTemplate_intro_complete_first_phase = ConvoScreen:new {
	id = "intro_complete_first_phase",
	leftDialog = "@conversation/wod_omogg_rep:s_6", -- You're back.
	stopConversation = "false",
	options = {
		{"@conversation/wod_omogg_rep:s_12", "first_phase_01"}, -- I got the Holograms.
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_intro_complete_first_phase);

wodOmoggsRepConvoTemplate_first_phase_01 = ConvoScreen:new {
	id = "first_phase_01",
	leftDialog = "@conversation/wod_omogg_rep:s_13", -- Great. I hope there'll be enough holograms without monsters, witches and other horrors to put together a good looking brochure. 
	stopConversation = "false",
	options = {
		{"@conversation/wod_omogg_rep:s_35", "complete_first_phase"}, -- Well, good luck.
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_first_phase_01);

wodOmoggsRepConvoTemplate_complete_first_phase = ConvoScreen:new {
	id = "complete_first_phase",
	leftDialog = "@conversation/wod_omogg_rep:s_36", -- Wait, I think I'll need some more pictures. Interested in a second trip?
	stopConversation = "true",
	options = {
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_complete_first_phase);

-- Start second phase

wodOmoggsRepConvoTemplate_intro_start_second_phase = ConvoScreen:new {
	id = "intro_start_second_phase",
	leftDialog = "@conversation/wod_omogg_rep:s_42", -- So are you ready for another little trip?
	stopConversation = "false",
	options = {
		{"@conversation/wod_omogg_rep:s_44", "start_second_phase"}, -- Yeah why not.
		{"@conversation/wod_omogg_rep:s_38", "second_phase_decline"}, -- I think I'll pass. Sounds like trouble.
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_intro_start_second_phase);

wodOmoggsRepConvoTemplate_start_second_phase = ConvoScreen:new {
	id = "start_second_phase",
	leftDialog = "@conversation/wod_omogg_rep:s_46", -- Great. Your first stop will be northwest of here.
	stopConversation = "true",
	options = {
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_start_second_phase);

wodOmoggsRepConvoTemplate_second_phase_decline = ConvoScreen:new {
	id = "second_phase_decline",
	leftDialog = "@conversation/wod_omogg_rep:s_40", -- That's a shame. For some reason it's hard to find wildlife photographers here on Dathomir. I wonder why?
	stopConversation = "true",
	options = {
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_second_phase_decline);

-- Complete quest

wodOmoggsRepConvoTemplate_intro_complete_second_phase = ConvoScreen:new {
	id = "intro_complete_second_phase",
	leftDialog = "@conversation/wod_omogg_rep:s_23", -- You're back.
	stopConversation = "false",
	options = {
		{"@conversation/wod_omogg_rep:s_24", "complete_second_phase"}, -- I got the Holograms.
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_intro_complete_second_phase);

wodOmoggsRepConvoTemplate_complete_second_phase = ConvoScreen:new {
	id = "complete_second_phase",
	leftDialog = "@conversation/wod_omogg_rep:s_25", -- Great. I hope there'll be enough holograms without monsters, witches and other horrors to put together a good looking brochure.
	stopConversation = "true",
	options = {
	}
}
wodOmoggsRepConvoTemplate:addScreen(wodOmoggsRepConvoTemplate_complete_second_phase);

addConversationTemplate("wodOmoggsRepConvoTemplate", wodOmoggsRepConvoTemplate);
