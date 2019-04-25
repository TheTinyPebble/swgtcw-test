EventVendorLogic = VendorLogic:new {
	scriptName = "EventVendorLogic",
	currencies = {
	--For Tokens: Displayed Name, full template string (without shared_), if applicable: ScreenPlayData string, ScreenPlayData key
		{currency = "token", name = "Event Tokens", template = "object/tangible/loot/misc/event_token.iff", ScreenPlayDataString = "vendorToken", ScreenPlayDataKey = "event_token"},
	},
	--Displayed Name, full template string (without shared_), cost in {}, use the same structure as currencies
	merchandise = {
		{name = "Painting - Bounty Hunter Overlook", template = "object/tangible/painting/painting_exclusive1.iff", cost = {10,}},
        {name = "Painting - Legion", template = "object/tangible/painting/painting_exclusive2.iff", cost = {10,}},
        {name = "Painting - Count Dooku", template = "object/tangible/painting/painting_exclusive3.iff", cost = {10,}},
        {name = "Painting - Droideka", template = "object/tangible/painting/painting_exclusive4.iff", cost = {10,}},
        {name = "Painting - Darth Maul", template = "object/tangible/painting/painting_exclusive5.iff", cost = {10,}},
        {name = "Painting - The Holocron", template = "object/tangible/painting/painting_exclusive6.iff", cost = {10,}},
        {name = "Painting - B1 Sketch", template = "object/tangible/painting/painting_exclusive7.iff", cost = {10,}},
        {name = "Painting - Fett", template = "object/tangible/painting/painting_exclusive8.iff", cost = {10,}},
        {name = "Painting - The General", template = "object/tangible/painting/painting_exclusive9.iff", cost = {10,}},
        {name = "Painting - Darth Maul", template = "object/tangible/painting/painting_exclusive10.iff", cost = {10,}},
        {name = "Painting - Space Battle", template = "object/tangible/painting/painting_exclusive11.iff", cost = {10,}},
        {name = "Painting - Cantina Band", template = "object/tangible/painting/painting_exclusive12.iff", cost = {10,}},
        {name = "Painting - Landing Zone", template = "object/tangible/painting/painting_exclusive13.iff", cost = {10,}},
        {name = "Painting - B1 Schematic", template = "object/tangible/painting/painting_exclusive14.iff", cost = {10,}},
        {name = "Painting - Eternal Struggle", template = "object/tangible/painting/painting_silhouette.iff", cost = {10,}},
	},
}

registerScreenPlay("EventVendorLogic", false)
