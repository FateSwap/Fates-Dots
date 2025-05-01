function rebuild-test --wraps='sudo nixos-rebuild test' --description 'alias rebuild-test=sudo nixos-rebuild test'
  sudo nixos-rebuild test $argv
        
end
