#!/bin/bash

# Set a random wallpaper from the backgrounds directory
WALLPAPER=$(find ~/.config/i3/backgrounds -type f | shuf -n 1)

# Set the wallpaper with feh
feh --bg-fill "$WALLPAPER"

# Update Betterlockscreen with the new wallpaper
betterlockscreen -u "$WALLPAPER"
