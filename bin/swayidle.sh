#!/bin/sh
exec /usr/bin/swayidle -w \
    timeout 10 'if pgrep -x swaylock; then brightnessctl --save; brightnessctl set 5%; fi' \
        resume 'if pgrep -x swaylock; then brightnessctl --restore; fi' \
    timeout 25 'if pgrep -x swaylock; then swaymsg output "*" dpms off; fi' \
        resume 'if pgrep -x swaylock; then swaymsg output "*" dpms on; fi' \
    timeout 60 'if pgrep -x swaylock; then [ "$(cat /sys/class/power_supply/AC*/online | head)" -eq 0 ] && systemctl suspend; fi' \
    timeout 300 'brightnessctl --save; brightnessctl set 5%' \
        resume 'brightnessctl --restore' \
    timeout 600 '~/.config/sway/scripts/swaylock.sh' \
    timeout 610 'swaymsg output "*" dpms off' \
        resume 'swaymsg output "*" dpms on' \
    timeout 900 'systemctl suspend' \
    before-sleep '~/.config/sway/scripts/swaylock.sh'
