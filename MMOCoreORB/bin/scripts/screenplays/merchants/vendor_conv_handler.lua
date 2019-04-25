VendorConvoHandler = conv_handler:new {
	--Vendor Setup
	vendorLogicType = VendorLogic,
	--Vendor Greeting
	initialDialog = "Test initial",
	--Player selection to start buying, vendor spatial.
	saleOption = "Test Sale Option",
	saleDialog = "Test Sale Dialog",
	--Player selection to get vendor information, vendor dialog.
	informationFirstOption = "",
	informationFirstDialog = "",
	--Player selection to get vendor more information, vendor dialog.
	informationSecondOption = "",
	informationSecondDialog = "",
	--Set faction restriction
	factionRestriction = "",
}

function VendorConvoHandler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	
	if (self.factionRestriction ~= "") then
		if (self.factionRestriction == FACTIONIMPERIAL and not CreatureObject(pPlayer):getFaction() == FACTIONIMPERIAL) or 
		(self.factionRestriction == FACTIONREBEL and not CreatureObject(pPlayer):getFaction() == FACTIONREBEL) or
		(CreatureObject(pPlayer):getFactionStanding(self.factionRestriction) < 200) then
			return convoTemplate:getScreen("factionRestriction")
		end
	end
	
	return convoTemplate:getInitialScreen()
end


function VendorConvoHandler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
	local screen = LuaConversationScreen(pConvScreen)
	local screenID = screen:getScreenID()
	local pConvScreen = screen:cloneScreen()
	local clonedScreen = LuaConversationScreen(pConvScreen)
	
	if (screenID == "initial") then
		clonedScreen:setCustomDialogText(self.initialDialog)
		clonedScreen:addOption(self.saleOption, "start_sale")
		if (self.informationFirstOption ~= "") then
			clonedScreen:addOption(self.informationFirstOption, "information_first")
		end
		if (self.informationSecondOption ~= "") then
			clonedScreen:addOption(self.informationSecondOption, "information_second")
		end
	end
	
	if (screenID == "start_sale") then
		clonedScreen:setCustomDialogText(self.saleDialog)
		self.vendorLogicType:openSUI(pPlayer)
	end
	
	if (screenID == "information_first") then
		clonedScreen:setCustomDialogText(self.informationFirstDialog)
		clonedScreen:addOption(self.saleOption, "start_sale")
		if (self.informationSecondOption ~= "") then
			clonedScreen:addOption(self.informationSecondOption, "information_second")
		end
	end
	
	if (screenID == "information_second") then
		clonedScreen:setCustomDialogText(self.informationSecondDialog)
		clonedScreen:addOption(self.saleOption, "start_sale")
		if (self.informationFirstOption ~= "") then
			clonedScreen:addOption(self.informationFirstOption, "information_first")
		end
	end
	return pConvScreen
end

EventVendorConvoHandler = VendorConvoHandler:new {
	--Vendor Setup
	vendorLogicType = EventVendorLogic,
	--Vendor Greeting
	initialDialog = "Ya-hoo, namen Minbob Qozz, me travelen da world sellen items per special event tokens. Do yousa wanten be buyin sometten?",
	--Player selection to start buying, vendor spatial.
	saleOption = "Show me what you have for sale.",
	saleDialog = "Okeeday, hair's what me have per sale.",
	--Player selection to get vendor information, vendor dialog.
	informationFirstOption = "What sort of items do you sell?",
	informationFirstDialog = "Lots of stuffen, maken sure to come backen every now and again as me updaten stock wit new items.",
	--Player selection to get vendor more information, vendor dialog.
	informationSecondOption = "How do I get event tokens?",
	informationSecondDialog = "Participaten in events all across da galaxy. When yousa getsa some tokens, maken sure to come backen to mesa and traden yous tokens per items.",
}
