# Signal Refresh System

Waybar's `signal` module property allows real-time module refresh via POSIX real-time signals. This package uses three signals.

## Signal Table

| Signal | Target | Purpose |
|--------|--------|---------|
| SIGRTMIN+1 | Bottom bar (elevated) | Refresh elevated process list |
| SIGRTMIN+2 | Bottom bar (focused) | Refresh focused process metrics |
| SIGRTMIN+3 | Bottom bar (FPS/GPU) | Refresh GPU utilization and FPS |

## How It Works

Each module in the Waybar config declares a `signal` property matching the signal number (e.g., `"signal": 1` for SIGRTMIN+1). When the signal is sent to the Waybar process, only the matching module re-executes its script.

## Adding a New Signal Handler

To add a new signal-refreshed module:

1. Assign an unused SIGRTMIN+N number
2. Add `"signal": N` to the module definition in the Waybar JSON config
3. The module's `exec` script will be re-run when that signal is sent
4. Send the signal with: `pkill -RTMIN+N waybar` or target a specific PID

## Implementation Details

Signals are sent by daemon scripts (`elevated-daemon.sh`, `focused-daemon.sh`) when they detect changes, rather than on a fixed timer. This is more efficient than polling.
