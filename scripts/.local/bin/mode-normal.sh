#!/bin/bash
# Restore default mode: standard waybar + standard niri config

pkill waybar
waybar &

niri msg action load-config-file --path ~/.config/niri/config.kdl
