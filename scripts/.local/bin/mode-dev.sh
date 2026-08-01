#!/bin/bash
# Dev mode: default waybar, launch editor + terminal

pkill waybar
waybar &

alacritty &
emacsclient -c . &
