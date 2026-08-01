#!/bin/bash
# Gaming mode: minimal waybar, no gaps/focus-ring/animations

pkill waybar
waybar -c ~/.config/waybar/configs/config-gaming.jsonc &

niri msg action load-config-file --path ~/.config/niri/modes/gaming.kdl
