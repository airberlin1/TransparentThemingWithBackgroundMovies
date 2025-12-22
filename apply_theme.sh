#!/bin/bash


THEMING_DIR="$HOME/ThemingForHyprland"

if [[ $1 = "from_server" ]]; then
    theme="$(curl https://lassesperling.de/theming/gmrorseno64/)"
else
    theme="$1"
fi

if [[ $($THEMING_DIR/theme_is_known "$theme") = 0 ]]; then
    exit -1
fi

configured_apps="$(cat "$THEMING_DIR/theming.conf.d/configured_apps.conf")"


for app_to_be_themed in $configured_apps; do
    $THEMING_DIR/$app_to_be_themed/main.sh "$theme" "$THEMING_DIR"
done

echo $theme > $THEMING_DIR/current_theme
