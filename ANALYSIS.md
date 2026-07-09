# SDG-WAYSHELL-CONFIGS — Repository Analysis

## Function

Provides waybar configuration files, CSS themes, and shell scripts for SDG-OS
OSD bars (volume, brightness, screenshot toolbar, bottom-bar with elevated/focused
process monitors) plus SDG-MONOCLE (a window-indexing waybar for tiled layouts).

Installed via `sdg-wayshell-conf` package — declared in `SDG-OS-META/install.sh:12`
and registered in `SDG-REPO/SDGOS.repo` (line 6).

---

## Dependencies

| Dependency | Why | Evidence |
|---|---|---|
| `sdg-wayshell` (unipkg) | install.sh depends on `unipkg install any sdg-wayshell` at line 3 — ensures wayshell event daemon + `mmsg` CLI are available | `SDG-WAYSHELL-CONFIGS/install.sh:3` |
| `unipkg` | meta-package manager used by install.sh; transitive dep via sdg-wayshell | `install.sh:3`, `SDG-OS-META/install.sh:4` |
| `waybar` | All config JSONs target waybar (bottom-bar, screenshot, volume, brightness, monocle) | Every `.json` and `.css` file |
| `jq` | Used extensively in daemon scripts for JSON parsing (elevated-daemon, focused-daemon, indexer) | `elevated-daemon.sh`, `focused-daemon.sh`, `indexer.sh` |
| `wpctl` (pipewire) | Volume bar, volume icon, volume.sh | `volume/volume-bar.sh:6`, `volume/volume.sh:6` |
| `brightnessctl` | Brightness bar | `brightness/brightness-bar.sh:6`, `brightness/brightness.sh:6` |
| `grim` / `slurp` | Screenshot capture | `screenshot/ss-capture.sh:27,31,36,55` |
| `wl-copy` | Clipboard screenshots | `screenshot/ss-capture.sh:72` |
| `notify-send` | Screenshot notifications | `screenshot/ss-capture.sh:57-64,73-79` |
| `nvidia-smi` | FPS daemon (GPU utilization) | `bottom-bar/focused-daemon.sh:255-258` |
| `zenity` | Screenshot settings dialogs | `screenshot/ss-settings-menu.sh:19,39` |
| `python3` | JSON parsing in ss-capture.sh | `screenshot/ss-capture.sh:26,41` |
| `bc` | Floating-point CPU/RAM math | `elevated-daemon.sh:139`, `focused-daemon.sh:138,199,218` |
| `ps` / `procps-ng` | Process tree walking | `elevated-daemon.sh:40`, `focused-daemon.sh:56` |
| `matugen` (via sdg-themes) | Generates `colors.css` | `SDG-WAYSHELL/local/SDG-WAYSHELL/MATUGEN.toml:3`, `SDG-MANGO-CORE/config/matugen/config.toml:20-22` |
| `nwg-look` (optional) | Font scaling referenced in style.css comment | `config/SDG-MONOCLE/style.css:7` |

---

## Dependents

| Dependent | How it uses SDG-WAYSHELL-CONFIGS | File & Line |
|---|---|---|
| **SDG-WAYSHELL** | `wayshell.modules` references subdirectory scripts (e.g., `brightness/brightness.json`, `volume/volume.json`, `bottom-bar/elevated-show.sh`) | `SDG-WAYSHELL/config/SDG-WAYSHELL/wayshell.modules` (cross-ref via SDG-WAYSHELL/migration-plan.md:18,24-25) |
| **SDG-MANGO-CORE** | `config/matugen/config.toml` writes generated `colors.css` to `~/.config/SDG-WAYSHELL-CONFIGS/colors.css` | `SDG-MANGO-CORE/config/matugen/config.toml:20-22` |
| **SDG-OS-META** | `install.sh` runs `sdgpkg install sdg-wayshell-conf` to deploy this package | `SDG-OS-META/install.sh:12` |
| **SDG-DOCS** | SDG-DOC-DEVS/arch docs and SDG-DOC-TINKERERS/configuring-modules.md reference SDG-WAYSHELL-CONFIGS as a named service | `01-architecture-overview.md:15`, `02-configuring-modules.md:29` |
| **GLOBAL-MIGRATION-GUIDE** | Documents migration from old `~/.config/sdgos/wayshell/configs/` paths to SDG-WAYSHELL-CONFIGS | `GLOBAL-MIGRATION-GUIDE.md:244,258-269` |
| **SDG-WAYSHELL migration-plan.md** | Documents cross-package path rewrites into SDG-WAYSHELL-CONFIGS | `SDG-WAYSHELL/migration-plan.md:18,24-25` |

