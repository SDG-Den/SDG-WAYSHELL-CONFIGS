# Brightness OSD

Left-edge vertical overlay bar that mirrors the Volume OSD pattern, but controls backlight brightness instead of audio.

## Files

| File | Purpose |
|------|---------|
| `brightness.json` | Waybar config — left edge |
| `brightness.css` | Styling with Matugen colors |
| `brightness.sh` | Main script — reads brightness via `brightnessctl` |
| `brightness-bar.sh` | Renders horizontal bar with Unicode block characters |

## Elements

Same layout as Volume OSD but on the left edge:
- **Up button** (top): +5% brightness
- **Bar** (middle): block-character fill level
- **Down button** (bottom): -5% brightness
- **Icon** (bottom): static sun icon (), not interactive

## Behavior

Appears when cursor touches the left screen edge. Auto-hides after 1.5s of inactivity.

## Dependency

- `brightnessctl` — backlight control
