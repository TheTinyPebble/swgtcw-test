LootGroup = {
	templatePath = ""
	
}

function LootGroup:new (o)
	o = o or { }
	setmetatable(o, self)
    self.__index = self
    return o
end

LootGroups = { }

function LootGroups:addLootGroupTemplate(obj, file)
	if (obj == nil) then
		print("null template specified for " .. file)
	else
		addTemplate(file, obj)
	end
end

function getLootGroupTemplate(crc)
	return LootGroups[crc]
end

includeFile("serverobjects.lua")
