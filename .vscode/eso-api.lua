---@meta

-----------------------------------------------------------
-- LIBGROUPCOMBATSTATS LIBRARY
-----------------------------------------------------------

LibAddonMenu2 = {}

---LibGroupCombatStats - Tracks and reports group combat statistics
---@class LibGroupCombatStats
---@field EVENT_GROUP_DPS_UPDATE string Event fired when group member DPS updates
---@field EVENT_PLAYER_DPS_UPDATE string Event fired when player DPS updates
LibGroupCombatStats = {}

---Register an addon with LibGroupCombatStats
---@param addonName string The name of your addon
---@param stats string[] Array of stat types to track (e.g., {"DPS"})
---@return LibGroupCombatStatsHandle|nil handle The handle for registering events, or nil on failure
function LibGroupCombatStats.RegisterAddon(addonName, stats) end

---Handle returned by RegisterAddon for event registration
---@class LibGroupCombatStatsHandle
local LibGroupCombatStatsHandle = {}

---Register for a LibGroupCombatStats event
---@param event string The event constant (e.g., LibGroupCombatStats.EVENT_GROUP_DPS_UPDATE)
---@param callback fun(unitTag: string, dpsData: table) The callback function
function LibGroupCombatStatsHandle:RegisterForEvent(event, callback) end

---Unregister from a LibGroupCombatStats event
---@param event string The event constant
---@param callback function The callback function to remove
function LibGroupCombatStatsHandle:UnregisterForEvent(event, callback) end

RETICLE.interact = {}

SamisFishTrackerControlLabelBagFish = {}
SamisFishTrackerControlLabelBankFish = {}
SamisFishTrackerControlLabelBagRoe = {}
SamisFishTrackerControlLabelBankRoe = {}
SamisFishTrackerControlLabelFish = {}
SamisFishTrackerControlLabelRoe = {}
SamisFilletTrackerControlLabelPerfectRoe = {}
SamisFilletTrackerControlLabelFilletStats = {}
SamisFilletTrackerControlLabelAverageRate = {}
SamisFishTrackerControlLabelAverage = {}
