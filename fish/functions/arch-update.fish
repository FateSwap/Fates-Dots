function arch-update --wraps='sudo pacman -Syyu && figlet Done!' --description 'alias arch-update=sudo pacman -Syyu && figlet Done!'
  sudo pacman -Syyu && figlet Done! $argv
        
end
