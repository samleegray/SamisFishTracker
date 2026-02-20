local SFT = SamisFishTrackerAddon
local rareFishItemIds = SFT.constants.rareFishItemIds

local function isRareFishEnabled()
  return not SFT.savedVariables or SFT.savedVariables.trackRareFish ~= false
end

local function isRareFish(itemId)
  return rareFishItemIds[itemId] == true
end

local function isGreenQuality(quality)
  return quality == ITEM_QUALITY_UNCOMMON
end

local function isBlueQuality(quality)
  return quality == ITEM_QUALITY_MAGIC
end

function SFT.GetRareFishQuality(itemLink)
  if not isRareFishEnabled() then
    return nil
  end

  local itemId = GetItemLinkItemId(itemLink)
  if not isRareFish(itemId) then
    return nil
  end

  local quality = GetItemLinkQuality(itemLink)
  if isGreenQuality(quality) or isBlueQuality(quality) then
    return quality
  end

  return nil
end

function SFT.IsTrackableFish(itemLink)
  if GetItemLinkItemType(itemLink) ~= ITEMTYPE_FISH then
    return false
  end

  local itemId = GetItemLinkItemId(itemLink)
  return not isRareFish(itemId)
end

function SFT.GetBagFishCounts()
  local total = 0
  local rareGreen = 0
  local rareBlue = 0
  local bagIdPack = BAG_BACKPACK
  local slotBagPack = ZO_GetNextBagSlotIndex(bagIdPack)

  while slotBagPack do
    local itemLink = GetItemLink(bagIdPack, slotBagPack)
    local inventoryCount = GetItemLinkStacks(itemLink)

    if GetItemLinkItemType(itemLink) == ITEMTYPE_FISH then
      local itemId = GetItemLinkItemId(itemLink)
      if isRareFish(itemId) then
        if isRareFishEnabled() then
          local quality = GetItemLinkQuality(itemLink)
          if isGreenQuality(quality) then
            rareGreen = rareGreen + inventoryCount
          elseif isBlueQuality(quality) then
            rareBlue = rareBlue + inventoryCount
          end
        end
      else
        total = total + inventoryCount
      end
    end

    slotBagPack = ZO_GetNextBagSlotIndex(bagIdPack, slotBagPack)
  end

  return total, rareGreen, rareBlue
end

function SFT.GetBankFishCounts()
  local total = 0
  local rareGreen = 0
  local rareBlue = 0
  local trackRare = isRareFishEnabled()
  local fishies = SHARED_INVENTORY:GenerateFullSlotData(
    function(itemdata)
      return itemdata.itemType == ITEMTYPE_FISH
    end,
    BAG_BANK,
    BAG_SUBSCRIBER_BANK
  )

  for _, item in pairs(fishies) do
    if isRareFish(item.itemId) then
      if trackRare then
        if isGreenQuality(item.quality) then
          rareGreen = rareGreen + item.stackCount
        elseif isBlueQuality(item.quality) then
          rareBlue = rareBlue + item.stackCount
        end
      end
    else
      total = total + item.stackCount
    end
  end

  return total, rareGreen, rareBlue
end

function SFT.RefreshTotals()
  local bagTotal, bagRareGreen, bagRareBlue = SFT.GetBagFishCounts()
  local bankTotal, bankRareGreen, bankRareBlue = SFT.GetBankFishCounts()

  SFT.total_bag = bagTotal
  SFT.total_bank = bankTotal
  SFT.total_rare_bag_green = bagRareGreen
  SFT.total_rare_bag_blue = bagRareBlue
  SFT.total_rare_bank_green = bankRareGreen
  SFT.total_rare_bank_blue = bankRareBlue
end

function SFT.UpdateTotal()
  SFT.RefreshTotals()
  SFT.RefreshStorageLabels()
end
