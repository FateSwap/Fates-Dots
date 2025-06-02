#! /usr/bin/env sh

# Uses wpctl ( Pipewire ) to decrease vol by 5%
wpctl set-volume @DEFAULT_SINK@ .05-

# Script exit
exit 1
