# SDG-WAYSHELL-CONFIGS Migration Plan

## Directory Mapping

| Source | Installed to |
|--------|-------------|
| `config/wayshellconf/bottom-bar/` (13 files) | `~/.config/SDG-WAYSHELL-CONFIGS/bottom-bar/` |
| `config/wayshellconf/screenshot/` (8 files) | `~/.config/SDG-WAYSHELL-CONFIGS/screenshot/` |
| `config/wayshellconf/volume/` (5 files) | `~/.config/SDG-WAYSHELL-CONFIGS/volume/` |
| `config/wayshellconf/brightness/` (4 files) | `~/.config/SDG-WAYSHELL-CONFIGS/brightness/` |
| `config/wayshellconf/colors.css` | `~/.config/SDG-WAYSHELL-CONFIGS/colors.css` |
| `config/wayshellconf/waybar-modules` | `~/.config/SDG-WAYSHELL-CONFIGS/waybar-modules` |
| `tips/` | `~/.local/tips/SDG-WAYSHELL-CONFIGS/` |
| `docs/` | `~/.local/docs/SDG-WAYSHELL-CONFIGS/` |

## Path Rewrites

All config files previously referenced `~/.config/sdgos/wayshell/configs/`. After migration:

### bottom-bar/ — elevated & focused process monitor scripts

| Old | New |
|-----|-----|
| `~/.config/sdgos/wayshell/configs/elevated-daemon.sh` | `~/.config/SDG-WAYSHELL-CONFIGS/bottom-bar/elevated-daemon.sh` |
| `~/.config/sdgos/wayshell/configs/bottom-bar.json` | `~/.config/SDG-WAYSHELL-CONFIGS/bottom-bar/bottom-bar.json` |
| `~/.config/sdgos/wayshell/configs/bottom-bar.css` | `~/.config/SDG-WAYSHELL-CONFIGS/bottom-bar/bottom-bar.css` |
| (same for all elevated-* and focused-* scripts) | |

### screenshot/ — screenshot toolbar

| Old | New |
|-----|-----|
| `~/.config/sdgos/wayshell/configs/ss-capture.sh` | `~/.config/SDG-WAYSHELL-CONFIGS/screenshot/ss-capture.sh` |
| `~/.config/sdgos/wayshell/configs/screenshot.json` | `~/.config/SDG-WAYSHELL-CONFIGS/screenshot/screenshot.json` |
| (same for all ss-* scripts) | |

### volume/ — volume bar

| Old | New |
|-----|-----|
| `~/.config/sdgos/wayshell/configs/volume-bar.sh` | `~/.config/SDG-WAYSHELL-CONFIGS/volume/volume-bar.sh` |
| `~/.config/sdgos/wayshell/configs/volume.json` | `~/.config/SDG-WAYSHELL-CONFIGS/volume/volume.json` |

### brightness/ — brightness bar

| Old | New |
|-----|-----|
| `~/.config/sdgos/wayshell/configs/brightness-bar.sh` | `~/.config/SDG-WAYSHELL-CONFIGS/brightness/brightness-bar.sh` |
| `~/.config/sdgos/wayshell/configs/brightness.json` | `~/.config/SDG-WAYSHELL-CONFIGS/brightness/brightness.json` |

### CSS @import paths

All subdirectory CSS files (`bottom-bar.css`, `screenshot.css`, `volume.css`, `brightness.css`) now use `@import "../colors.css"` instead of `@import "./colors.css"`.

### Waybar JSON includes

- `bottom-bar.json` includes: `bottom-bar-modules` (same dir)
- `screenshot.json` includes: `screenshot-modules` (same dir)
- `volume.json` includes: `../waybar-modules` (root level)
- `brightness.json` includes: `../waybar-modules` (root level)

### Cross-module references (SDG-WAYSHELL wayshell.modules)

Updated to reference subdirectory paths (e.g., `brightness/brightness.json`, `volume/volume.json`, `bottom-bar/elevated-show.sh`).

## Matugen Auto-Theming

The theming pipeline (unchanged):

1. **Template** lives in SDG-WAYSHELL at `~/.local/SDG-WAYSHELL/colors.css` (Jinja2)
2. **MATUGEN.toml** in SDG-WAYSHELL configures: input=`~/.local/SDG-WAYSHELL/colors.css`, output=`~/.config/SDG-WAYSHELL-CONFIGS/colors.css`
3. **Generated colors.css** sits at the root of `~/.config/SDG-WAYSHELL-CONFIGS/`
4. All subdirectory CSS files `@import "../colors.css"` to access themed colors

This works because all CSS files are exactly one level deep, so `../colors.css` resolves to the root colors.css regardless of which subdirectory they're in.

## Lifecycle Scripts

All three are empty. Implement:

**install.sh**:
- `WORKDIR=/home/$(whoami)/.cache/SDG-PKG/sdg-wayshell-conf`
- `cp -r $WORKDIR/config/* /home/$(whoami)/.config/SDG-WAYSHELL-CONFIGS`
- Create docs/tips dirs, copy
- The source has subdirectories → `cp -r` preserves the structure

**uninstall.sh**:
- `rm -rf ~/.config/SDG-WAYSHELL-CONFIGS`
- `rm -rf ~/.local/docs/SDG-WAYSHELL-CONFIGS`
- `rm -rf ~/.local/tips/SDG-WAYSHELL-CONFIGS`

**update.sh**:
- Re-deploy config/* and docs/*, tips/* from cache

**detect.sh** → REMOVED (empty, not needed)

## Cleanup

- `cache/` — empty, remove
- `other/` — empty, remove
- `docs/` — empty, add placeholder
- `tips/` — empty, add placeholder
