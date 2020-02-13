#!/bin/bash

usage() {
    cat >&2 <<EOF
xkb loader usage:
$0 [directory]
    where directory is the location for kxb layout files
    (i.e. directory must contain 'symbols' subdirectory).
    Default is the location of this script file.
EOF
}

bad_usage() {
    printf 'ERROR: %s\n' "$1" >&2
    usage
    exit 1
}

dir=$1
[ -z "$dir" ] && dir=$(dirname $(readlink -f $0))

setxkbmap -layout fi
setxkbmap -option ctrl:nocaps
setxkbmap -I"$dir" prog -print | xkbcomp -w 3 -I"$dir" - $DISPLAY
