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
| `elevated-daemon.sh cap` role | "sudo" cap label (via multi-role script) |

## Behavior

- Triggered by cursor entering the **bottom-left** zone of any monitor
- Walks `/proc` for all client windows detected via `mmsg`, detecting UID 0 processes
- Shows entries with title, monitor, and tag — only visible when elevated processes are detected
- Click an entry to focus that window
- Pin button keeps elevated zone visible even when no root processes are detected
- Shows "sudo" cap label when elevated processes are present
- Shares a single Waybar instance with the focused process bar (bottom-right)

## Refresh

Triggered by **SIGRTMIN+1** sent to the Waybar process.

## Dependencies

- `mmsg` — mangoWM IPC for client window detection
