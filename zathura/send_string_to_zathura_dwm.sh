#!/bin/bash

# somehow find all zathura windows I guess
# select window with
pids=$(pidof zathura)
if [[ $pids = "" ]]; then
    exit 0
fi

echo $pids

for pid in $pids; do
    wm_line="$(wmctrl -l -p -G | grep $pid)"
    zathura_window=$(echo "$wm_line" | awk '{print $1;}')
    xdotool windowactivate "$zathura_window"
    xdotool key --clearmodifiers colon
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
        xdotool key --clearmodifiers $c
    done
    xdotool key --clearmodifiers Return
done

