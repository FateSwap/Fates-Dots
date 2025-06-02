#! /usr/bin/env sh

# Uses wpctl ( Pipewire ) to mute vol with toggling
wpctl set-mute @DEFAULT_SINK@ toggle

# Script exit
exit 1
