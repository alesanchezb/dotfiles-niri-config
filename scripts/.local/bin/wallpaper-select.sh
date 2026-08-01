#!/bin/bash
# Wallpaper selector (rofi grid) — niri + swww
# Based on JaKooLit's WallpaperSelect.sh, adapted for niri

wallDIR="$HOME/Pictures/wallpapers"
rofi_theme="$HOME/.config/rofi/config-wallpaper.rasi"

FPS=60
TYPE="any"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

mapfile -d '' PICS < <(find -L "${wallDIR}" -type f \( \
    -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o \
    -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" \) -print0)

if [[ ${#PICS[@]} -eq 0 ]]; then
    notify-send "Wallpaper" "No wallpapers found in $wallDIR"
    exit 1
fi

RANDOM_PIC="${PICS[$((RANDOM % ${#PICS[@]}))]}"
RANDOM_PIC_NAME=". random"

rofi_command="rofi -i -dmenu -config $rofi_theme"

menu() {
    IFS=$'\n' sorted_options=($(sort <<<"${PICS[*]}"))

    printf "%s\x00icon\x1f%s\n" "$RANDOM_PIC_NAME" "$RANDOM_PIC"

    for pic_path in "${sorted_options[@]}"; do
        pic_name=$(basename "$pic_path")
        printf "%s\x00icon\x1f%s\n" "$(echo "$pic_name" | cut -d. -f1)" "$pic_path"
    done
}

apply() {
    if ! pgrep -x "swww-daemon" >/dev/null; then
        swww-daemon &
        sleep 1
    fi
    swww img "$1" $SWWW_PARAMS
}

main() {
    choice=$(menu | $rofi_command)
    choice=$(echo "$choice" | xargs)
    RANDOM_PIC_NAME=$(echo "$RANDOM_PIC_NAME" | xargs)

    [[ -z "$choice" ]] && exit 0

    if [[ "$choice" == "$RANDOM_PIC_NAME" ]]; then
        apply "$RANDOM_PIC"
        exit 0
    fi

    choice_basename=$(basename "$choice" | sed 's/\(.*\)\.[^.]*$/\1/')
    selected_file=$(find "$wallDIR" -iname "$choice_basename.*" -print -quit)

    if [[ -z "$selected_file" ]]; then
        notify-send "Wallpaper" "File not found: $choice"
        exit 1
    fi

    apply "$selected_file"
}

if pgrep -x "rofi" >/dev/null; then
    pkill rofi
fi

main
