local SFT = _G.SFT
local visibility = SFT.constants.visibility

function SFT.RestorePosition()
  local left = SFT.savedVariables.left
  local top = SFT.savedVariables.top

  if left == nil or top == nil then
    return
  end

  SamisFishTrackerControl:ClearAnchors()
  SamisFishTrackerControl:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end

function SFT.ApplyVisibilitySetting()
  if SFT.savedVariables.visibility == visibility.SHOW then
    SamisFishTrackerControl:SetHidden(false)
  else
    SamisFishTrackerControl:SetHidden(true)
  end
end

function SFT.Initialize()
  SFT.fishamount = 0

  EVENT_MANAGER:RegisterForEvent(SFT.name, EVENT_LOOT_RECEIVED, SFT.LootReceivedEvent)
  EVENT_MANAGER:RegisterForEvent(SFT.name, EVENT_CLOSE_BANK, SFT.UpdateTotal)

  SFT.savedVariables = ZO_SavedVars:NewAccountWide("SFTSavedVariables", 1, nil, {
    amount = 0,
    visibility = visibility.HIDE,
  })

  SamisFishTrackerControl:SetHandler("OnMoveStop", function()
    SFT.savedVariables.left = SamisFishTrackerControl:GetLeft()
    SFT.savedVariables.top = SamisFishTrackerControl:GetTop()
  end)

  SFT.RefreshTotals()
  SFT.UpdateFishCount(SFT.savedVariables.amount or 0)
  SFT.RefreshStorageLabels()
  SFT.ApplyVisibilitySetting()
  SFT.RestorePosition()
  SFT.RegisterSlashCommands()
end

function SFT.LootReceivedEvent(_, _, itemLink, quantity, _, _, self)
  if not self then
    return
  end

  if not SFT.IsTrackableFish(itemLink) then
    return
  end

  local amount = quantity or 1
  SFT.UpdateFishAmount(amount)
  SFT.savedVariables.amount = SFT.fishamount
end

function SFT.OnAddOnLoaded(_, addonName)
  if addonName ~= SFT.name then
    return
  end

  SFT.Initialize()
  EVENT_MANAGER:UnregisterForEvent(SFT.name, EVENT_ADD_ON_LOADED)

  ZO_PreHookHandler(RETICLE.interact, "OnEffectivelyShown", SFT.ManageInteraction)
  ZO_PreHookHandler(RETICLE.interact, "OnHide", SFT.ManageInteraction)
end

function SFT.ManageInteraction()
  if SFT.savedVariables.visibility ~= visibility.AUTO then
    return
  end

  local action, _, _, _, additionalInfo = GetGameCameraInteractableActionInfo()
  local shouldShow = action and additionalInfo == ADDITIONAL_INTERACT_INFO_FISHING_NODE

  SamisFishTrackerControl:SetHidden(not shouldShow)
end

EVENT_MANAGER:RegisterForEvent(SFT.name, EVENT_ADD_ON_LOADED, SFT.OnAddOnLoaded)
