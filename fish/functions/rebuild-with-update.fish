function rebuild-with-update --wraps='sudo nixos-rebuild switch --upgrade' --description 'alias rebuild-with-update=sudo nixos-rebuild switch --upgrade'
  sudo nixos-rebuild switch --upgrade $argv
        
end
