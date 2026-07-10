# SDG-WAYSHELL-CONFIGS Analysis

## Type
Waybar Widget Configuration + Monocle Bars Module

## Description
SDG-WAYSHELL-CONFIGS provides all Waybar-based widgets and overlays for the SDG-WAYSHELL compositor ecosystem. It includes volume/brightness OSDs, a screenshot toolbar, a bottom bar with elevated and focused process monitoring, and per-monitor monocle window switcher bars (~1000 lines of Bash across 24 scripts).

## Usage
SDG-WAYSHELL-CONFIGS is not directly invoked by users. It is consumed by SDG-WAYSHELL at runtime. When the wayshell daemon detects an event (cursor zone, layout change), it launches Waybar instances using configs and scripts from this package.

### Volume OSD
Appears when cursor touches the right screen edge. A vertical Waybar overlay shows:
- **Up button** (top): click to increase volume by 5%
- **Bar** (middle): rendered with block characters (█/░), clickable, scrollable
- **Down button** (bottom): click to decrease volume by 5%
- **Icon** (bottom): shows mute/unmute state (/)
Hover briefly and the bar auto-hides after 1.5 seconds.

### Brightness OSD
Same pattern on the left edge. Uses `brightnessctl` instead of `wpctl`.

### Screenshot Toolbar
Appears at top-center. Buttons:
| Button | Action |
|--------|--------|
| Monitor | Capture current monitor |
| Area | Interactive region selection (slurp) |
| All | Capture all monitors |
| Window | Capture focused window |
| OBS | Launch OBS Studio |
| Mode | Cycle disk → clipboard → editor |
| Settings | Open mode-specific settings dialog |

### Bottom Bar
Appears at bottom-left/bottom-right showing:
- **Elevated processes** (left): root/U0 processes with title, monitor, tag. Click to focus. Pin icon to keep visible. Shows "sudo" cap label.
- **Focused process** (right): current window title, CPU% (per-core), RAM, GPU% (nvidia-smi). Pin to keep visible.

### Monocle Window Switchers
When monocle/deck/vdeck layout is active on a monitor, a per-monitor bottom bar appears with:
- 10 clickable window slots showing titles
- Navigation: next/prev window buttons
- Launcher: fuzzel, terminal (alacritty), file manager (nautilus)
- System panel: clock, tray, CPU, memory, disk, network, battery, pulseaudio, bluetooth

## Directory Structure
```
SDG-WAYSHELL-CONFIGS/
├── README.md                     # Minimal stub ("# SDG-WAYSHELL-CONFIGS")
├── install.sh / update.sh / uninstall.sh
├── config/SDG-WAYSHELL-CONFIGS/
│   ├── colors.css                # Material You color definitions (Matugen)
│   ├── waybar-modules            # Shared module definitions
│   ├── volume/                   # Vertical volume OSD (right side)
│   │   ├── volume.json           # Waybar config
│   │   ├── volume.css            # Styling
│   │   ├── volume.sh             # Main script (wpctl)
│   │   ├── volume-bar.sh         # Horizontal bar variant
│   │   └── volume-icon.sh        # Mute/unmute icon
│   ├── brightness/               # Vertical brightness OSD (left side)
│   │   ├── brightness.json / .css / .sh
│   │   └── brightness-bar.sh
│   ├── screenshot/               # Top-center screenshot toolbar
│   │   ├── screenshot.json / .css
│   │   ├── screenshot-modules    # 7 button definitions
│   │   ├── ss-*.sh               # capture, mode-cycle, mode, settings-menu, settings
│   │   └── ...
│   └── bottom-bar/               # Bottom taskbar (elevated + focused)
│       ├── bottom-bar.json / .css
│       ├── bottom-bar-modules    # 14 module definitions
│       ├── elevated-*.sh         # daemon, show, hide, pin, focus, cap
│       └── focused-*.sh          # daemon, show, hide, pin, cap
├── config/SDG-MONOCLE/
│   ├── colors.css                # Matugen colors for monocle bars
│   ├── style.css                 # Monocle bar styling
│   ├── config-dp1 / config-dp3 / config-hdmi  # Per-monitor Waybar configs
│   └── modules-dp1.json / dp3.json / hdmi.json # 351 lines each
├── local/SDG-MONOCLE/
│   ├── monocle.sh                # Waybar launcher per monitor
│   ├── indexer.sh                # Window indexer daemon
│   ├── focuswindow.sh            # Focus window by index
│   └── fetchwindow.sh            # Get window title by index
├── docs/SDG-WAYSHELL-CONFIGS/.placeholder
└── tips/SDG-WAYSHELL-CONFIGS/.placeholder
```

## Widgets

### Volume OSD (Right Edge)
- Vertical bar rendered with block characters (█/░)
- Up/down buttons, scroll control, mute icon
- Uses `wpctl get-volume` for PipeWire control
- Waybar overlay: right side, 36px wide, margin-top/bottom 300px

### Brightness OSD (Left Edge)
- Mirror of volume on left side
- Uses `brightnessctl` for backlight control
- Same vertical bar rendering

### Screenshot Toolbar (Top-Center)
- 7 buttons: capture monitor, select area, all monitors, active window, launch OBS, cycle mode, settings
- **3 output modes**: disk (save + notify), clipboard (wl-copy), editor (open in app)
- Uses `grim` + `slurp` for capture, `mmsg` for monitor/window detection

### Bottom Bar — Elevated Processes (Bottom-Left)
- Detects root/U0 processes by walking /proc tree of all client windows
- Shows up to 5 entries with title, monitor, tag
- Clickable to focus, pin-to-keep-visible mechanism
- Cap label shows "sudo" when visible

### Bottom Bar — Focused Process (Bottom-Right)
- Tracks focused window, shows CPU% (per-core), RAM (K/M/G), GPU (nvidia-smi)
- Process-tree walking for accurate CPU/RAM attribution
- Rolling max-of-5 smoothing for stable CPU readings
- Pin-to-keep-visible system

### Monocle Window Switchers (Per-Monitor)
- 3 Waybar instances for DP-1, DP-3, HDMI-A-1
- 10 window slots per monitor, clickable to focus
- Window indexer daemon (1s interval) using mmsg IPC
- Includes launcher buttons (fuzzel, terminal, files), navigation, system status panel

## Signal-Based Refresh
| Signal | Purpose |
|--------|---------|
| SIGRTMIN+1 | Refresh elevated modules |
| SIGRTMIN+2 | Refresh focused modules |
| SIGRTMIN+3 | Refresh FPS module |

## Required Dependencies
| Dependency | Purpose |
|------------|---------|
| waybar | Bar rendering |
| mmsg | mangoWM IPC for window/clients |
| wpctl (PipeWire) | Volume control |
| brightnessctl | Brightness control |
| grim | Screenshot capture |
| slurp | Region selection |
| wl-copy (wl-clipboard) | Clipboard operations |
| jq | JSON parsing |
| bc | CPU calculation math |
| notify-send | Screenshot notifications |

## Optional Dependencies
| Dependency | Purpose |
|------------|---------|
| nvidia-smi | GPU utilization display |
| zenity | Screenshot settings dialogs |
| pavucontrol | Volume settings (on-click) |
| ydotool | Key simulation |
| btop | Process viewer (on-click) |
| fuzzel | Application launcher |
| alacritty | Terminal launcher |
| OBS Studio | Screenshot → OBS launch |

## Required Dependents
- **SDG-WAYSHELL**: Launches these configs and scripts at runtime
- **SDG-MANGO-CORE**: Autostart chain leads to wayshell starting

## Optional Dependents
- **SDG-DOCS**: Documents widgets
