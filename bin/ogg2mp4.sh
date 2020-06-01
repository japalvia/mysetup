#!/bin/bash

ffmpeg -i "$1" \
   -c:v libx264 -preset veryslow -crf 22 \
   -c:a aac -b:a 160k -strict -2 \
   "$2"
