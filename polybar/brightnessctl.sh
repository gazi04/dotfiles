#!/bin/bash

BRIGHTNESS_VALUE=$(brightnessctl | grep -o "(.*" | tr -d "()")
BRIGHTNESS_NR=${BRIGHTNESS_VALUE//%}
  
if [ $BRIGHTNESS_NR -lt 5 ]; then
  brightnessctl set 5%
  BRIGHTNESS_NR=5
  BRIGHTNEES_VALUE="5%"
fi 


if [ $BRIGHTNESS_NR -lt 20 ]; then
  BRIGHTNESS_ICON='🌒'
elif [ $BRIGHTNESS_NR -lt 50 ]; then
  BRIGHTNESS_ICON='🌓'
elif [ $BRIGHTNESS_NR -lt 80 ]; then
  BRIGHTNESS_ICON='🌔'
else
  BRIGHTNESS_ICON='🌕'
fi 


if [ $BRIGHTNESS_NR -lt 20 ]; then
  BRIGHTNESS_ICON='🌑'
fi

echo "$BRIGHTNESS_ICON $BRIGHTNESS_VALUE"
