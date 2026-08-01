#!/bin/bash
# Random wallpaper — niri + swww

wallDIR="$HOME/Pictures/wallpapers"

PICS=($(find -L "$wallDIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.gif' -o -iname '*.bmp' -o -iname '*.tiff' \)))
if [[ ${#PICS[@]} -eq 0 ]]; then
    notify-send "Wallpaper" "No wallpapers found in $wallDIR"
    exit 1
fi

RANDOMPICS=${PICS[$((RANDOM % ${#PICS[@]}))]}

if ! pgrep -x "swww-daemon" >/dev/null; then
    swww-daemon &
    sleep 1
fi

swww img "$RANDOMPICS" --transition-fps 60 --transition-type random --transition-duration 1
