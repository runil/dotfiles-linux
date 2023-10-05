#!/bin/bash
mpv --no-video "$(find ~/files/music -type f | fzf --multi --layout=reverse)"
