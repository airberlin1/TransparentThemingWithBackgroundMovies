#!/bin/bash


monitor_list="$("$2/get_general_config.py" displays "$2")"
movie_list="$(cat "$2/background/configs/movies-$1")"

# the lists are seperated by commas and not space, so let's convert them
IFS=',' read -ra monitor_list <<< "$monitor_list"
IFS=',' read -ra movie_list <<< "$movie_list"

monitor_list=("${monitor_list[@]}")
movie_list=("${movie_list[@]}")

# remove leading and trailing whitespaces from elements
for (( i=0; i<${#monitor_list[@]}; i++ )); do
    monitor_list[$i]="${monitor_list[$i]## }"
    monitor_list[$i]="${monitor_list[$i]%% }"
done
for (( i=0; i<${#movie_list[@]}; i++ )); do
    movie_list[$i]="${movie_list[$i]## }"
    movie_list[$i]="${movie_list[$i]%% }"
done


wm=$("$2/get_general_config.py" window_manager "$2")
if [[ $wm = "hyprland" ]]; then
    mpv_pids="$(pidof mpvpaper)"
    for (( i=0; i<${#monitor_list[@]}; i++ )); do
        nohup mpvpaper -f -o "no-audio --loop" "${monitor_list[i]}" "$("$2/get_general_config.py" movie_base_dir "$2")/${movie_list[i]}"
    done
    kill $mpv_pids
elif [[ $wm = "dwm" ]]; then
    # maybe use https://github.com/glouw/paperview
    echo ""
fi
