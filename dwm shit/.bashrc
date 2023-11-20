# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# dwm
alias dwm-rebuild="cd ~/.suckless/dwm && rm config.h && sudo make clean install && cd ~/"
alias dwm-tmp-config-atom="cd ~/.suckless/dwm && sudo atom config.h && cd ~/"
alias dwm-tmp-config="cd ~/.suckless/dwm && sudo vim config.h && cd ~/"
alias dwm-config-apply="cd ~/.suckless/dwm && sudo config.h config.def.h"
alias dwm-perm-config="cd ~/.suckless/dwm && sudo vim config.def.h && cd ~/"
alias dwm-perm-config-atom="cd ~/.suckless/dwm && sudo atom config.def.h && cd ~/"
alias dwm-dir="cd ~/.suckless/dwm"

# st
alias st-rebuild="cd ~/.suckless/st && rm config.h && sudo make clean install && cd ~/"
alias st-tmp-config-atom="cd ~/.suckless/st && sudo atom config.h && cd ~/"
alias st-tmp-config="cd ~/.suckless/st && sudo vim config.h && cd ~/"
alias st-config-apply="cd ~/.suckless/st && sudo config.h config.def.h"
alias st-perm-config="cd ~/.suckless/st && sudo vim config.def.h && cd ~/"
alias st-perm-config-atom="cd ~/.suckless/st && sudo atom config.def.h && cd ~/"
alias st-dir="cd ~/.suckless/st"

# dmenu
alias dmenu-rebuild="cd ~/.suckless/dmenu && rm config.h && sudo make clean indmenuall && cd ~/"
alias dmenu-tmp-config-atom="cd ~/.suckless/dmenu && sudo atom config.h && cd ~/"
alias dmenu-tmp-config="cd ~/.suckless/dmenu && sudo vim config.h && cd ~/"
alias dmenu-config-apply="cd ~/.suckless/dmenu && sudo config.h config.def.h"
alias dmenu-perm-config="cd ~/.suckless/dmenu && sudo vim config.def.h && cd ~/"
alias dmenu-perm-config-atom="cd ~/.suckless/dmenu && sudo atom config.def.h && cd ~/"
alias dmenu-dir="cd ~/.suckless/dmenu"

# slstatus
alias slstatus-rebuild="cd ~/.suckless/slstatus && rm config.h && sudo make clean inslstatusall && cd ~/"
alias slstatus-tmp-config-atom="cd ~/.suckless/slstatus && sudo atom config.h && cd ~/"
alias slstatus-tmp-config="cd ~/.suckless/slstatus && sudo vim config.h && cd ~/"
alias slstatus-config-apply="cd ~/.suckless/slstatus && sudo config.h config.def.h"
alias slstatus-perm-config="cd ~/.suckless/slstatus && sudo vim config.def.h && cd ~/"
alias slstatus-perm-config-atom="cd ~/.suckless/slstatus && sudo atom config.def.h && cd ~/"
alias slstatus-dir="cd ~/.suckless/slstatus"

# Extra
figlet Hello Spaceman
