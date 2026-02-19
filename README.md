# SamisFishTracker

An Elder Scrolls Online addon that tracks your fish inventory and estimates Perfect Roe yield.

## Features

- **Fish Counter** - Tracks the number of fish you catch during your session
- **Inventory Display** - Shows fish count in your bag and bank
- **Perfect Roe Estimation** - Calculates expected Perfect Roe using a configurable fillet rate
- **Average Fish Per Hour** - Shows live fish/hour for your current session
- **Auto-Hide Mode** - Optionally show the tracker only when looking at fishing holes
- **Movable Window** - Drag to reposition; position is saved between sessions
- **Settings Panel** - Configure visibility mode, roe rate, Average Fish Per Hour toggle, and actions in Settings > Addons > Sami's Fish Tracker
- **Account-Wide Saved Variables** - Your settings persist across characters

## Settings

### Display
- **Visibility Mode** - Always Show, Always Hide, or Auto (Fishing Nodes)
- **Show Average Fish Per Hour** - Toggle the Avg/hr line on or off (default: on)

### Roe Estimation
- **Roe Rate Slider** - Adjustable from `0.0001` to `0.1` (default: 0.008)

### Average Fish Per Hour
- **Auto Update Avg/hr** - Automatically refresh the value over time (default: on)
- **Avg/hr Update Frequency** - Refresh interval from 1–60 seconds (default: 1 second)
- **Use Rolling Window for Avg/hr** - Toggle between rolling-window (stable) and session-lifetime (volatile) calculation (default: on)
- **Rolling Window Duration** - Time window for rolling average, 30–3600 seconds (default: 300 seconds / 5 minutes)

### Actions
- **Reset Session Fish Count** - Resets fish count and clears Avg/hr history

## Commands

| Command | Description |
|---------|-------------|
| `/sft` | Toggle window visibility |
| `/sft show` | Always show window |
| `/sft hide` | Always hide window |
| `/sft auto` | Show only when targeting a fishing hole |
| `/sft reset` | Reset fish count to 0 and restart session Avg/hr timing |

## Dependencies

- **LibAddonMenu-2.0** - Required for settings menu

## Optional Dependencies

- **LibSlashCommander** - Provides enhanced slash command support with auto-complete

## License

MIT License - see [LICENSE.md](LICENSE.md)
