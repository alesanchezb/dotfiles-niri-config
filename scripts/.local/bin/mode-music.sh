#!/bin/bash
# Music mode: media-focused waybar, launch YTMDesktop

pkill waybar
waybar -c ~/.config/waybar/configs/config-music.jsonc &

if ! pgrep -f "YTMDesktop" > /dev/null; then
    ytmdesktop &
fi
