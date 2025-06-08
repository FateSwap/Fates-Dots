#!/usr/bin/env sh

case $BLOCK_BUTTON in
	1) notify-send "🖥 CPU hogs" "$(ps axch -o cmd,%cpu | awk '{cmd[$1]+=$2} END {for (i in cmd) print i, cmd[i]}' | sort -nrk2  | head)\\n(100% per core)" ;;
	2) setsid -f "$TERMINAL" -e btop ;;
	3) notify-send "🖥 CPU module " "\- Shows CPU temperature.
- Click to show intensive processes.
- Middle click to open htop." ;;
	6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

# Get CPU usage using mpstat
CPU_USAGE=$(mpstat 1 1 | tail -1 | awk '{print 100 - $12}')
# Round to the nearest whole number
CPU_USAGE_ROUNDED=$(printf "%.0f" "$CPU_USAGE")
# Ensure the output is a valid number
if [[ $CPU_USAGE_ROUNDED =~ ^[0-9]+$ ]]; then
    echo "CPU ${CPU_USAGE_ROUNDED}%"
else
    echo "CPU N/A"
fi
