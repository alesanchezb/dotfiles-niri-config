#!/bin/bash
# Dev mode: launch editor + terminal

alacritty &
emacsclient -c . &
