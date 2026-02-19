local SFT = _G.SFT
local excludedFishItemIds = SFT.constants.excludedFishItemIds

function SFT.IsTrackableFish(itemLink)
  if GetItemLinkItemType(itemLink) ~= ITEMTYPE_FISH then
    return false
  end

  return not excludedFishItemIds[GetItemLinkItemId(itemLink)]
end

function SFT.GetBagFishCount()
  local total = 0
  local bagIdPack = BAG_BACKPACK
  local slotBagPack = ZO_GetNextBagSlotIndex(bagIdPack)

  while slotBagPack do
    local itemLink = GetItemLink(bagIdPack, slotBagPack)
    local inventoryCount = GetItemLinkStacks(itemLink)

    if SFT.IsTrackableFish(itemLink) then
      total = total + inventoryCount
    end

    slotBagPack = ZO_GetNextBagSlotIndex(bagIdPack, slotBagPack)
  end

  return total
end

function SFT.GetBankFishCount()
  local total = 0
  local fishies = SHARED_INVENTORY:GenerateFullSlotData(
    function(itemdata)
      return itemdata.itemType == ITEMTYPE_FISH and not excludedFishItemIds[itemdata.itemId]
    end,
    BAG_BANK,
    BAG_SUBSCRIBER_BANK
  )

  for _, item in pairs(fishies) do
    total = total + item.stackCount
  end

  return total
end

function SFT.RefreshTotals()
  SFT.total_bag = SFT.GetBagFishCount()
  SFT.total_bank = SFT.GetBankFishCount()
end

function SFT.UpdateTotal()
  SFT.RefreshTotals()
  SFT.RefreshStorageLabels()
end
