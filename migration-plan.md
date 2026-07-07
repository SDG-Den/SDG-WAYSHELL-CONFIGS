# SDG-WAYSHELL-CONFIGS Migration Plan

## 1. Implement Lifecycle Scripts

All four root-level lifecycle scripts are **empty stubs** — must be implemented:

| Script | Purpose |
|--------|---------|
| `install.sh` | Deploy `config/wayshellconf/` → `~/.config/sdgos/wayshell/configs/`, make scripts executable |
| `uninstall.sh` | Remove `~/.config/sdgos/wayshell/configs/` |
| `update.sh` | Overwrite config scripts |
| `detect.sh` | Check for `waybar`, `brightnessctl`, `wpctl`, `grim`, `slurp`, `jq`, `wl-copy` |

## 2. Path Audit

### 2.1 No hardcoded `/home/$(whoami)/` or `/home/den/`
All scripts in this module correctly use `$HOME`, `~`, or `$XDG_CACHE_HOME`. **This module has the cleanest path usage in the entire project.**

### 2.2 Cache directory convention
Several scripts use:
```bash
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/wayshell"
```
This is correct and consistent. `~/.cache/wayshell/` is the runtime state directory.

## 3. Cross-module References

### 3.1 `config/wayshellconf/bottom-bar-modules` (JSON)
This file references wayshell config scripts with `~/.config/sdgos/wayshell/configs/` paths — all pointing to this module's own deployed files. Correct.

### 3.2 `config/wayshellconf/bottom-bar.json`
- Line 10: `"include": ["~/.config/sdgos/wayshell/configs/bottom-bar-modules"]` — references this module's own `bottom-bar-modules`. Correct.

### 3.3 SDG-WAYSHELL's `wayshell.modules` references this module
- `~/.config/sdgos/wayshell/configs/brightness.json` → this module's `brightness.json`
- `~/.config/sdgos/wayshell/configs/volume.json` → this module's `volume.json`
- `~/.config/sdgos/wayshell/configs/screenshot.json` → this module's `screenshot.json`
- `~/.config/sdgos/wayshell/configs/elevated-*.sh` → this module's scripts
- `~/.config/sdgos/wayshell/configs/focused-*.sh` → this module's scripts
- `~/.config/sdgos/wayshell/configs/ss-*.sh` → this module's scripts
- `~/.config/sdgos/wayshell/configs/bottom-bar.*` → this module's files

### 3.4 SDG-MANGO-CORE's `binds.conf` references this module
- Lines 95-99: `~/.config/sdgos/wayshell/configs/ss-*.sh` — screenshot scripts.

## 4. Deploy Path Map

| Source | Destination | Notes |
|--------|-------------|-------|
| `config/wayshellconf/brightness.sh` | `~/.config/sdgos/wayshell/configs/brightness.sh` | Waybar JSON output |
| `config/wayshellconf/brightness-bar.sh` | `~/.config/sdgos/wayshell/configs/brightness-bar.sh` | Vertical bar display |
| `config/wayshellconf/brightness.json` | `~/.config/sdgos/wayshell/configs/brightness.json` | Waybar config |
| `config/wayshellconf/brightness.css` | `~/.config/sdgos/wayshell/configs/brightness.css` | Waybar style |
| `config/wayshellconf/volume.sh` | `~/.config/sdgos/wayshell/configs/volume.sh` | Waybar JSON output |
| `config/wayshellconf/volume-bar.sh` | `~/.config/sdgos/wayshell/configs/volume-bar.sh` | Vertical bar display |
| `config/wayshellconf/volume-icon.sh` | `~/.config/sdgos/wayshell/configs/volume-icon.sh` | Icon display |
| `config/wayshellconf/volume.json` | `~/.config/sdgos/wayshell/configs/volume.json` | Waybar config |
| `config/wayshellconf/volume.css` | `~/.config/sdgos/wayshell/configs/volume.css` | Waybar style |
| `config/wayshellconf/screenshot.json` | `~/.config/sdgos/wayshell/configs/screenshot.json` | Screenshot waybar config |
| `config/wayshellconf/screenshot.css` | `~/.config/sdgos/wayshell/configs/screenshot.css` | Screenshot waybar style |
| `config/wayshellconf/screenshot-modules` | `~/.config/sdgos/wayshell/configs/screenshot-modules` | Screenshot modules |
| `config/wayshellconf/ss-*.sh` (6 files) | `~/.config/sdgos/wayshell/configs/ss-*.sh` | Screenshot scripts |
| `config/wayshellconf/bottom-bar.json` | `~/.config/sdgos/wayshell/configs/bottom-bar.json` | Bottom bar waybar config |
| `config/wayshellconf/bottom-bar.css` | `~/.config/sdgos/wayshell/configs/bottom-bar.css` | Bottom bar style |
| `config/wayshellconf/bottom-bar-modules` | `~/.config/sdgos/wayshell/configs/bottom-bar-modules` | Bottom bar modules |
| `config/wayshellconf/elevated-*.sh` (6 files) | `~/.config/sdgos/wayshell/configs/elevated-*.sh` | Elevated process bar |
| `config/wayshellconf/focused-*.sh` (4 files) | `~/.config/sdgos/wayshell/configs/focused-*.sh` | Focused process bar |
| `config/wayshellconf/waybar-modules` | `~/.config/sdgos/wayshell/configs/waybar-modules` | Volume/brightness bar modules |

## 5. Screenshot System State
- `ss-capture.sh` reads/writes `~/.config/screenshot.state` (top-level config).
- State file format: `mode=clipboard|disk|editor`, `save_dir=...`, `editor=...`.
- Consider moving to `~/.config/sdgos/wayshell/configs/screenshot.state` for consistency.

## 6. Modular Tips/Help Contribution

### 6.1 Tips
- Add tips about the wayshell bar system (volume/brightness sliders, screenshot toolbar, bottom bar with elevated/focused processes).
- Create `tips/` directory.

### 6.2 Help system
- Contribute a help topic about customizing wayshell configs, screenshot modes, and bottom bar modules.
- The bottom bar and elevated/focused process monitoring is a complex feature — documentation would be valuable.

## 7. Empty Directory Cleanup

| Directory | Status |
|-----------|--------|
| `cache/` | Empty — remove |
| `tips/` | Empty — add tips or remove |
| `other/` | Empty — remove |
| `docs/` | Empty — remove or add module-level docs |

## 8. Module Relationship
- SDG-WAYSHELL-CONFIGS is a **data/config companion** to SDG-WAYSHELL.
- SDG-WAYSHELL provides the daemon runtime, SDG-WAYSHELL-CONFIGS provides all the configs and scripts the daemon manages.
- The split makes sense for independent update cycles.

## 9. Note on the "monocle" config gap
- `wayshell.modules` in SDG-WAYSHELL references `~/.config/sdgos/monocle/` paths.
- No monocle configs exist in SDG-WAYSHELL-CONFIGS or any other current module.
- Either create an SDG-MONOCLE module or add monocle support here.
