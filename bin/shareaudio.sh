#!/bin/sh

latency_ms=100

DEFAULT_SOURCE=$(pactl info | grep "Default Source:" | sed 's/Default Source: //g')
DEFAULT_SINK=$(pactl info | grep "Default Sink:" | sed 's/Default Source: //g')

INDICES=(0)

echo -n "recording sink: "
INDICES[0]=$(pactl load-module module-null-sink sink_name=recording sink_properties=device.description=recording)

echo -n "combined sink: "
INDICES[1]=$(pactl load-module module-null-sink sink_name=combined sink_properties=device.description=combined)

echo -n "recording -> combined loopback: "
INDICES[2]=$(pactl load-module module-loopback source=recording.monitor sink=combined latency_msec="$latency_ms")

echo -n "DEFAULT mic -> combined loopback: "
INDICES[3]=$(pactl load-module module-loopback source="$DEFAULT_SOURCE" sink=combined latency_msec="$latency_ms")

echo -n "recording -> headphones loopback: "
INDICES[4]=$(pactl load-module module-loopback source=recording.monitor sink="$DEFAULT_SINK" latency_msec=$latency_ms)

echo -n "combined -> virtual device remap: "
INDICES[5]=$(pactl load-module module-remap-source source_name=combined-virtual master=combined.monitor)

set-default-source combined.monitor
sleep 1
pavucontrol

#read -rsp $'Press enter to continue...\n'
#for i in $(pactl list modules short | grep -Po "^[0-9]{9}"); do pactl unload-module $i; done
#read -rsp $'Press enter to continue...\n'
#echo -n "Deleting modules..."
for i in ${INDICES[@]}; do pactl unload-module $i; done
