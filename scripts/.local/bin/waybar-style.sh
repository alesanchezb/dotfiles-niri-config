#!/bin/bash
# Waybar style switcher (rofi) — niri
# Styles live in ~/.config/waybar/style/, style.css is a symlink
IFS=$'\n\t'

waybar_styles="$HOME/.config/waybar/style"
waybar_style="$HOME/.config/waybar/style.css"
rofi_config="$HOME/.config/rofi/config-waybar-style.rasi"
reload="$HOME/.local/bin/waybar-reload.sh"
msg='🎌 NOTE: Some waybar STYLES NOT fully compatible with some LAYOUTS'

apply_style() {
    ln -sf "$waybar_styles/$1.css" "$waybar_style"
    "$reload"
}

main() {
    current_target=$(readlink -f "$waybar_style")
    current_name=$(basename "$current_target" .css)

    mapfile -t options < <(
        find -L "$waybar_styles" -maxdepth 1 -type f -name '*.css' \
            -exec basename {} .css \; \
            | sort
    )

    default_row=0
    MARKER="👉"
    for i in "${!options[@]}"; do
        if [[ "${options[i]}" == "$current_name" ]]; then
            options[i]="$MARKER ${options[i]}"
            default_row=$i
            break
        fi
    done

    choice=$(printf '%s\n' "${options[@]}" \
        | rofi -i -dmenu \
               -config "$rofi_config" \
               -mesg "$msg" \
               -selected-row "$default_row"
    )

    [[ -z "$choice" ]] && exit 0

    choice=${choice# $MARKER}
    apply_style "$choice"
}

if pgrep -x "rofi" >/dev/null; then
    pkill rofi
fi

main
