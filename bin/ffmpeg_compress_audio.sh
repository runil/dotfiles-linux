#!/bin/bash
for i in "$@"; do
    ffmpeg \
        -i "$i" \
        -map_chapters -1 \
        -map_metadata -1 \
        -pix_fmt yuv420p \
        -c:v copy \
        -c:a libopus \
        -b:a 32k \
        -ac 1 \
        -application voip \
        -f mp4 \
        -y \
        "$i.opus.mp4"
    # rm "$i" && \
    # mv "$i.hevc.mp4" "$(echo $i | sed 's/\....$/\.mp4/')"
done
