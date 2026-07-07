# SDG-WAYSHELL-CONFIGS Migration Plan

## Directory Mapping

| Source | Installed to |
|--------|-------------|
| `config/wayshellconf/` (22+ files) | `~/.config/SDG-WAYSHELL-CONFIGS/` (with subdirectory reorg) |
| `tips/` | `~/.local/tips/SDG-WAYSHELL-CONFIGS/` |
| `docs/` | `~/.local/docs/SDG-WAYSHELL-CONFIGS/` |

## Subdirectory Reorganization

The 22+ files currently flat in `config/wayshellconf/` should be organized into feature subdirectories:

```
~/.config/SDG-WAYSHELL-CONFIGS/
├── bottom-bar/
│   ├── bottom-bar.sh
│   ├── bottom-left.sh
│   └── bottom-right.sh
├── screenshot/
│   ├── screenshot-area.sh
│   ├── screenshot-screen.sh
│   ├── screenshot-win.sh
│   ├── screenshot-ss.sh
│   @   screenshot-module.sh -> ../screenshot/screenshot-area.sh
│   @   screenshot-screenshot-screenshooter.sh -> ../screenshot/screenshot-screen.sh
├── volume/
│   ├── volume-down.sh
│   ├── volume-mute.sh
│   └── volume-up.sh
├── brightness/
│   ├── brightness-down.sh
│   └── brightness-up.sh
├── window/
│   ├── window-kill.sh
│   ├── window-half-left.sh
│   └── window-half-right.sh
├── mpv/
│   ├── mpv-queue.sh
│   └── mpv-seek.sh
├── player/
│   ├── player-next.sh
│   ├── player-pause.sh
│   └── player-prev.sh
├── wofi/
│   ├── wofi-powermenu.sh
│   └── wofi-run.sh
├── media/
│   └── media-ffwd.sh (or wf-recorder)
└── migration/
    └── wayshell.modules (document steps)
```

The **subdirectory names** are feature groups. Within each group, the install script places the corresponding flat files. The benefits:
- Clear ownership per script
- Easy to script per-group install/uninstall
- Avoids 22-file flat naming collisions

## Path Rewrites

### Cross-module references TO SDG-WAYSHELL-CONFIGS

| From | Old Reference | New Reference |
|------|--------------|---------------|
| SDG-MANGO-CORE/binds.conf | `.../wayshell/configs/ss-*.sh` | `~/.config/SDG-WAYSHELL-CONFIGS/screenshot/ss-*.sh` |
| SDG-WAYSHELL/wayshell.modules | `$HOME/.config/wayshellconf/...` | `$HOME/.config/SDG-WAYSHELL-CONFIGS/...` (with subdirs) |

The `wayshell.modules` references to `wayshellconf` scripts must be updated in **SDG-WAYSHELL** (not here). This module only provides the scripts.

## Lifecycle Scripts

All four root-level scripts are empty. Implement:

- **install.sh**: Copy files to `~/.config/SDG-WAYSHELL-CONFIGS/` organized into subdirectories. Each subdirectory is a feature group. The install script should:
  1. Detect files in `config/wayshellconf/`.
  2. Group by category (bottom-bar, volume, brightness, etc.) using a mapping table in install.sh.
  3. Create subdirectories.
  4. Copy files into their group subdirectory.
- **uninstall.sh**: Remove `~/.config/SDG-WAYSHELL-CONFIGS/` entirely.
- **update.sh**: Re-deploy with backup.
- **detect.sh**: Check `wayshell` is installed.

## Example install.sh Grouping Logic

```bash
# In install.sh:
declare -A GROUPS
GROUPS=(
  ["bottom-bar.sh"]="bottom-bar"
  ["bottom-left.sh"]="bottom-bar"
  ["bottom-right.sh"]="bottom-bar"
  ["volume-down.sh"]="volume"
  ["volume-mute.sh"]="volume"
  ["volume-up.sh"]="volume"
  ["brightness-down.sh"]="brightness"
  ["brightness-up.sh"]="brightness"
  ["window-kill.sh"]="window"
  ["window-half-left.sh"]="window"
  ["window-half-right.sh"]="window"
  ["mpv-queue.sh"]="mpv"
  ["mpv-seek.sh"]="mpv"
  ["player-next.sh"]="player"
  ["player-pause.sh"]="player"
  ["player-prev.sh"]="player"
  ["screenshot-area.sh"]="screenshot"
  ["screenshot-screen.sh"]="screenshot"
  ["screenshot-win.sh"]="screenshot"
  ["wofi-powermenu.sh"]="wofi"
  ["wofi-run.sh"]="wofi"
)

SRC="config/wayshellconf"
DST="$HOME/.config/SDG-WAYSHELL-CONFIGS"

for file in "$SRC"/*.sh; do
  basename=$(basename "$file")
  group=${GROUPS[$basename]}
  [ -n "$group" ] && mkdir -p "$DST/$group" && cp "$file" "$DST/$group/"
done
```

## Modular Tips

- Create `tips/` with wayshell config scripts usage tips.

## Modular Docs

- Create `docs/` documenting the available waybar/wayshell scripts and their keybind mappings.

## Cleanup

- Remove `config/wayshellconf/deprecated/` — mark as deprecated
- Remove empty `cache/`, `other/`, `tips/`
