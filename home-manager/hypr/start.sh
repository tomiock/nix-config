#!/usr/bin/env bash

nm-applet --indicator &
pa-applet --indicator &

swaybg --image "${HOME}/.config/hypr/wallpapers/3.jpg" --mode fill &

waybar &

mako &
