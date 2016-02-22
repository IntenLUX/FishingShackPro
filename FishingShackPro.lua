local addon, ns = ...
local L = {}
L["Now using"] = "Now using"
L["replaced by"] = "replaced by"
L["UPGRADE!"] = "UPGRADE!"

-- define a fishing pole table sorted by an arbitrary 'best' order
local fishPoles = {
-- ID     Name                               +Skill +Other          Faction?
"118381", -- Ephemeral Fishing Pole             100
"19970" , -- Arcanite Fishing Pole               40
"116826", -- Draenic Fishing Pole                30    Lure +200       Alliance
"116825", -- Savage Fishing Pole                 30    Lure +200       Horde
"44050" , -- Mastercraft Kalu'ak Fishing Pole    30    Waterbreathing
"45991" , -- Bone Fishing Pole                   30
"45992" , -- Jeweled Fishing Pole                30
"84661" , -- Dragon Fishing Pole                 30
"45858" , -- Nat's Lucky Fishing Pole            25
"6367"  , -- Big Iron Fishing Pole               20
"19022" , -- Nat Pagle's Extreme Angler FC-5000  20
"25978" , -- Seth's Graphite Fishing Pole        20
"6366"  , -- Darkwood Fishing Pole               15
"84660" , -- Pandaren Fishing Pole               10
"46337" , -- Staats' Fishing Pole                 3                    Alliance
"12225" , -- Blump Family Fishing Pole            3
"6365"  , -- Strong Fishing Pole                  5
"120163", -- Thruk's Fishing Rod                  3
"6256"  ,  -- Fishing Pole                        0
}

-- Hats table sorted by arbitrary 'best' order
local fishHats = {
"118380", -- Hightfish Cap                     100
"118393", -- Tentacled Hat                     100   
"117405", -- Nat's Drinking Hat                 10   Lure +150
"88710" , -- Nat's Hat                           5   Lure +150
"33820" , -- Weather-Beaten Fishing Hat          5   Lure +75
"93732" , -- Darkmoon Fishing Cap                5   Summon Debris Pool during Darkmoon Faire
"19972" , -- Lucky Fishing Hat                   5   +15 STA
}

-- create the addon frame
local FSP = CreateFrame("Frame", nil, UIParent)
FSP:RegisterEvent("ADDON_LOADED")

--[[
Add a function to the local frame that can search the inventory for an itemID 
and return the link to the item. Use string.find to locate an item:xxxx string 
within the returned hyperlink from GetContainerItemLink(container,slot) function.
The function eturns a link to the upgraded item
]]--
function FSP:SearchMyInventory(itemID)
	-- format the itemID with the string within the link
	local strItemID = "item:"..itemID..":" 
	-- loop over all containers by the containerID index
	for containerID = 0, 4 do 
		-- search the each of the slots within this containerID for the requested item
		for containerSlotID = 1, GetContainerNumSlots(containerID) do 
			-- get the link for this slotID
			local strResult = GetContainerItemLink(containerID, containerSlotID)
			-- is this the droid we're looking for?
			if strResult and strResult:find(strItemID) then
				-- success!
				return strResult
			end
		end
	end
end

--[[
Add a function to the local frame that will loop over a passed table param
(in descending order based upon the pre-defined table structure) and break 
if we are already using the selected item OR if an upgrade is found.
--]]
function FSP:CheckForUpgradesFromSomething(currentItemLink, theTable)
	for key, betterItemID in ipairs(theTable) do
		-- extract the itemID from the passed Link
		local currentItemID = self:GetItemID(currentItemLink)
		-- check if we have already equipped the 'best'
		if currentItemID == betterItemID then 
			-- already using the best so look no further
			break
		-- check inventory for a superior item
		else 
			local betterItemLink = self:SearchMyInventory(betterItemID)
			if betterItemLink then
				EquipItemByName(betterItemLink)
				-- output a chat frame message to inform the user what we did
				print("|cff0066ffFishingShackPro:|r " .. L["UPGRADE!"] .. " " .. currentItemLink .. " " .. L["replaced by"] .. " " .. betterItemLink .. "!")
				break -- found a superior item so skip the rest
			end
		end
	end 
end

--[[
Add a function to the local frame that will loop over a passed table param
(in descending order based upon the pre-defined table structure) and break 
if an upgrade is found.  Used when nothing is currently equipped.
--]]
function FSP:CheckForUpgradesFromNothing(theTable)
	for key, betterItemID in ipairs(theTable) do
		local betterItemLink = self:SearchMyInventory(betterItemID)
		if betterItemLink then
			EquipItemByName(betterItemLink)
			-- output a chat frame message to inform the user what we did
			print("|cff0066ffFishingShackPro:|r " .. L["UPGRADE!"] .. " " .. L["Now using"] .. betterItemLink .. "!")
			break -- found a superior item so skip the rest
		end
	end 
end

-- Extract the ItemID from the item link
function FSP:GetItemID(link)
	local itemID
	if link then
		itemID = string.match(link, "item:(%-?%d+):")
		return itemID
	end
end

-- Script handlers
FSP:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" and ... == addon then
		-- we've loaded, who cares about the rest?
		self:UnregisterEvent("ADDON_LOADED")
		-- now that we're loaded, start monitoring UNIT_INVENTORY_CHANGED for this player
		self:RegisterEvent("UNIT_INVENTORY_CHANGED", "player")
	elseif event == "UNIT_INVENTORY_CHANGED" then
		-- get localized sub-type for the fishing pole (i.e. "Fishing Poles")
		local localFishingPoles = select(7, GetItemInfo(6256)) 
		-- are we using a fishing pole of any kind?
		local usingPole = IsEquippedItemType(localFishingPoles)
		-- if we're using a fishing pole, then check for upgrades
		if usingPole then
			-- POLES
			local poleLink = GetInventoryItemLink("player", 16)
			-- no need to check FromNothing as we already assume a fishing pole is equipped
			self:CheckForUpgradesFromSomething(poleLink, fishPoles)
			
			-- HATS
			local hatLink = GetInventoryItemLink("player", 1)
			if hatLink == nil then
				self:CheckForUpgradesFromNothing(fishHats)
			else 
				self:CheckForUpgradesFromSomething(hatLink, fishHats)
			end
		end
	end
end)
