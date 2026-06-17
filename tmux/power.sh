#!/usr/bin/env bash
# Battery/power indicator for the tmux statusline.
#
# `energy-rate` is the battery charge/discharge rate, so it reads 0 W whenever
# the battery is full and on AC. In that case showing "0.00W" is just noise, so
# we fall back to the plug icon + charge %. One upower call (DisplayDevice
# aggregates all batteries).

upower -i /org/freedesktop/UPower/devices/DisplayDevice 2>/dev/null | awk '
  /state:/       { state = $2 }
  /energy-rate:/ { rate  = $2 }
  /percentage:/  { pct   = $2 }
  END {
    if (rate + 0 > 0) {
      emoji = (state == "charging") ? "⚡" : "🔋"
      printf "%s %.2fW", emoji, rate
    } else {
      printf "🔌 %s", pct
    }
  }'