---

## Use / Configuration

### Directory structure at install destination

| Source path | Installed to |
|---|---|
| `config/wayshellconf/bottom-bar/` | `~/.config/SDG-WAYSHELL-CONFIGS/bottom-bar/` |
| `config/wayshellconf/screenshot/` | `~/.config/SDG-WAYSHELL-CONFIGS/screenshot/` |
| `config/wayshellconf/volume/` | `~/.config/SDG-WAYSHELL-CONFIGS/volume/` |
| `config/wayshellconf/brightness/` | `~/.config/SDG-WAYSHELL-CONFIGS/brightness/` |
| `config/wayshellconf/colors.css` | `~/.config/SDG-WAYSHELL-CONFIGS/colors.css` |
| `config/wayshellconf/waybar-modules` | `~/.config/SDG-WAYSHELL-CONFIGS/waybar-modules` |
| `config/SDG-MONOCLE/*` | `~/.config/SDG-MONOCLE/` |
| `local/SDG-MONOCLE/*` | `~/.local/SDG-MONOCLE/` |
| `docs/` | `~/.local/docs/SDG-WAYSHELL-CONFIGS/` |
| `tips/` | `~/.local/tips/SDG-WAYSHELL-CONFIGS/` |

### Theming pipeline

1. Matugen template in `SDG-WAYSHELL/local/SDG-WAYSHELL/MATUGEN.toml` or
   `SDG-MANGO-CORE/config/matugen/config.toml` writes to
   `~/.config/SDG-WAYSHELL-CONFIGS/colors.css`
2. All subdirectory CSS files `@import "../colors.css"` — works because every
   CSS file is exactly one level deep

### Module references

- `bottom-bar.json` includes `bottom-bar-modules` (same dir)
- `screenshot.json` includes `screenshot-modules` (same dir)
- `volume.json` includes `../waybar-modules` (root level)
- `brightness.json` includes `../waybar-modules` (root level)

### Lifecycle scripts

- **install.sh** (`install.sh:1-29`): deploys all configs, scripts, docs, tips from cache
- **uninstall.sh** (`uninstall.sh:1-9`): removes scripting + docs/tips only; preserves user configs; strips executable bits
- **update.sh** (`update.sh:1-16`): re-deploys scripting + docs/tips; preserves user configs
- No `detect.sh` (removed per migration plan)

### SDG-MONOCLE architecture

- `monocle.sh` (`local/SDG-MONOCLE/monocle.sh:4-5`): launches waybar per-monitor with config `~/.config/SDG-MONOCLE/config-$MON` and `style.css`
- `indexer.sh` (`local/SDG-MONOCLE/indexer.sh:1-35`): queries `mmsg get all-clients`, writes `index: <N> \ <title> \ <id>` to `monocle-$MONITOR.state`
- `fetchwindow.sh` (`local/SDG-MONOCLE/fetchwindow.sh:1-16`): reads state file for window title at index N
- `focuswindow.sh` (`local/SDG-MONOCLE/focuswindow.sh:1-22`): reads state file, dispatches `mmsg dispatch focusid client,$WINDOWID`
- Config files: `config-hdmi`, `config-dp1`, `config-dp3` — identical apart from monitor output name and included modules file
- Modules: `modules-hdmi.json`, `modules-dp1.json`, `modules-dp3.json` — identical apart from monitor name passed to scripts
- Style: `style.css` imports `./colors.css` (same dir) — uses `@surface`, `@surface_container`, `@primary` from Matugen-generated colors

---

## Deprecation / Outdated Items

