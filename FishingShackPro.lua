local addon, ns = ...
local L = ns.L

local FSP = CreateFrame("Button", "FSP", UIParent, "SecureActionButtonTemplate")

-- attach script and event handler
FSP:SetScript("OnEvent", function(self, event, ...) return self[event] and self[event](self, ...) end)
FSP:RegisterEvent("PLAYER_LOGIN")

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

-- Add a function to the local frame that can search the inventory for an itemID 
--   and return the link to the item. 
-- use string.find to locate an item:xxxx string within the returned hyperlink
--   from GetContainerItemLink(container,slot)
-- Returns a link to the upgraded item
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

-- Add a function to the local frame that will loop over a passed table param
--  (in descending order based upon the pre-defined table structure) and break 
--   if we are already using the selected item OR if an upgrade is found
function FSP:CheckForUpgrades(currentItemLink, theTable)
	for key, betterItemID in ipairs(theTable) do
		-- extract the itemID from the passed Link
		local currentItemID = self:GetItemID(currentItemLink)
		-- check if we have already equipped the 'best'
		if currentItemID == betterItemID then 
			-- already using the best so look no further
			break
		else -- check inventory for a superior item
			local betterItemLink = self:SearchMyInventory(betterItemID)
			if betterItemLink then
				-- output a chat frame message to inform the user what we did
				EquipItemByName(betterItemLink)
				print("|cff0066ffFishingShackPro:|r " .. L.UPGRADE_WARN .. currentItemLink .. L.UPGRADE_TEXT .. betterItemLink .. "!")
				break -- found a superior item so skip the rest
			end
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

-- after the login event, confirm the addon is loaded
function FSP:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_LOGIN") -- no longer needed
	self:RegisterEvent("ADDON_LOADED") -- is this thing on?
end

-- are we loaded?
function FSP:ADDON_LOADED()
	local arg1 = ...
	-- is our addon loaded?
	if (arg1 == addon) then
		self:UnregisterEvent("ADDON_LOADED") -- we're good, stop monitoring
		self:RegisterEvent("UNIT_INVENTORY_CHANGED", "player") -- start monitoring inventory updates
	end	
end

-- monitor UNIT_INVENTORY_CHANGED for when new items are looted that may be better than what we have		
function FSP:UNIT_INVENTORY_CHANGED(toon)
	-- get localized sub-type (i.e. "Fishing Poles")
	local localFishingPoles = select(7, GetItemInfo(6256)) 
	-- are we using a fishing pole of any kind?
	local usingPole = IsEquippedItemType(localFishingPoles)
	-- if we're using a fishing pole, then check for upgrades
	if usingPole then
		-- POLES
		local poleLink = GetInventoryItemLink("player", 16)
		self:CheckForUpgrades(poleLink, fishPoles)
		
		-- HATS
		local hatLink = GetInventoryItemLink("player", 1)
		self:CheckForUpgrades(hatLink, fishHats)
	end
end