This is probably uninteresting without the main waybar configs. Here are mine, adapted from the default:

general.conf

``` json
{
    "hyprland/workspaces": {
        "format": "{icon}",
        "on-scroll-up": "hyprctl dispatch workspace e+1",
        "on-scroll-down": "hyprctl dispatch workspace e-1",
    },
    "hyprland/window": {
        "format": "{}",
        "separate-outputs": true,
        "max-length": 50,
        "rewrite": {
            "(.*) — Mozilla Firefox": "🌎 $1",
            "(.*).py – Doom Emacs": "🐍 $1.py",
            "(.*).tex – Doom Emacs": "φ $1.tex",
            "(.*).bib – Doom Emacs": "🕮 $1.bib",
            "(.*).c – Doom Emacs": "C $1.c",
            "(.*).sh – Doom Emacs": "> $1.sh",
            "(.*).hs – Doom Emacs": "λ $1.hs",
        }
    },
    "hyprland/submap": {
        "format": "<span style=\"italic\">{}</span>"
    },
    "network": {
        "format-wifi": "{essid} ({signalStrength}%) ",
        "format-ethernet": "<span foreground=\"green\">🌐</span>",
        "format-disconnected": "<span foreground=\"red\">🌐</span>",
        "max-length": 50,
        "on-click": "kitty -e 'nmtui'"
    },
    "idle_inhibitor": {
        "format": "{icon}",
        "format-icons": {
            "activated": "",
            "deactivated": ""
        },
		"on-click": "bash /home/dg/.local/bin/toggleRemote"
    },
    "tray": {
        "icon-size": 15,
        "spacing": 10
    },
    "clock": {
        // "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>{:%Y-%m-%d}",
        // "format-alt": "{:%Y-%m-%d}"
		"on-click": "thunderbird"
    },
    "pulseaudio#source": {
        "format": "{format_source}",
        "format-source": "{volume}% ",
        "format-source-muted": "<span foreground=\"black\"></span>",
        "on-click": "pactl set-source-mute @DEFAULT_SOURCE@ toggle",
        "on-click-right": "pavucontrol",
        "on-scroll-down": "pactl set-source-volume @DEFAULT_SOURCE@ -3000",
        "on-scroll-up": "pactl set-source-volume @DEFAULT_SOURCE@ +3000"
    },
    "pulseaudio#sink": {
        "format": "{volume}% {icon} ",
        "format-bluetooth": "{volume}% {icon} {format_source}",
        "format-bluetooth-muted": "<span foreground=\"black\"> {icon} {format_source}</span>",
        "format-muted": "<span foreground=\"black\">0% {icon}</span>",
        "format-icons": {
            "headphone": "",
            "hands-free": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", "", ""]
        },
        "on-click": "pactl set-sink-mute @DEFAULT_SINK@ toggle",
        "on-click-right": "pavucontrol",
        "on-scroll-down":"pactl set-sink-volume @DEFAULT_SINK@ -3000",
        "on-scroll-up":"pactl set-sink-volume @DEFAULT_SINK@ +3000"
    },
	"custom/power": {
		"format": " ",
		"on-click": "swaynag -t warning -m 'Power Menu Options' -b 'Logout' 'swaymsg exit' -b 'Restart' 'shutdown -r now' -b 'Shutdown'  'shutdown -h now' --background=#005566 --button-background=#009999 --button-border=#002b33 --border-bottom=#002b33"
	},
    "custom/scratchpad-indicator": {
        "format-text": "{}hi",
        "return-type": "json",
        "interval": 3,
        "exec": "~/.local/bin/scratchpad-indicator 2> /dev/null",
        "exec-if": "exit 0",
        "on-click": "swaymsg 'scratchpad show'",
        "on-click-right": "swaymsg 'move scratchpad'"
    },
    "reload_style_on_change": true,
}
```

This is then included into seperate layouts for different screens, so that they can be turned on or off without affecting the one on the other screens.
