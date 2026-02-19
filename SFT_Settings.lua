local SFT = _G.SFT
local visibility = SFT.constants.visibility
local LAM2 = LibAddonMenu2

local visibilityChoiceMap = {
  ["Always Show"] = visibility.SHOW,
  ["Always Hide"] = visibility.HIDE,
  ["Auto (Fishing Nodes)"] = visibility.AUTO,
}

local function getVisibilityChoice()
  local mode = SFT.savedVariables.visibility

  if mode == visibility.SHOW then
    return "Always Show"
  elseif mode == visibility.AUTO then
    return "Auto (Fishing Nodes)"
  end

  return "Always Hide"
end

function SFT.settingsInit()
  if not LAM2 then
    return
  end

  local panelData = {
    type = "panel",
    name = "Sami's Fish Tracker",
    author = "@samihaize",
    version = SFT.version,
  }

  LAM2:RegisterAddonPanel("SamisFishTrackerOptions", panelData)

  local optionsData = {}
  optionsData[#optionsData + 1] = {
    type = "description",
    text = "Tracks your fish and estimated Perfect Roe across bag and bank. Slash commands: /sft, /sft show, /sft hide, /sft auto, /sft reset.",
  }

  optionsData[#optionsData + 1] = {
    type = "header",
    name = "Display Options",
  }
  optionsData[#optionsData + 1] = {
    type = "dropdown",
    name = "Visibility Mode",
    tooltip = "Choose when the tracker window is shown",
    choices = { "Always Show", "Always Hide", "Auto (Fishing Nodes)" },
    getFunc = function()
      return getVisibilityChoice()
    end,
    setFunc = function(choice)
      SFT.savedVariables.visibility = visibilityChoiceMap[choice] or visibility.HIDE
      SFT.ApplyVisibilitySetting()
    end,
  }

  optionsData[#optionsData + 1] = {
    type = "header",
    name = "Actions",
  }
  optionsData[#optionsData + 1] = {
    type = "button",
    name = "Reset Session Fish Count",
    tooltip = "Sets the tracker count back to 0",
    func = function()
      SFT.ResetFishAmount()
    end,
    warning = "This only resets the tracked count, not fish in your inventory.",
  }

  LAM2:RegisterOptionControls("SamisFishTrackerOptions", optionsData)
end