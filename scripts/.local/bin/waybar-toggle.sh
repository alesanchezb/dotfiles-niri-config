#!/bin/bash
# Toggle waybar on/off
if pgrep -x waybar >/dev/null; then
    pkill waybar
else
    waybar &
fi
