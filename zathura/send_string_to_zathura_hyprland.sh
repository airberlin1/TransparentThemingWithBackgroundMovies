#!/bin/bash



length=$(hyprctl -j clients | jq '. | length')
for ((i=0; i<length; i++)); do
    if [[ $(hyprctl -j clients | jq -r ".[$i].class") = "org.pwmt.zathura" ]]; then
        hyprctl dispatch sendshortcut ,Escape,address:$(hyprctl -j clients | jq -r ".[$i].address") -q
        hyprctl dispatch sendshortcut Shift,semicolon,address:$(hyprctl -j clients | jq -r ".[$i].address") -q
        for j in $(seq 0 $((${#1} - 1))); do
            c="${1:j:1}"
            if [[ $c = "," ]]; then
                c="comma"
            fi
            if [[ $c = " " ]]; then
                c="space"
            fi
            if [[ $c = "(" ]]; then
                c="parenleft"
            fi
            if [[ $c = ")" ]]; then
                c="parenright"
            fi
            if [[ $c = "\"" || $c = "'" ]]; then
                c="apostrophe"
            fi
            if [[ $c = "-" ]]; then
                c="minus"
            fi
            if [[ $c = "." ]]; then
                c="period"
            fi
            hyprctl dispatch sendshortcut ,$c,address:$(hyprctl -j clients | jq -r ".[$i].address") -q
        done
        hyprctl dispatch sendshortcut ,Return,address:$(hyprctl -j clients | jq -r ".[$i].address") -q
    fi
done
