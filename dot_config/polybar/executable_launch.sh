#!/bin/bash
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down (max 5 seconds)
timeout 5 bash -c 'while pgrep -u $UID -x polybar >/dev/null; do sleep 0.2; done' 2>/dev/null

# Wait for monitors to be ready
sleep 0.5

# Launch polybar on each monitor
monitors=$(polybar --list-monitors 2>/dev/null | cut -d":" -f1)
if [ -z "$monitors" ]; then
    # Fallback: launch on default monitor
    polybar main &
else
    for m in $monitors; do
        MONITOR=$m polybar main &
    done
fi
