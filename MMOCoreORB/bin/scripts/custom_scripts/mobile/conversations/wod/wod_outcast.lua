function createWODOutcastConvoTemplate(templateName)
	wod_outcast = ConvoTemplate:new {
		initialScreen = "initial",
		templateType = "Lua",
		luaClassHandler = "wod_outcast_convo_handler",
		screens = {},
	}

	outcast = ConvoScreen:new {
		id = "outcast",
		leftDialog = "outcast", -- Storage for the outcast, so it can be pulled in the convo handler.
		stopConversation = "false",
		options = {
			{"outcast" , templateName}
		}
	}
	wod_outcast:addScreen(outcast);

	initial = ConvoScreen:new {
		id = "initial",
		leftDialog = "@conversation/" .. templateName .. ":s_10",
		stopConversation = "false",
		options = {
			{"@conversation/" .. templateName .. ":s_12", "dilemma_one"},
		}
	}
	wod_outcast:addScreen(initial)

	dilemma_one = ConvoScreen:new {
		id = "dilemma_one",
		leftDialog = "@conversation/" .. templateName .. ":s_14",
		stopConversation = "false",
		options = {
			{"conversation/" .. templateName .. ":s_18", "dilemma_two_sm"},
			{"conversation/" .. templateName .. ":s_17", "dilemma_two_ns"},
		}
	}
	wod_outcast:addScreen(dilemma_one)

	dilemma_two = ConvoScreen:new {
		id = "dilemma_two_sm",
		leftDialog = "@conversation/" .. templateName .. ":s_86",
		stopConversation = "false",
		options = {
			{"conversation/" .. templateName .. ":s_90", "dilemma_three_sm"},
			{"conversation/" .. templateName .. ":s_88", "dilemma_three_ns"},
		}
	}
	wod_outcast:addScreen(dilemma_two)

	dilemma_three = ConvoScreen:new {
		id = "dilemma_three_sm",
		leftDialog = "@conversation/" .. templateName .. ":s_95",
		stopConversation = "false",
		options = {
			{"conversation/" .. templateName .. ":s_97", "dilemma_four_sm"},
			{"conversation/" .. templateName .. ":s_99", "dilemma_four_ns"},
		}
	}
	wod_outcast:addScreen(dilemma_three)

	supported_clan = ConvoScreen:new {
		id = "supported_clan",
		customDialogText = "", --"conversation/" .. templateName .. ":s_104+110", --Handle in Convo handler
		stopConversation = "false",
		options = {
			{"conversation/" .. templateName .. ":s_112", "end_screen"}, -- Handle in convo handler
			{"conversation/" .. templateName .. ":s_106", "end_screen"},
		}
	}
	wod_outcast:addScreen(supported_clan)

	end_screen = ConvoScreen:new {
		id = "end_screen",
		customDialogText = "", --"conversation/" .. templateName .. ":s_108+114", --Handle in Convo handler
		stopConversation = "true",
		options = {
		}
	}
	wod_outcast:addScreen(end_screen)

	addConversationTemplate(templateName, wod_outcast);
end

createWODOutcastConvoTemplate("wod_outcast_01")
createWODOutcastConvoTemplate("wod_outcast_02")
createWODOutcastConvoTemplate("wod_outcast_03")
createWODOutcastConvoTemplate("wod_outcast_04")
createWODOutcastConvoTemplate("wod_outcast_05")
createWODOutcastConvoTemplate("wod_outcast_06")
createWODOutcastConvoTemplate("wod_outcast_07")
