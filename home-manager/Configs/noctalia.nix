{ inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    settings = {
		  input.keyboard = {
    layout = "us"; # use your intended XKB layout code
    variant = "";
    options = "";
    model = "";
  };
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      wallpaper = {
        enabled = true;
        default.path = "~/Void/Git/wallpapers/Anime/calabera-laka-laka.png";
      };
    };
  };
}

