# Monocle Window Switchers

Per-monitor bottom bars that appear when monocle/deck/vdeck layout is active, showing all windows on that monitor.

## Files

### Configuration (`config/SDG-MONOCLE/`)

| File | Purpose |
|------|---------|
| `config-dp1` / `config-dp3` / `config-hdmi` | Per-monitor Waybar configs |
| `modules-dp1.json` / `modules-dp3.json` / `modules-hdmi.json` | Per-monitor module definitions (350+ lines, 10 window slots each) |
| `colors.css` | Matugen Material You color definitions |
| `style.css` | Bar styling with rounded corners, surface colors |

### Scripts (`local/SDG-MONOCLE/`)

| File | Purpose |
|------|---------|
| `monocle.sh` | Launches Waybar for a given monitor (takes monitor name as arg) |
| `indexer.sh` | Window indexer daemon — polls at 1s interval via `mmsg` IPC |
| `fetchwindow.sh` | Get window title by index |
| `focuswindow.sh` | Focus window by index |

## Features

- **10 window slots** per monitor showing window titles
- Click a slot to focus that window
- **Navigation**: next/prev window buttons
- **Launcher buttons**: fuzzel (app launcher), alacritty (terminal), nautilus (file manager)
- **System panel**: clock, system tray, CPU, memory, disk, network, battery, pulseaudio, bluetooth

## Polling

- **Indexer daemon** (`indexer.sh`): polls `mmsg` every 1 second to rebuild the window list
- **Window slot modules** (`window1`–`window10`): poll `fetchwindow.sh` every 1.5 seconds for title updates
- **Daemon module** (`custom/daemon`): triggers the indexer on each poll cycle

## Behavior

- 3 Waybar instances run simultaneously for DP-1, DP-3, and HDMI-A-1
- Each instance only shows windows on its assigned monitor
- The indexer daemon (1s interval) updates window lists via mmsg IPC
- Bars are persistent (layer: top, exclusive: true)

## Dependencies

- `mmsg` — window listing and focus IPC
- `fuzzel` (optional) — app launcher
- `alacritty` (optional) — terminal launcher
