#!/bin/bash

emacs_theme="$(cat "$2/emacs/configs/emacs_theme-$1")"
font="$(cat "$2/emacs/configs/monospace_font-$1")"
emacsclient -e "(apply-theme '$emacs_theme \"$font\")" > /dev/null
