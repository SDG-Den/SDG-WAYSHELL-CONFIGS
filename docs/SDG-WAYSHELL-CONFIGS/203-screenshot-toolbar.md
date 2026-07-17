# Screenshot Toolbar

Top-center overlay toolbar with 7 buttons for screenshot capture across 3 output modes.

## Files

| File | Purpose |
|------|---------|
| `screenshot.json` | Waybar config |
| `screenshot.css` | Styling |
| `screenshot-modules` | 7 button module definitions |
| `ss-capture.sh` | Core capture script — 4 targets x 3 modes |
| `ss-mode.sh` | Shows current output mode |
| `ss-mode-cycle.sh` | Cycles between output modes |
| `ss-settings.sh` | Reads settings for current mode |
| `ss-settings-menu.sh` | Zenity-based settings dialog |

## Buttons

| Button | Action |
|--------|--------|
| Monitor | Capture current focused monitor |
| Area | Interactive region selection via `slurp` |
| All | Capture all monitors |
| Window | Capture focused window |
| OBS | Launch OBS Studio |
| Mode | Cycle disk → clipboard → editor |
| Settings | Open mode-specific settings dialog |

## Output Modes

| Mode | Behavior |
|------|----------|
| Disk | Save to file + `notify-send` notification |
| Clipboard | Copy to clipboard via `wl-copy` |
| Editor | Open captured image in editor app |

## State

Mode, save directory, and editor preference persist across sessions in `~/.config/screenshot.state`.

## Dependencies

- `grim` — screenshot capture
- `slurp` — interactive region selection
- `wl-copy` (wl-clipboard) — clipboard operations
- `mmsg` — monitor/window detection
- `notify-send` — notifications
- `zenity` (optional) — settings dialogs
- `OBS Studio` (optional) — launch button
