#!/bin/bash

dir=$1

setxkbmap -layout fi
setxkbmap -option ctrl:nocaps
# Note: no whitespace allowed after option flag
setxkbmap -I"$dir" prog -print | xkbcomp -I"$dir" - $DISPLAY
