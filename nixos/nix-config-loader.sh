#! /usr/bin/env sh

# This script is designed to be run on NixOS with MY extension-list seen in my config

# Variables
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Makes the void and git directories
if [ ! -d ~/Void/Git/ ]; then
    echo "Creating Void..."
    mkdir -p ~/Void/Git/
else
    echo "Void already exists | Continuing..."
fi

# cp configs to correct area
cp -r /nvim/ ~/.config/
cp -r /fish/ ~/.config/
cp -r /alacritty/ ~/.config/
cp -r /hypr/ ~/.config/
cp -r /bspwm/ ~/.config/
cp -r /sxhkd/ ~/.config/
cp -r /kitty/ ~/.config/

# Sets theme to dark
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Wallpapers
./wallpapers.sh

# Sets wallpaper in GNOME SPECIFICALLY
gsettings set org.gnome.desktop.background picture-uri file:///home/spaceman/Void/Git/Walls/Wallpapers/Anime/lo-fi-sailor-moon.gif

# Enables MY GNOME extensions | Extensions installed via nix config
gnome-extensions enable "user-theme@gnome-shell-extensions.gcampax.github.com"
gnome-extensions enable "blur-my-shell@aunetx"
gnome-extensions enable "desktop-cube@schneegans.github.com"
gnome-extensions enable "logomenu@aryan_k"
gnome-extensions enable "dash-to-dock@micxgx.gmail.com"
gnome-extensions enable "compiz-windows-effect@hermes83.github.com"
gnome-extensions enable "compiz-alike-magic-lamp-effect@hermes83.github.com"
gnome-extensions enable "extension-list@tu.berry"
gnome-extensions enable "system-monitor@gnome-shell-extensions.gcampax.github.com"
gnome-extensions enable "freon@UshakovVasilii_Github.yahoo.com"
gnome-extensions enable "appindicatorsupport@rgcjonas.gmail.com"
gnome-extensions enable "impatience@gfxmonk.net"
gnome-extensions enable "just-perfection-desktop@just-perfection"
gnome-extensions enable "mediacontrols@cliffniff.github.com"
gnome-extensions enable "top-bar-organizer@julian.gse.jsts.xyz"
gnome-extensions enable "quick-settings-avatar@d-go"

# Adds flathub to flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Script done 
exit 1



