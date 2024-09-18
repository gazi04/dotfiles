#!/bin/bash

# Options for powermenu
shutdown="  Shutdown"
reboot="  Reboot"
lock="  Lock"
suspend="  Suspend"
logout="  Logout"

# Get user choice using rofi
selected_option=$(echo -e "$shutdown\n$reboot\n$lock\n$suspend\n$logout" | rofi -dmenu -i -p "Power Menu:")

# Take action based on selected option
case $selected_option in
  "$shutdown")
    systemctl poweroff
    ;;
  "$reboot")
    systemctl reboot
    ;;
  "$lock")
    betterlockscreen -l
    ;;
  "$suspend")
    systemctl suspend
    betterlockscreen -l
    ;;
  "$logout")
    i3-msg exit
    ;;
  *)
    ;;
esac
