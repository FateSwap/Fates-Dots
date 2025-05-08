function clone-my-repo --wraps='cd ~/Void/Git/ && git clone https://github.com/FateSwap/Fates-Dots && cd -' --description 'alias clone-my-repo=cd ~/Void/Git/ && git clone https://github.com/FateSwap/Fates-Dots && cd -'
  cd ~/Void/Git/ && git clone https://github.com/FateSwap/Fates-Dots && cd - $argv
        
end