### 1. `elevated-cap.sh` — dead code
- `config/wayshellconf/bottom-bar/elevated-cap.sh` (12 lines)
- Checks `VISIBLE_FILE` and echoes `"sudo"` if visible
- **Unused:** `bottom-bar-modules` does NOT reference `elevated-cap.sh` anywhere
  — the `custom/cap` module (line 56-61) calls `elevated-daemon.sh cap` instead
- Safe to delete; `elevated-daemon.sh` already implements the `cap` role at lines 159-168

### 2. MONOCLE bar — NOT auto-themed
- `config/SDG-MONOCLE/colors.css` is a static checked-in file (identical to
  `config/wayshellconf/colors.css` but NOT regenerated by matugen)
- `config/SDG-MONOCLE/style.css` imports `./colors.css` from the same directory
- The matugen template in `SDG-WAYSHELL` and `SDG-MANGO-CORE` only writes to
  `~/.config/SDG-WAYSHELL-CONFIGS/colors.css` — never to `~/.config/SDG-MONOCLE/colors.css`
- **Impact:** MONOCLE bar stays dark-theme regardless of wallpaper changes

### 3. Stale migration guide references
- `migration-plan.md` line 79: "All three are empty" refers to install.sh/uninstall.sh/update.sh
  — these scripts are now implemented (install.sh 29 lines, uninstall.sh 9 lines, update.sh 16 lines)
- `migration-plan.md` line 95: "detect.sh → REMOVED (empty, not needed)" — already done
- `migration-plan.md` line 120-123: "cache/ — empty, remove" and "other/ — empty, remove" —
  `cache/` and `other/` do not exist in the current repo; `docs/` and `tips/` have `.placeholder` files
- `GLOBAL-MIGRATION-GUIDE.md:249`: warns that `wayshell.modules` has mixed `/home/den/` and
  `/home/$(whoami)/` references — presumably fixed but the guide still flags this as CRITICAL
- `SDG-WAYSHELL/migration-plan.md:28` mentions monocle paths as "hardcoded `/home/den/`...
  also broken" — should be reviewed against current `wayshell.modules`

### 4. Empty docs/ and tips/
- `docs/SDG-WAYSHELL-CONFIGS/` contains only `.placeholder`
- `tips/SDG-WAYSHELL-CONFIGS/` contains only `.placeholder`
- install.sh copies them to `~/.local/docs/` and `~/.local/tips/` but there is no content

### 5. Non-prefixed `screenshot.state` path
- `config/wayshellconf/screenshot/ss-capture.sh:4`:
  `state_file=$HOME/.config/screenshot.state`
- `config/wayshellconf/screenshot/ss-mode-cycle.sh:2`:
  `state_file=$HOME/.config/screenshot.state`
- `config/wayshellconf/screenshot/ss-mode.sh:2`:
  `state_file=$HOME/.config/screenshot.state`
- `config/wayshellconf/screenshot/ss-settings-menu.sh:2`:
  `state_file=$HOME/.config/screenshot.state`
- **Issue:** Uses bare `screenshot.state` at `~/.config/` root instead of
  `SDG-WAYSHELL-CONFIGS/screenshot/screenshot.state` — could collide with
  other packages or tools that also use `~/.config/screenshot.state`

### 6. `ss-settings.sh` — unused?
- `config/wayshellconf/screenshot/ss-settings.sh` (17 lines) outputs JSON with
  tooltip — but `screenshot-modules` (line 35-39) defines `custom/ss-settings`
  with `format: ""` (static icon) and no `exec` callback
- The file exists but is never referenced by any config; `ss-settings-menu.sh`
  handles the on-click action instead

### 7. `volume.sh` and `brightness.sh` — alternate implementations
- `volume/volume.sh` and `brightness/brightness.sh` each render a full
  JSON text output with all controls (up/bar/down vertically) — similar to
  `*-bar.sh` but as an all-in-one script
- **Not referenced** by any JSON module include — only `volume-bar.sh` and
  `brightness-bar.sh` are used in `waybar-modules`
- Appear to be legacy/alternate implementations that could be removed