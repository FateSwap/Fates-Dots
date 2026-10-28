{ ... }:

{
  imports = [
    # ./Configs/fish.nix
    # ./Configs/nixvim.nix
    # ./Configs/wezterm.nix
    # ./Configs/niri.nix
    # ./Configs/noctalia.nix
    # ./Configs/umbriel.nix
  ];

  home.username = "spaceman";
  home.homeDirectory = "/home/spaceman";
  home.stateVersion = "26.05"; # Don't touch it bruh, ain't worth it

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
	# LOOK INTO THIS #
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

   home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
