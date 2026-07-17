# Architecture Overview

SDG-WAYSHELL-CONFIGS provides Waybar-based widgets and overlays consumed by the SDG-WAYSHELL compositor daemon at runtime. It is **not directly invoked by users**.

## How It Works

SDG-WAYSHELL monitors cursor zones and layout events. When triggered (e.g., cursor touches screen edge, monocle layout activates), it launches Waybar instances using configs from this package.

## Overlay Design

All transient widget overlays use these Waybar settings:
- `"layer": "overlay"` — floats above other windows
- `"exclusive": false` — does not reserve space (except screenshot toolbar)
- Per-edge positioning — right (volume), left (brightness), top-center (screenshot), bottom (process bars)

Exception: the **screenshot toolbar** uses `"exclusive": true` so its appearance does not shift underlying content.

Monocle switchers use `"layer": "top"` (persistent per-monitor bars, implicitly exclusive).

## Components

| Component | Edge | Directory |
|-----------|------|----------|
| Volume OSD | Right | `volume/` |
| Brightness OSD | Left | `brightness/` |
| Screenshot Toolbar | Top-center | `screenshot/` |
| Bottom Bar (elevated + focused) | Bottom | `bottom-bar/` |
| Monocle Switchers | Bottom (per-monitor) | `config/SDG-MONOCLE/` + `local/SDG-MONOCLE/` |

## Bottom Bar Shared Instance

The elevated and focused process bars share a single Waybar instance (`bottom-bar.json`). Each module sets a flag file in `$XDG_CACHE_HOME/wayshell/`:
- `bottom_elevated_visible` — 1 when elevated module is active
- `bottom_focused_visible` — 1 when focused module is active

The Waybar instance stays alive as long as at least one flag is set. When both flags clear (cursor left both zones and neither is pinned), the instance is killed. Pin overrides hide — a pinned module always keeps its flag set.

## Signal-Based Refresh

| Signal | Purpose |
|--------|---------|
| SIGRTMIN+1 | Refresh elevated modules |
| SIGRTMIN+2 | Refresh focused modules |
| SIGRTMIN+3 | Refresh FPS/GPU module |

## Related Packages

- **SDG-WAYSHELL** — launches these configs at runtime
- **SDG-MANGO-CORE** — autostart chain leads to wayshell starting
