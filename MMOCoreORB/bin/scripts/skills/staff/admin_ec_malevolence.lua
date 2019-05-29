admin_ec_malevolence = {
	skillName = "admin_ec_malevolence",
	parentName = "",
	graphType = 4,
	godOnly = 1,
	title = 0,
	profession = 0,
	hidden = 1,
	moneyRequired = 0,
	pointsRequired = 0,
	skillsRequiredCount = 0,
	skillsRequired = {},
	preclusionSkills = {},
	xpType = "",
	xpCost = 0,
	xpCap = 0,
	missionsRequired = {},
	apprenticeshipsRequired = 0,
	statsRequired = {},
	speciesRequired = {},
	jediStateRequired = 0,
	skillAbility = {},
	commands = {
		"aiIgnore", -- ?
		"dumpTargetInformation", 	-- Dumps debug information about the targeted object, and emails a copy of the information to the player using the command.
		"dumpZoneInformation",  	-- Dumps debug information about the current zone, and emails a copy of the information to the player using the command.
		"getObjVars", 				-- Debug command. Dumps a list of all object variables on the target object, and their specified values.
		"teleport",  				-- Teleport
		"teleportto", 				-- Teleport
		"invulnerable",			  	-- Invulnerable
		"kill",  					-- Kill Mob/NPC
		"setSpeed",  				-- Set Player Speed
		"goto",  					--  Go To a Waypoint in your Datapad
		"harmful",  				-- Enables the target to enter combat mode.
		"harmless",  				-- Disables the target from entering combat mode. Notice, they can still be attacked.
		"killPlayer",  				-- Kill a player
		"teleportTarget",  			-- Teleport
		"planetWarp", 				-- Warps to the specified planet.
		"planetWarpTarget", 		-- Warps Player to the specified planet.
		"freezePlayer",  			-- Freeze Player
		"unfreezePlayer", 			-- Unfreeze Player
		"gmRevive",  				-- Brings Dead Player Back to Life
		"setFaction", 				-- Sets the targeted object's faction to neutral, rebel, or imperial as specified
		"setTEF", 					-- TEF a Player
		"editAppearance",  			-- Edit a player's Appearance like imagedesiger.
		"grantBadge",  				-- Grant a Badge
		"revokeBadge",  			-- Remove a Badge
		"setPlayerAppearance",  	-- Set Player Appearance to a Mobile
		"broadcast",  				-- Broadcast Messaage
		"broadcastArea",  			-- Broadcast Messaage
		"broadcastGalaxy",  		-- Broadcast Messaage
		"broadcastPlanet",  		-- Broadcast Messaage
		"createCreature", 			-- Create an Creature
		"createNPC",  				-- Create an NPC
		"createSpawningElement",    -- Creates a spawning element based on a predefined script at the player's current location
        "setFirstName",             -- Set Player First Name
        "setLastName",              -- Set Player Last Name
        "object",                   -- Create Object
        "findObject",               -- Find Object
		"setName", 					-- Sets the name of the targeted object. This can be used on NPCs as well as Players, so they need to be careful.
		"gmEventTools",				-- Custom event tools
	},
	skillModifiers = {},
	schematicsGranted = {},
	schematicsRevoked = {},
	searchable = 0
}

addSkill(admin_ec_malevolence)
