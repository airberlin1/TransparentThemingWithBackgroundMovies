#!/bin/bash


THEMING_DIR="$HOME/ThemingForHyprland"



theme=$1

configured_apps="$(cat "$THEMING_DIR/theming.conf.d/configured_apps.conf")"


for app_to_be_themed in $configured_apps; do
    $THEMING_DIR/$app_to_be_themed/main.sh "$theme" "$THEMING_DIR"
done

echo $theme > $THEMING_DIR/current_theme
