# Check if picom is running
pidof picom >/dev/null 2>&1
if [ $? -eq 0 ]; then
    # Terminate the process
    notify-send "picom stopped"
    killall picom
else
    # run picom
    notify-send "picom started"
    picom -b --config $HOME/.config/i3/picom.conf
fi
