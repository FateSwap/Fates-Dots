function system-edit --wraps='sudo -e /etc/nixos/configuration.nix' --description 'alias system-edit=sudo -e /etc/nixos/configuration.nix'
  sudo -e /etc/nixos/configuration.nix $argv
        
end
