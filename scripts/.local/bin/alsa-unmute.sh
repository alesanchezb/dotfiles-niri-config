#!/bin/bash
# Re-apply SOF codec mixer state lost when WirePlumber re-creates the ALSA device (pro-audio profile)

for _ in $(seq 1 50); do
  amixer -c 0 sset 'Speaker' unmute 2>/dev/null && break
  sleep 0.2
done
amixer -c 0 sset 'Speaker' unmute
amixer -c 0 sset 'Headphone' unmute
amixer -c 0 cset numid=1 87
amixer -c 0 cset numid=3 87
amixer -c 0 cset numid=8 1
