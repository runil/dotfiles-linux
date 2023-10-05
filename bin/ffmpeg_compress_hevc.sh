#!/bin/bash
for i in "$@"; do
        ffmpeg \
                -i "$i" \
                -map_chapters -1 \
                -map_metadata -1 \
                -pix_fmt yuv420p \
                -c:v hevc_nvenc \
                -rc:v vbr \
                -b:v 0 \
                -cq:v 28 \
                -preset:v p7 \
                -tune hq \
                -2pass true \
                -c:a copy \
                -f mp4 \
                -y \
                "$i.hevc.mp4"
done
# rm "$i" && \
# mv "$i.hevc.mp4" "$(echo $i | sed 's/\....$/\.mp4/')"
# ffmpeg -i "$i" -map_chapters -1 -map_metadata -1 -pix_fmt yuv420p -c:v hevc_nvenc -rc:v vbr -b:v 0 -cq:v 28 -preset:v p7 -tune hq -2pass true -c:a copy -y "$i.hevc.mp4"
# ffmpeg -y -i "$i" -map_chaptes -1 -map_metadata -1 -pix_fmt yuv420p -c:v hevc_nvenc -rc:v vbr -b:v 0 -cq:v 28 -preset:v p7 -tune hq -2pass true -c:a libopus -b:a 64k -ac 2 -ar 48k "$i.hevc.mp4" && \
