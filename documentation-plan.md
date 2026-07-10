# SDG-WAYSHELL-CONFIGS Documentation Plan

## Current Status
One doc file exists (`docs/README.md`, brief overview). README at root level is a large (1600+ line) config reference. No tips exist.

## Docs System (`docs/`)
**Deploy location**: `~/.local/docs/SDG-WAYSHELL-CONFIGS/`

### Existing Docs
| File | Topic |
|------|-------|
| docs/README.md | Brief overview: what Wayshell is and how to start it (3 lines) |
| README.md | Comprehensive config reference: all keybinds, rules, themes, start apps, gaps (1600+ lines) |

### Planned Doc Topics
| # | Topic | Description | Priority |
|---|-------|-------------|----------|
| 1 | Configuration Overview | File structure, includes, how wayshell loads config | High |
| 2 | Keybinds Reference | Extracted from 500+ line keybinds section: all SUPER+ maps | High |
| 3 | Window Rules | Application rules: opacity, workspace, float, scratchpad, borders | High |
| 4 | Theme Reference | Theme tokens, color variables, integration with DMS/matugen | High |
| 5 | Animation & Gaps | Gaps config, border animation, window animation | Medium |
| 6 | Startup Applications | Services that launch with Wayshell | Medium |
| 7 | Gesture Bindings | Touchpad and touchscreen gesture bindings | Low |
| 8 | Environment Variables | Key env vars: XDG_CURRENT_DESKTOP, XCURSOR_THEME, GTK_THEME | Low |

### Implementation
- Extract topic-focused docs from the large README.md
- Create `docs/SDG-WAYSHELL-CONFIGS/` with numbered markdown files
- Follow SDG-DOCS naming convention
- Register in `install.sh` for deployment to `~/.local/docs/`

## Tips System (`tips/`)
**Deploy location**: `~/.local/tips/SDG-WAYSHELL-CONFIGS/`

### Planned Tips
| # | Tip | Description | Priority |
|---|-----|-------------|----------|
| 1 | Start Wayshell | Run `wayshell` — launch the SDG-OS Wayland compositor | High |
| 2 | Reload config | Changes in `~/.config/wayshell/` apply on next launch | High |
| 3 | Keybinds config | Edit `~/.config/wayshell/keybinds.conf` to customize shortcuts | Medium |
| 4 | Theme variables | Edit `~/.config/wayshell/themes/Colors` for manual color override | Medium |
| 5 | Window rules | Add app-specific rules in `~/.config/wayshell/rules.conf` | Medium |

### Implementation
- Create `tips/SDG-WAYSHELL-CONFIGS/tips.list` with the above tips
- Register in `install.sh` for deployment to `~/.local/tips/`
