#!/usr/bin/env bash

swww init &
swww img /home/tominix/.config/hypr/wallpapers/1.jpg &

nm-applet --indicator &
pa-applet --indicator &

waybar &

mako &
