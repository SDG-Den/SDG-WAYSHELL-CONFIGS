# Bottom Bar: Focused Process

Bottom-right section of the bottom bar that tracks the active window's resource usage.

## Files

| File | Purpose |
|------|---------|
| `bottom-bar.json` | Waybar config |
| `bottom-bar.css` | Styling |
| `bottom-bar-modules` | Module definitions |
| `focused-daemon.sh` | Core daemon — tracks CPU%, RAM, GPU% of focused window |
| `focused-show.sh` | Shows the focused process zone |
| `focused-hide.sh` | Hides the focused process zone |
| `focused-pin.sh` | Pin/unpin to keep current window displayed |

## Metrics

| Metric | Source |
|--------|--------|
| CPU% | Per-core calculation via `/proc` tree walk of the process and its children |
| RAM | Memory in K/M/G units from `/proc` |
| GPU% | `nvidia-smi` (optional — only shown if available) |

## Smoothing

CPU readings use a rolling max-of-5 samples for stable display.

## Pin Mechanism

When pinned, the bar stays visible even when the cursor leaves the zone. Metrics always reflect the currently focused window — pin only prevents the bar from hiding, it does not freeze the displayed values.

## Refresh

Triggered by **SIGRTMIN+2** sent to the Waybar process. GPU/FPS updates use **SIGRTMIN+3**.

## Dependencies

- `mmsg` — focused window detection
- `bc` — CPU calculation math
- `nvidia-smi` (optional) — GPU utilization
