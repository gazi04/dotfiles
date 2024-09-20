# #!/bin/bash
#
# get_spotify_status() {
#   status=$(playerctl --player=spotify status 2>/dev/null)
#
#   if [ $? -eq 0 ]; then
#     if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
#       artist=$(playerctl --player=spotify metadata artist)
#       title=$(playerctl --player=spotify metadata title)
#       echo "$artist - $title"
#     else
#       echo "Spotify is stopped"
#     fi
#   fi
# }
#
# # Initial call
# get_spotify_status
#
# # Listen for changes
# playerctl --player=spotify metadata --follow | while read -r line; do
#   get_spotify_status
# done


#!/bin/bash

get_spotify_status() {
  if pgrep -x "spotify" > /dev/null; then
    status=$(playerctl --player=spotify status 2>/dev/null)

    if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
      artist=$(playerctl --player=spotify metadata artist)
      title=$(playerctl --player=spotify metadata title)
      echo "$artist - $title"
    else
      echo "Spotify is stopped"
    fi
  else
    echo ""
  fi
}

# Initial call
get_spotify_status

# Continuously monitor Spotify status
while true; do
  if ! pgrep -x "spotify" > /dev/null; then
    echo ""
  else
    get_spotify_status
  fi
  sleep 1
done

