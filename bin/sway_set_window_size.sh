#!/bin/bash
x=$(rofi -dmenu -l 10 -p "Select X Pixels:") && \
y=$(rofi -dmenu -l 10 -p "Select Y Pixels:") && \
i3-msg resize set $x $y
