#!/usr/bin/python

import sys
from os.path import join


def main():
    setting_to_get = sys.argv[1]
    config_file = join(sys.argv[2], "theming.conf.d/general.conf")

    with open(config_file, "r") as fp:
        lines = fp.readlines()
    for line in lines:
        if line[:len(setting_to_get)] == setting_to_get:
            print(line.split(":")[1].strip())
            return
    print("Error finding setting.")


if __name__ == '__main__':
    main()
