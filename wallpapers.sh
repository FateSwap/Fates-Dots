#! /usr/bin/env sh

# Checks if gits installed | taken from https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
if ! command -v git 2>&1 >/dev/null
then
    echo "git could not be found or is not installed | Please install git and retry"
    exit 1
fi

# Checks if figlets installed | taken from same as above
if ! command -v figlet 2>&1 >/dev/null
then
    echo "figlet could not be found or is not installed | Please install figlet and retry"
    exit 1
fi

# Checks if correct directories exist | taken from https://linuxsimply.com/bash-scripting-tutorial/conditional-statements/if/check-if-directory-exists/
# Also checks if user wants to create it | taken from https://www.geeksforgeeks.org/bash-script-read-user-input/ & https://unix.stackexchange.com/questions/47584/in-a-bash-script-using-the-conditional-or-in-an-if-statement#47585
if [ -d ~/Void/Git/Walls/ ]; then
  echo "Walls directory exists. Script continuing"
  # Clones wallpaper repos
  cd ~/Void/Git/Walls/ && git clone https://github.com/FrenzyExists/wallpapers
  cd ~/Void/Git/Walls/ && git clone https://github.com/AngelJumbo/gruvbox-wallpapers
  cd ~/Void/Git/Walls/ && git clone https://github.com/dracula/wallpaper.git
  figlet Done
  echo "Wallpapers have been cloned | All walls at  ~/Void/Git/Walls/"
else
  read -p "Directory doesn't exist. Would you like to create it? ~/Void/Git/Walls/: " choice
  if [[ "$choice" == "y" || "$choice" == "Y" || "$choice" == "Yes" || "$choice" == "yes" ]]; then
      # Creates directory then continues
      echo -e "\nCreating the needed directories..."
      mkdir -p ~/Void/Git/Walls/
      echo -e "\nDirectories has been created | Continuing..."
      # Clones wallpaper repos
      cd ~/Void/Git/Walls/ && git clone https://github.com/FrenzyExists/wallpapers
      cd ~/Void/Git/Walls/ && git clone https://github.com/AngelJumbo/gruvbox-wallpapers
      cd ~/Void/Git/Walls/ && git clone https://github.com/dracula/wallpaper.git
      figlet Done
      echo "Wallpapers have been cloned | All walls at  ~/Void/Git/Walls/"
  else
    # Exits if user choses not to create 
    echo -e "\nExiting Program as theres no directory to clone to..."
    exit 1
  fi
fi

