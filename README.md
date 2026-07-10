# SDG-WAYSHELL-CONFIGS

Waybar widget configurations and monocle window switcher bars for the SDG-WAYSHELL daemon.

## Description

SDG-WAYSHELL-CONFIGS provides all Waybar-based widgets and overlays consumed by SDG-WAYSHELL at runtime. It includes volume/brightness OSDs, a screenshot toolbar, bottom bar with process monitors, and per-monitor monocle/deck window switchers (~1000 lines of Bash across 24 scripts).

## Widgets

### Volume OSD (Right Edge)
- Vertical bar with block characters (█/░)
- Up/down buttons, scroll, mute icon
- Uses `wpctl` for PipeWire volume control

### Brightness OSD (Left Edge)
- Mirror of volume on left side
- Uses `brightnessctl`

### Screenshot Toolbar (Top-Center)
- 7 buttons: monitor, area, all, window, launch OBS, cycle mode, settings
- 3 output modes: disk (save), clipboard (wl-copy), editor (open in app)
- Uses `grim` + `slurp` for capture

### Bottom Bar — Elevated Processes (Bottom-Left)
- Root/U0 process detection via /proc tree walk
- Shows title, monitor, tag — clickable to focus
- Pin-to-keep-visible mechanism

### Bottom Bar — Focused Process (Bottom-Right)
- Current window CPU% (per-core), RAM, GPU% (nvidia-smi)
- Rolling max-of-5 smoothing for stable readings

### Monocle Window Switchers (Per-Monitor)
- 3 Waybar instances for DP-1, DP-3, HDMI-A-1
- 10 clickable window slots per monitor
- Window indexer daemon (1s interval) using mmsg IPC
- Launcher buttons (fuzzel, terminal, files), navigation, clock, system tray, hardware monitor

## Architecture

SDG-WAYSHELL-CONFIGS is **not directly invoked by users**. It is consumed by SDG-WAYSHELL. When the daemon detects an event (cursor zone, layout change), it launches Waybar instances using configs and scripts from this package.

## Signal-Based Refresh

| Signal | Purpose |
|--------|---------|
| SIGRTMIN+1 | Refresh elevated modules |
| SIGRTMIN+2 | Refresh focused modules |
| SIGRTMIN+3 | Refresh FPS module |

## Installation

```bash
sdgpkg install sdg-wayshell-conf
```

## Dependencies

- `waybar` — bar rendering
- `mmsg` — mangoWM IPC
- `wpctl` (PipeWire) — volume control
- `brightnessctl` — brightness control
- `grim`, `slurp` — screenshot capture
- `wl-copy` (wl-clipboard) — clipboard
- `jq` — JSON parsing
- `bc` — CPU calculation math
- `notify-send` — notifications
- `nvidia-smi` (optional) — GPU display
- `fuzzel`, `alacritty`, `OBS Studio` (optional) — launcher buttons

## Related Packages

- **SDG-WAYSHELL** — launches these configs at runtime
- **SDG-MANGO-CORE** — autostart chain leads to wayshell starting
