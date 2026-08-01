#!/bin/bash
# Waybar layout switcher (rofi) — niri
# Layouts live in ~/.config/waybar/configs/, config is a symlink
IFS=$'\n\t'

waybar_layouts="$HOME/.config/waybar/configs"
waybar_config="$HOME/.config/waybar/config"
rofi_config="$HOME/.config/rofi/config-waybar-layout.rasi"
reload="$HOME/.local/bin/waybar-reload.sh"
msg='🎌 NOTE: Some waybar LAYOUT NOT fully compatible with some STYLES'

apply_config() {
    ln -sf "$waybar_layouts/$1" "$waybar_config"
    "$reload"
}

main() {
    current_target=$(readlink -f "$waybar_config")
    current_name=$(basename "$current_target")

    mapfile -t options < <(
        find -L "$waybar_layouts" -maxdepth 1 -type f -printf '%f\n' | sort
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

    case "$choice" in
        "no panel")
            pgrep -x "waybar" && pkill waybar || true
            ;;
        *)
            apply_config "$choice"
            ;;
    esac
}

if pgrep -x "rofi" >/dev/null; then
    pkill rofi
fi

main
