admin_csr_malevolence = {
	skillName = "admin_csr_malevolence",
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
		"aiIgnore", 				-- All AI Ignores you
		"dumpTargetInformation", 		-- Dumps debug information about the targeted object, and emails a copy of the information to the player using the command.
		"dumpZoneInformation",  		-- Dumps debug information about the current zone, and emails a copy of the information to the player using the command.
		"getObjVars", 				-- Debug command. Dumps a list of all object variables on the target object, and their specified values.
		"teleport",  				-- Teleport
		"teleportto", 				-- Teleport
		"invulnerable",			  	-- Invulnerable
		"kill",  				-- Kill Mob/NPC
		"setSpeed",  				-- Set Player Speed
		"findObject",				-- Locate and Object or NPC
		"goto",  				-- Go To a Waypoint in your Datapad
		"harmful",  				-- Enables the target to enter combat mode.
		"harmless",  				-- Disables the target from entering combat mode. Notice, they can still be attacked.
		"killPlayer",  				-- Kill a player
		"teleportTarget",  			-- Teleport
		"planetWarp", 				-- Warps to the specified planet.
		"planetWarpTarget", 			-- Warps Player to the specified planet.
		"freezePlayer",  			-- Freeze Player
		"unfreezePlayer", 			-- Unfreeze Player
		"findPlayer",				-- Find a player's coordinates
		"getGameTime",				-- How long a player has played
		"gmRevive",  				-- Brings Dead Player Back to Life
		"setFaction", 				-- Sets the targeted object's faction to neutral, rebel, or imperial as specified
		"setFactionStanding",			-- Sets the amount o ffaction points for the specified faction
		"cityInfo",				-- Get City Information						
		"setTEF",				-- TEF a Player
		"showFactionInformation",		-- Shows a player's faction information
		"editAppearance",			-- Edit a player's Appearance like imagedesiger.
		"editStats",				-- Edit a player's stats, setting min / max values
		"grantBadge",				-- Grant a Badge
		"kick",					-- Kick a player from the server, setting a value will ban them for that many minutes
		"revokeBadge",				-- Revoke a Badge
		"setFirstName",				-- Set Player First Name
		"setLastName",				-- Set Player Last Name
		"setPlayerAppearance",			-- Set Player Appearance to a Mobile
		"setPlayerState",			-- ?
		"clearVeteranReward",			-- Resets a used veteran reward so it can be selected again.
		"editBank",				-- Shows contents of player's bank.
		"grantSkill",				-- Grant a skill to the player
		"hasVeteranReward",			-- Checks to ee if the targeted player has used the specified reward.
		"revokeSkill",				-- Revokes a skill from the player
		"setExperience",			-- Sets a player's experience
		"setVeteranReward",			-- ?
		"snoop",				-- Retreive contents of a players inventory
		"listActiveQuests",			-- Lists all Active quests
		"listCompletedQuests",			-- Lists all completed quests
		"activateQuest",			-- Activates a quest
		"clearCompletedQuest",			-- Clear a completed quest
		"completeQuest",			-- Complete a quest
		"deactivateQuest",			-- Deactivate a quest
		"listGuilds",				-- Lists all guilds on the server that match your criteria
		"broadcast",				-- Broadcast Messaage
		"broadcastArea",			-- Broadcast Messaage
		"broadcastGalaxy",			-- Broadcast Messaage
		"broadcastPlanet",			-- Broadcast Messaage
		"createCreature",			-- Create a Creature from a Mobile
		"createNPC",				-- Create an NPC from a mobile
		"object",
		"createMissionElement",			-- ?
		"createSpawningElement",		-- Creates a spawning element based on a predefined script at the player's current location
		"createSpawningElementWithDifficulty",	-- Creates a spawning element based on a predefined script with a defined dificulty.
		"setName",				-- Sets an object or player's name
		"gmEventTools",

		"gmStaffTools",

		"getPlayerId",
		"getAccountInfo",
		"server",
		"spawnStatus"				
	},
	skillModifiers = {},
	schematicsGranted = {},
	schematicsRevoked = {},
	searchable = 0
}

addSkill(admin_csr_malevolence)
