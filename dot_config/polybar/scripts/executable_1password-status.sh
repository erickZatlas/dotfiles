#!/bin/bash
# polybar status indicator for 1Password
# Two states: running (good), not running (alert)

if pgrep -f "/opt/1Password/1password --silent" >/dev/null; then
    echo "%{F#9ece6a} 1P%{F-}"
else
    echo "%{F#f7768e} 1P%{F-}"
fi
