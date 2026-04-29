#!/bin/bash
# polybar status indicator for AWS VPN Client
# Three states: service down (alert), connected (good), disconnected (disabled)

if ! pgrep -f ACVC.GTK.Service >/dev/null; then
    echo "%{F#f7768e}󰀦 VPN%{F-}"
    exit 0
fi

if pgrep -x openvpn >/dev/null && ip -br link show type tun 2>/dev/null | grep -q UP; then
    echo "%{F#9ece6a} VPN%{F-}"
else
    echo "%{F#565f89} VPN%{F-}"
fi
