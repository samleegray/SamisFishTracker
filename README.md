# SamisFishTracker

An Elder Scrolls Online addon that tracks your fish inventory and estimates Perfect Roe yield.

## Features

- **Fish Counter** - Tracks the number of fish you catch during your session
- **Inventory Display** - Shows fish count in your bag and bank
- **Perfect Roe Estimation** - Calculates expected Perfect Roe using a configurable fillet rate
- **Auto-Hide Mode** - Optionally show the tracker only when looking at fishing holes
- **Movable Window** - Drag to reposition; position is saved between sessions
- **Settings Panel** - Configure visibility, roe rate, and actions in Settings > Addons > Sami's Fish Tracker
- **Account-Wide Saved Variables** - Your settings persist across characters

## Commands

| Command | Description |
|---------|-------------|
| `/sft` | Toggle window visibility |
| `/sft show` | Always show window |
| `/sft hide` | Always hide window |
| `/sft auto` | Show only when targeting a fishing hole |
| `/sft reset` | Reset fish count to 0 |

## Dependencies

- **LibAddonMenu-2.0** - Required for settings menu

## Optional Dependencies

- **LibSlashCommander** - Provides enhanced slash command support with auto-complete

## License

MIT License - see [LICENSE.md](LICENSE.md)
