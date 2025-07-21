#!/bin/bash

# this will likely not see a dwm equivalent

wm=$("$2/get_general_config.py" window_manager "$2")
if [[ $wm = "hyprland" ]]; then
    hyprctl keyword general:col.active_border "$(cat "$2/hyprland_border/configs/light-$1")" "$(cat "$2/hyprland_border/configs/dark-$1")"
fi
