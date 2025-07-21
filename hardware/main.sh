#!/bin/bash

openrgb -m breathing -c "$(cat "$2/hardware/configs/hardware_col-$1")"
