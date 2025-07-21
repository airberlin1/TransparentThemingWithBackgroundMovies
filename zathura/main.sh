#!/bin/bash

cp "$2/zathura/configs/style-$1" "$HOME/.config/zathura/zathurarc"

"$2/zathura/send_zathura_commands_from_file.py" "$2/zathura/configs/recolor_commands-$1" "$2"
