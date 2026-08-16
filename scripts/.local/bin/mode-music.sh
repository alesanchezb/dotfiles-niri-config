#!/bin/bash
# Music mode: launch YTMDesktop (binary: youtube-music-desktop-app)

if ! pgrep -f "youtube-music-desktop-app" > /dev/null; then
    youtube-music-desktop-app &
fi
