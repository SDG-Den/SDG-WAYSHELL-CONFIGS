# Bottom Bar: Elevated Processes

Bottom-left section of the bottom bar that detects and displays root/U0 processes.

## Files

| File | Purpose |
|------|---------|
| `bottom-bar.json` | Waybar config |
| `bottom-bar.css` | Styling |
| `bottom-bar-modules` | Module definitions (14 total) |
| `elevated-daemon.sh` | Core daemon — walks `/proc` tree of all client windows, detects UID 0 processes |
| `elevated-show.sh` | Shows the elevated zone |
| `elevated-hide.sh` | Hides the elevated zone |
| `elevated-pin.sh` | Pin/unpin to keep zone visible |
| `elevated-focus.sh` | Focus a client by position |
| `elevated-cap.sh` | "sudo" cap label |

## Behavior

- Walks `/proc` for all client windows detected via `mmsg`
- Shows up to 5 entries with title, monitor, and tag
- Click an entry to focus that window
- Pin button keeps elevated zone visible even when no root processes are detected
- Shows "sudo" cap label when elevated processes are present

## Refresh

Triggered by **SIGRTMIN+1** sent to the Waybar process.

## Dependencies

- `mmsg` — mangoWM IPC for client window detection
