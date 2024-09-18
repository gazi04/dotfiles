#!/bin/bash

# Check if any media player is playing
if playerctl status 2>/dev/null | grep -q "Playing"; then
    # Reset the screen saver timer to prevent locking
    echo "Media is playing , resetting screen saver timer."
    xset s reset
else
  echo "No media playing "
fi

