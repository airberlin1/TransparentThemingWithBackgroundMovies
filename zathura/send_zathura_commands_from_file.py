#!/usr/bin/python3

from subprocess import PIPE, run
from sys import argv
from time import sleep

def main():
    if len(argv) < 3:
        print("not enough arguments")
        exit()
    with open(argv[1], "r") as fp:
        lines = fp.readlines()
    wm = run([f"{argv[2]}/get_general_config.py", "window_manager", argv[2]], capture_output=True).stdout
    wm = str(wm.strip(), "utf-8")
    for line in lines:
        run([f"{argv[2]}/zathura/send_string_to_zathura_{wm}.sh", line])


if __name__ == "__main__":
    main()
