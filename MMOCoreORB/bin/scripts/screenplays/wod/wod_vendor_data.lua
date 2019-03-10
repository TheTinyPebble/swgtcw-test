SMWodVendorLogic = VendorLogic:new {
	scriptName = "SMWodVendorLogic",
	curenncies = {
	--For Tokens: Displayed Name, full template string (without shared_), if applicable: ScreenPlayData string, ScreenPlayData key
		{currency = "token", name = "Dathomir Amber", template = "", ScreenPlayDataString = "", ScreenPlayDataKey = ""},
		{currency = "token", name = "Rare Dried Herbs", template = "", ScreenPlayDataString = "", ScreenPlayDataKey = ""},
		{currency = "token", name = "Rancor Teeth", template = "", ScreenPlayDataString = "", ScreenPlayDataKey = ""},
		{currency = "token", name = "Spider Silk", template = "", ScreenPlayDataString = "", ScreenPlayDataKey = ""},
		{currency = "token", name = "Whuffa Leather", template = "", ScreenPlayDataString = "", ScreenPlayDataKey = ""},
	},
	--Displayed Name, full template string (without shared_), cost in {}, use the same structure as currencies
	merchandise = {
		{name = "Allya's Redemption", template = "", cost = {25,5,5,5,5}},
		{name = "Schematic: SMC Journey Boots", template = "", cost = {0,0,0,6,4}},
		{name = "Schematic: SMC Dawn Wrap", template = "", cost = {0,0,0,6,4}},
		{name = "Scehmatic: SMC Striker Shroud", template = "", cost = {0,0,0,6,4}},
		{name = "Schematic: SMC Hunters Mantle", template = "", cost = {0,0,0,6,4}},
		{name = "Schematic: SMC Maidens Skirt", template = "", cost = {0,0,0,6,4}},
		{name = "Scehmatic: SMC Shredder Skirt", template = "", cost = {0,0,0,6,4}},
		{name = "Schematic: SMC Twisted Skirt", template = "", cost = {0,0,0,6,4}},
		{name = "Schematic: SMC Soul Guard", template = "", cost = {0,0,2,6,4}},
		{name = "Schematic: SMC Frenzy Headcover", template = "", cost = {0,0,2,6,4}},
		{name = "Schematic: SMC Mask", template = "", cost = {0,0,2,6,4}},
		{name = "Schematic: SMC Twisted Travel Pack", template = "", cost = {0,0,2,6,4}},
		{name = "Schematic: Hanging Banner, The Maiden", template = "", cost = {0,0,2,5,2}},
		{name = "Schematic: Hanging Banner, The Mother", template = "", cost = {0,0,2,5,2}},
		{name = "Schematic: Hanging Banner, The Crone", template = "", cost = {0,0,2,5,2}},
		{name = "Schematic: SMC Floating Stones", template = "", cost = {5,0,4,0,4}},
		{name = "Schematic: SMC Trilithon", template = "", cost = {5,0,4,0,4}},
		{name = "Schematic: Two-Handed Athame", template = "", cost = {5,5,20,5,5}},
		{name = "Schematic: One-Handed Boline", template = "", cost = {5,5,20,5,5}},
		{name = "Schematic: Witches' War Fan", template = "", cost = {5,5,20,5,5}},
		{name = "Schematic: Twin-Bladed Glaive", template = "", cost = {5,5,20,5,5}},
		{name = "Singing Mountain Clan Tapestry", template = "", cost = {0,0,0,4,4}},
		{name = "Schematic: SMC-style Hut", template = "", cost = {5,30,3,3,9}},
		{name = "Witches of Dathomir Sign (Hanging)", template = "", cost = {6,6,6,6,6}},
		{name = "Witches of Dathomir Sign (Standing)", template = "", cost = {6,6,6,6,6}},
		{name = "Witches of Dathomir Banner Style I (standing)", template = "", cost = {6,6,6,6,6}},
		{name = "Witches of Dathomir Banner Style II (standing)", template = "", cost = {6,6,6,6,6}},
		{name = "Witches of Dathomir Banner Style III (standing)", template = "", cost = {6,6,6,6,6}},
	},
}

