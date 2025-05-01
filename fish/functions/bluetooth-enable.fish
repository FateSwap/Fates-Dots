function bluetooth-enable --wraps='sudo systemctl enable bluetooth && sudo systemctl start bluetooth' --description 'alias bluetooth-enable=sudo systemctl enable bluetooth && sudo systemctl start bluetooth'
  sudo systemctl enable bluetooth && sudo systemctl start bluetooth $argv
        
end
