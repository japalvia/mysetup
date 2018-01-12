#!/bin/bash

set -e

# Read xrandr display state and check if laptop display has geometry specified,
# i.e. it is enabled
value=$(xrandr | awk '/LVDS1 connected primary/ { print $4}')

# Geometry is in format: 1600x900+0+0
geometry="[[:digit:]]+x[[:digit:]]+\+[[:digit:]]+\+[[:digit:]]+"

if egrep -q "$geometry" <<< $value ; then
    xrandr --output HDMI1 --auto --output LVDS1 --off
else
    xrandr --output HDMI1 --auto --output LVDS1 --auto
fi

