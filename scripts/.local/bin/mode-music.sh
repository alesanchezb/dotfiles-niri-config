#!/bin/bash
# Music mode: launch YTMDesktop

if ! pgrep -f "YTMDesktop" > /dev/null; then
    ytmdesktop &
fi
