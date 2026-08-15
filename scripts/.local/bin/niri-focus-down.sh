#!/bin/bash
before_ws=$(niri msg -j workspaces | jq '[.[] | select(.is_focused==true)][0].id')
before_win=$(niri msg -j windows | jq '[.[] | select(.is_focused==true)][0].id')

niri msg action focus-window-or-workspace-down

after_ws=$(niri msg -j workspaces | jq '[.[] | select(.is_focused==true)][0].id')
after_win=$(niri msg -j windows | jq '[.[] | select(.is_focused==true)][0].id')

if [ "$before_ws" == "$after_ws" ] && [ "$before_win" == "$after_win" ]; then
    niri msg action focus-monitor-down
fi
