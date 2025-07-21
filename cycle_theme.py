#!/usr/bin/python3

"""cycles to the next theme"""
from subprocess import call
import os

THEMING_DIR = f"{os.environ["HOME"]}/ThemingForHyprland"


themes = []
with open(f"{THEMING_DIR}/loaded_themes", "r") as fp:
    for line in fp.readlines():
        themes.append(line.strip())

with open(f"{THEMING_DIR}/current_theme", "r") as fp:
    cur_theme = fp.read().strip()

curi = themes.index(cur_theme)
if curi == len(themes) - 1:
    i = 0
else:
    i = curi + 1

call([f"{THEMING_DIR}/apply_theme.sh", themes[i]])
