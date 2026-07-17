# Volume OSD

Right-edge vertical overlay bar that shows and controls PipeWire volume.

## Files

| File | Purpose |
|------|---------|
| `volume.json` | Waybar config — right edge, 36px wide, margin-top/bottom 300px |
| `volume.css` | Styling with Matugen colors |
| `volume.sh` | Main script — reads volume via `wpctl get-volume` |
| `volume-bar.sh` | Renders horizontal bar with Unicode block characters (█/░) |
| `volume-icon.sh` | Shows mute/unmute icon (/) |

## Elements

- **Up button** (top): click to +5% volume
- **Bar** (middle): block-character fill level, click/scroll to adjust
- **Down button** (bottom): click to -5% volume
- **Icon** (bottom): mute state indicator, click to open PulseAudio Volume Control

## Behavior

Appears when cursor touches the right screen edge. Auto-hides after 1.5s of inactivity.

## Dependencies

- `wpctl` (PipeWire) — volume control
- `pavucontrol` (optional) — detailed volume mixer on icon click
