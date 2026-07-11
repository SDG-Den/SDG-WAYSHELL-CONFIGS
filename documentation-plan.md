# SDG-WAYSHELL-CONFIGS Documentation Plan

## Current Status
Docs directory is empty (only `.placeholder`). Tips directory is empty (only `.placeholder`).
Root README.md (75 lines) provides a widget overview. The previous plan was misfiled — it described SDG-WAYSHELL compositor topics instead of this repo's actual content.

## Source-Verified Inventory
**Components (Waybar widgets, ~992 lines of Bash across 24 scripts):**

### Volume OSD (right edge overlay)
- `volume.json/css` — Waybar overlay config
- `volume.sh` — wpctl-based volume display
- `volume-bar.sh` — horizontal bar renderer (Unicode blocks)
- `volume-icon.sh` — mute/unmute icon

### Brightness OSD (left edge overlay)
- `brightness.json/css` — Waybar overlay config
- `brightness.sh` — brightnessctl-based brightness display
- `brightness-bar.sh` — horizontal bar renderer

### Screenshot Toolbar (top-center overlay)
- `screenshot.json/css` — Waybar overlay config
- `ss-capture.sh` — 4 targets (output/area/screen/window) x 3 modes (disk/clipboard/editor)
- `ss-mode.sh` / `ss-mode-cycle.sh` — mode display and cycling
- `ss-settings.sh` / `ss-settings-menu.sh` — zenity settings dialog

### Bottom Bar: Elevated Processes (bottom-left)
- `elevated-daemon.sh` — detects UID 0 processes via /proc
- `elevated-show.sh` / `elevated-hide.sh` / `elevated-pin.sh` — zone visibility
- `elevated-focus.sh` — focus client by position
- `elevated-cap.sh` — "sudo" label

### Bottom Bar: Focused Process (bottom-right)
- `focused-daemon.sh` — CPU/RAM/GPU tracking via mmsg + /proc
- `focused-show.sh` / `focused-hide.sh` / `focused-pin.sh` — zone visibility

### Monocle Window Switchers (per-monitor bottom bars)
- 3 Waybar instances (DP-1, DP-3, HDMI-A-1)
- `indexer.sh` — window indexer daemon via mmsg
- `fetchwindow.sh` / `focuswindow.sh` — window lookup and focus
- 3 x 351-line modules JSON configs

### Signal System
- SIGRTMIN+1 — refresh elevated modules
- SIGRTMIN+2 — refresh focused modules
- SIGRTMIN+3 — refresh FPS/GPU module

## Docs System (`docs/`)
**Deploy location**: `~/.local/docs/SDG-WAYSHELL-CONFIGS/`

### Planned Doc Topics
| # | Topic | Description | Priority |
|---|-------|-------------|----------|
| 1 | Architecture Overview | How the 4 overlay bars + monocle switchers work together | High |
| 2 | Volume OSD | Configuration, styling, dependency on wpctl | Medium |
| 3 | Brightness OSD | Configuration, styling, dependency on brightnessctl | Medium |
| 4 | Screenshot Toolbar | 4 targets x 3 modes, settings dialog, keybinds | High |
| 5 | Bottom Bar: Elevated Processes | How elevated process detection works, pinning, focus | Medium |
| 6 | Bottom Bar: Focused Process | CPU/RAM/GPU tracking, pinning, nvidia-smi | Medium |
| 7 | Monocle Window Switchers | Per-monitor setup, indexer daemon, 10-slot navigation | High |
| 8 | Signal Refresh System | SIGRTMIN+1/+2/+3, how to add new signal handlers | Low |

### Existing Content
| File | Notes |
|------|-------|
| `README.md` (root) | 75 lines — accurate widget overview. Source material for topics #1-8 |
| `analysis.md` | 162 lines — internal analysis with architecture details |

## Tips System (`tips/`)
**Deploy location**: `~/.local/tips/SDG-WAYSHELL-CONFIGS/`

### Planned Tips
| # | Tip | Priority |
|---|-----|----------|
| 1 | Volume OSD appears when you adjust volume | High |
| 2 | Brightness OSD appears when you adjust brightness | High |
| 3 | Screenshot toolbar at top-center shows capture options | High |
| 4 | Elevated process bar shows sudo/root processes | Medium |
| 5 | Focused process bar shows active app resource usage | Medium |
| 6 | Monocle switchers show windows per monitor | Medium |

## Implementation Notes
- This is NOT SDG-WAYSHELL. The compositor event daemon is a separate package.
- These are Waybar configs and scripts consumed by the wayshell daemon at runtime.
- Docs in `nn-topic-name.md` format under `docs/SDG-WAYSHELL-CONFIGS/`
- Tips in `tips/SDG-WAYSHELL-CONFIGS/tips.list`
- All widget configs are under `config/SDG-WAYSHELL-CONFIGS/` and `config/SDG-MONOCLE/`
