#!/usr/bin/env sh
# Get RAM usage
RAM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
# Round to the nearest whole number
RAM_USAGE_ROUNDED=$(printf "%.0f" "$RAM_USAGE")
# Ensure the output is a valid number
if [[ $RAM_USAGE_ROUNDED =~ ^[0-9]+$ ]]; then
    echo "RAM ${RAM_USAGE_ROUNDED}%"
else
    echo "RAM N/A"
fi

