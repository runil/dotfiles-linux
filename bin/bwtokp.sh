#!/bin/bash
BW_SESSION=$(cat ~/.bwsession)
BW_PATH=$(which bw)
ARCHIVE_PATH=$HOME/files/documents/bitwarden.kdbx
BWTOKPPATH=$HOME/awesome/bitwarden-to-keepass
DATABASE_PATH=$HOME/files/documents/.bitwarden_$(date +"%Y%m%d_%H%M%S").kdbx
bw sync --session $BW_SESSION
DATABASE_PASSWORD=$(bw get password bwtokp --session $BW_SESSION)
source $BWTOKPPATH/.venv/bin/activate
python3 $BWTOKPPATH/bitwarden-to-keepass.py --database-path $DATABASE_PATH --database-password $DATABASE_PASSWORD --bw-session $BW_SESSION --bw-path $BW_PATH
cp -a $DATABASE_PATH $ARCHIVE_PATH