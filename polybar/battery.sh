#!/bin/bash

# Get the battery percentage
battery_level=$(cat /sys/class/power_supply/BAT1/capacity)

# Check if the battery level is below 30%
if [ "$battery_level" -lt 30 ]; then
    # Send a notification using dunst
    notify-send "Battery Low ⚠️" "Battery level is at ${battery_level}%." -u critical
    # Output with red font color
    echo "%{F#f38ba8}  ${battery_level}%{F-}"
else
    # Output with default font color
    echo "  ${battery_level}%"
fi
