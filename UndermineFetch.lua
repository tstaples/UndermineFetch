-- print("name = " + name + " | item id = " + itemId);
--------------------------------------------------------------------------------------------------------
BINDING_HEADER_UndermineFetch = "UndermineFetch"
BINDING_NAME_UDMF_GET_URL = "Get Undermine url"

local function MakeURL(itemId)
	--- TODO: get region/realm from api
	local baseUrl = "https://theunderminejournal.com/#us/tichondrius/item/"
	return baseUrl .. itemId
end

local function GetItemIndex()
	local listItemIndex = GetSelectedAuctionItem("list")
	local ownedItemIndex = GetSelectedAuctionItem("owner")
	if listItemIndex > 0 then
		return listItemIndex, "list"
	end
	if ownedItemIndex > 0 then
		return ownedItemIndex, "owner"
	end
	return 0, nil -- invalid
end

-- TODO: support items from bags, bank, and tsm panels
local function GetSelectedItemInfo()
	local index, itemType = GetItemIndex()
	if index == 0 or not itemType then
		return nil, nil, nil
	end
	
	local name, texture, count, quality, canUse, level, levelColHeader, minBid,
	    minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner,
	    ownerFullName, saleStatus, itemId, hasAllInfo = GetAuctionItemInfo(itemType, index)

	local itemLink = GetAuctionItemLink(itemType, index)

	return name, itemId, itemLink
end

-- TODO: do nothing if in combat or if none of the applicable interfaces are open
function UDMF_ShowURL()
	local name, itemId, itemLink = GetSelectedItemInfo()
	if name and itemId and itemLink then
		local url = MakeURL(itemId)
		-- print("item name: " .. name .. " | id: " .. itemId .. " | link: " .. itemLink);
		-- TODO: remove this if we can link it by clicking the name on the frame
		print("[UndermineFetch] Selected item: " .. itemLink)
		UDMF_UI_Show(url, itemLink)
	else
		print("[UndermineFetch] Invalid/None item selected")
	end
end

local function UDMF_OnSlashCommand(cmd, editBox)
	if cmd == "test" then
		UDMF_UI_Show("blah", "itemLink")
		return
	end

	UDMF_ShowURL()
end

SLASH_UDMF_CMD1 = "/udm"
SLASH_UDMF_CMD2 = "/ud"
SlashCmdList["UDMF_CMD"] = UDMF_OnSlashCommand