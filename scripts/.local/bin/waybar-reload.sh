#!/bin/bash
# Reload waybar config + style
if pgrep -x waybar >/dev/null; then
    pkill -SIGUSR2 waybar
else
    waybar &
fi
