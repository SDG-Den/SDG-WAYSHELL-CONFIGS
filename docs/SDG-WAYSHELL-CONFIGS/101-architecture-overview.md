# Architecture Overview

SDG-WAYSHELL-CONFIGS provides Waybar-based widgets and overlays consumed by the SDG-WAYSHELL compositor daemon at runtime. It is **not directly invoked by users**.

## How It Works

SDG-WAYSHELL monitors cursor zones and layout events. When triggered (e.g., cursor touches screen edge, monocle layout activates), it launches Waybar instances using configs from this package.

## Overlay Design

All widget overlays use these Waybar settings:
- `"layer": "overlay"` — floats above other windows
- `"exclusive": false` — does not reserve space
- Per-edge positioning — right (volume), left (brightness), top-center (screenshot), bottom (process bars)

Monocle switchers use `"layer": "top"` with `"exclusive": true` since they are persistent per-monitor bars.

## Components

| Component | Edge | Directory |
|-----------|------|----------|
| Volume OSD | Right | `volume/` |
| Brightness OSD | Left | `brightness/` |
| Screenshot Toolbar | Top-center | `screenshot/` |
| Bottom Bar (elevated + focused) | Bottom | `bottom-bar/` |
| Monocle Switchers | Bottom (per-monitor) | `config/SDG-MONOCLE/` + `local/SDG-MONOCLE/` |

## Signal-Based Refresh

| Signal | Purpose |
|--------|---------|
| SIGRTMIN+1 | Refresh elevated modules |
| SIGRTMIN+2 | Refresh focused modules |
| SIGRTMIN+3 | Refresh FPS/GPU module |

## Related Packages

- **SDG-WAYSHELL** — launches these configs at runtime
- **SDG-MANGO-CORE** — autostart chain leads to wayshell starting
