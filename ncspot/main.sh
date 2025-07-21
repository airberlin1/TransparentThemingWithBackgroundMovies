#!/bin/bash

cp "$2/ncspot/configs/ncspot_conf-$1" "$HOME/.config/ncspot/config.toml"

wm=$("$2/get_general_config.py" window_manager "$2")
if [[ $wm = "hyprland" ]]; then
    hyprctl dispatch sendshortcut Control,j,title:Spotify
elif [[ $wm = "dwm" ]]; then
    echo ""
fi
