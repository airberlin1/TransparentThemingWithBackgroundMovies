#!/usr/bin/python3

"""applies a random theme"""
from subprocess import call
import random
import os
from time import sleep
from sys import argv


THEMING_DIR = f"{os.environ["HOME"]}/ThemingForHyprland"


themes = []
with open("/home/air_berlin/Theme/loaded_themes", "r") as fp:
    for line in fp.readlines():
        themes.append(line.strip())

with open("/home/air_berlin/Theme/current_theme", "r") as fp:
    cur_theme = fp.read().strip()


if len(argv) > 1:
    sleep(5)
call(["ntfy", "publish", "theme54otaohdo46464oor", random.choice(themes)])

#, stdout=open(os.devnull, 'wb'), stderr=open(os.devnull, 'wb'))
