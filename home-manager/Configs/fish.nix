# Configs/fish.nix
{ pkgs, ... }:

{

  home.packages = with pkgs; [
    figlet # for greeting
  ];

  programs.fish = {
    enable = true;

    functions = {

      fish_greeting = {
        body = ''
          figlet -f small "Hello Spaceman"
        '';
      };

      fish_prompt = {
        body = ''
          set_color '#43E0C1'
          printf '%s' (prompt_pwd)
          set_color normal
          printf ' > '
        '';
      };
    };

    interactiveShellInit = ''
      set -g fish_color_cwd '#43E0C1'
      set -g fish_color_normal '#E8E5DC'
      set -g fish_color_command '#E8B85B'
      set -g fish_color_keyword '#FF4264' --bold
      set -g fish_color_quote '#43E0C1'
      set -g fish_color_redirection '#1D9E9A'
      set -g fish_color_end '#F08AA5'
      set -g fish_color_error '#FF4264' --bold
      set -g fish_color_param '#E8E5DC'
      set -g fish_color_option '#BD83D1'
      set -g fish_color_comment '#778886' --italics
      set -g fish_color_operator '#1D9E9A'
      set -g fish_color_escape '#F08AA5'
      set -g fish_color_autosuggestion '#778886'
      set -g fish_color_valid_path '#43E0C1'

      set -g fish_color_selection --background='#253638'
      set -g fish_color_search_match --background='#E8B85B'

      set -g fish_pager_color_prefix '#E8B85B' --bold
      set -g fish_pager_color_completion '#E8E5DC'
      set -g fish_pager_color_description '#778886'
      set -g fish_pager_color_progress '#43E0C1'
      set -g fish_pager_color_selected_background --background='#253638'
    '';

    shellAliases = {
      h = "cd ~/";
      c = "cd ~/.config";
      b = "btop";
      v = "cd ~/Void";
      nv = "nvim";
      hm = "cd ~/.config/nixos/home-manager";
      pf = "pfetch";
      gc = "git clone";
      ll = "ls -a";
      cl = "clear && figlet -f small Cleared";
      rbs = "sudo nixos-rebuild switch --flake ~/.config/nixos/#Flow-Z13-NixOS";
      rbb = "sudo nixos-rebuild boot --flake ~/.config/nixos/#Flow-Z13-NixOS";
      hms = "home-manager switch -b bak";
			nvc = "nvim ~/.config/nixos/configuration.nix";
      Revive = "reboot";
      Curse_of_Ra = "shutdown now";
    };
  };
}