registerScreenPlay("SMWodVendorLogic", false)

NSWodVendorLogic = VendorLogic:new {
	scriptName = "NSWodVendorLogic",
	curenncies = {
	--For Tokens: Displayed Name, full template string (without shared_), if applicable: ScreenPlayData string, ScreenPlayData key
		{currency = "token", name = "Dathomir Amber", template = "", ScreenPlayDataString = "", ScreenPlayDataKey = ""},
		{currency = "token", name = "Rare Dried Herbs", template = "", ScreenPlayDataString = "", ScreenPlayDataKey = ""},
		{currency = "token", name = "Rancor Teeth", template = "", ScreenPlayDataString = "", ScreenPlayDataKey = ""},
		{currency = "token", name = "Spider Silk", template = "", ScreenPlayDataString = "", ScreenPlayDataKey = ""},
		{currency = "token", name = "Whuffa Leather", template = "", ScreenPlayDataString = "", ScreenPlayDataKey = ""},
	},
	--Displayed Name, full template string (without shared_), cost in {}, use the same structure as currencies
	merchandise = {
		{name = "Allya's Exile", template = "", cost = {25,5,5,5,5}},
		{name = "Schematic: NS Intricate Boots", template = "", cost = {0,0,0,6,4}},
		{name = "Schematic: NS Vibrant Dread Shroud", template = "", cost = {0,0,0,6,4}},
		{name = "Scehmatic: NS Pestilence Leggings", template = "", cost = {0,0,0,6,4}},
		{name = "Schematic: NS Scourge Leggings", template = "", cost = {0,0,0,6,4}},
		{name = "Schematic: NS Gruesome Wrap", template = "", cost = {0,0,0,6,4}},
		{name = "Scehmatic: NS Battle Mantle", template = "", cost = {0,0,0,6,4}},
		{name = "Schematic: NS Havoc Habit", template = "", cost = {0,0,0,6,4}},
		{name = "Schematic: NS Aerie Stalker Hood", template = "", cost = {0,0,2,6,4}},
		{name = "Schematic: NS Tarnished Shroud", template = "", cost = {0,0,2,6,4}},
		{name = "Schematic: NS Carnage Beret", template = "", cost = {0,0,2,6,4}},
		{name = "Schematic: NS Feather Backpack", template = "", cost = {0,0,2,6,4}},
		{name = "Schematic: Hanging Banner, The Maiden", template = "", cost = {0,0,2,5,2}},
		{name = "Schematic: Hanging Banner, The Mother", template = "", cost = {0,0,2,5,2}},
		{name = "Schematic: Hanging Banner, The Crone", template = "", cost = {0,0,2,5,2}},
		{name = "Schematic: NS Towers", template = "", cost = {5,0,4,0,4}},
		{name = "Schematic: NS-style Gate", template = "", cost = {5,0,4,0,4}},
		{name = "Schematic: Two-Handed Athame", template = "", cost = {5,5,20,5,5}},
		{name = "Schematic: One-Handed Boline", template = "", cost = {5,5,20,5,5}},
		{name = "Schematic: Witches' War Fan", template = "", cost = {5,5,20,5,5}},
		{name = "Schematic: Twin-Bladed Glaive", template = "", cost = {5,5,20,5,5}},
		{name = "Nightsister Tapestry", template = "", cost = {0,0,0,4,4}},
		{name = "Schematic: NS-style Hut", template = "", cost = {5,30,3,3,9}},
		{name = "Witches of Dathomir Sign (Hanging)", template = "", cost = {6,6,6,6,6}},
		{name = "Witches of Dathomir Sign (Standing)", template = "", cost = {6,6,6,6,6}},
		{name = "Witches of Dathomir Banner Style I (standing)", template = "", cost = {6,6,6,6,6}},
		{name = "Witches of Dathomir Banner Style II (standing)", template = "", cost = {6,6,6,6,6}},
		{name = "Witches of Dathomir Banner Style III (standing)", template = "", cost = {6,6,6,6,6}},
	},
}

registerScreenPlay("NSWodVendorLogic", false)