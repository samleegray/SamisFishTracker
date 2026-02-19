local SFT = _G.SFT
local constants = SFT.constants

local function formatIconLabel(iconPath, amount)
  return string.format("|t16:16:%s|t : %d", iconPath, amount)
end

local function formatRoeLabel(amount)
  return string.format("Est. |t16:16:%s|t : %d", constants.icons.roe, amount * constants.roeRate)
end

function SFT.InitializeBackground()
  if not SamisFishTrackerControlBG then
    local bg = WINDOW_MANAGER:CreateControl("SamisFishTrackerControlBG", SamisFishTrackerControl, CT_TEXTURE)
    bg:SetDimensions(200, 75)
    bg:SetAnchor(TOPLEFT, SamisFishTrackerControl, TOPLEFT, 0, 0)
    bg:SetDrawLevel(-1)
    bg:SetColor(0, 0, 0, 0.8)
    SamisFishTrackerControlBG = bg
  end
end

function SFT.ResizeWindow()
  local bankHidden = SamisFishTrackerControlLabelBankFish:IsHidden()
  local newHeight = bankHidden and constants.windowHeightCollapsed or constants.windowHeightFull
  
  SamisFishTrackerControl:SetHeight(newHeight)
  if SamisFishTrackerControlBG then
    SamisFishTrackerControlBG:SetDimensions(200, newHeight)
  end
end

function SFT.UpdateBankDisplay()
  if SFT.total_bank <= 0 then
    SamisFishTrackerControlLabelBankFish:SetHidden(true)
    SamisFishTrackerControlLabelBankRoe:SetHidden(true)
  else
    SamisFishTrackerControlLabelBankFish:SetHidden(false)
    SamisFishTrackerControlLabelBankRoe:SetHidden(false)
    SamisFishTrackerControlLabelBankFish:SetText(formatIconLabel(constants.icons.bank, SFT.total_bank))
    SamisFishTrackerControlLabelBankRoe:SetText(formatRoeLabel(SFT.total_bank))
  end
  
  SFT.ResizeWindow()
end

function SFT.RefreshStorageLabels()
  SamisFishTrackerControlLabelBagFish:SetText(formatIconLabel(constants.icons.bag, SFT.total_bag))
  SamisFishTrackerControlLabelBagRoe:SetText(formatRoeLabel(SFT.total_bag))
  SFT.UpdateBankDisplay()
end

function SFT.UpdateFishCount(count)
  SFT.fishamount = count or 0
  SamisFishTrackerControlLabelFish:SetText(formatIconLabel(constants.icons.fish, SFT.fishamount))
  SamisFishTrackerControlLabelRoe:SetText(formatRoeLabel(SFT.fishamount))
end

function SFT.UpdateFishAmount(amount)
  local increment = amount or 0
  SFT.UpdateFishCount(SFT.fishamount + increment)
  SFT.total_bag = SFT.total_bag + increment
  SFT.RefreshStorageLabels()
end

function SFT.ResetFishAmount()
  SFT.UpdateFishCount(0)
  SFT.savedVariables.amount = 0
end
