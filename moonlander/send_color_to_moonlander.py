#!/usr/bin/python3

import hid
import sys

# USB IDs
VID = 0x3297
PID = 0x1969

def send_rgb(r, g, b):
    for d in hid.enumerate(0x3297, 0x1969):
        # there are multiple parts of the keyboard that accept hid, we should choose the one that listens to our raw hid
        if d['usage_page'] in (0xff60, 0xff00):
            with hid.Device(path=d['path']) as dev:
                dev.nonblocking = 1
                data = [r, g, b]
                # the first bit should not be necessary like that, but we only read from the second bit on so...
                dev.write(bytes([0xff] + data + ([0x00] * 28) ))


def individual_color_from_hex(h):
    return int(h, 16)


def convert_from_hex(h):
    return [individual_color_from_hex(h[1+2 * i:3+2*i]) for i in range(3)]


def main():
    if sys.argv[1][0] == "#":
       r, g, b = convert_from_hex(sys.argv[1])
       send_rgb(r, g, b)


if __name__ == "__main__":
    main()
