#!/bin/bash

cp "$2/kitty/configs/kitty_config-$1" "$HOME/.config/kitty/kitty.conf"

wm=$("$2/get_general_config.py" window_manager "$2")
if [[ $wm = "hyprland" ]]; then
    length=$(hyprctl -j clients | jq '. | length')
    for ((i=0; i<length; i++)); do
        if [[ $(hyprctl -j clients | jq -r ".[$i].class") = "kitty" ]]; then
            hyprctl dispatch sendshortcut Control+Shift,F5,address:$(hyprctl -j clients | jq -r ".[$i].address")
        fi
    done
elif [[ $wm = "dwm" ]]; then
    # something xdotool send F5 everywhere
    echo ""
fi
