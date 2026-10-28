{ inputs, ... }:
{
  imports = [ inputs.umbriel.homeModules.default ];

  programs.umbriel = {
    enable = true;
    settings = {
      general = {
        autostart = [ "noctalia" ];
        show_cheatsheet = false;
      };
      output.eDP-1 = {
        mode = "2560x1600@180";
        scale = 1.5;
      };
      layout = {
        gap = 5;
      };
      input.keyboard.layout = "us";
      keybinds = {
        "Mod+Return" = "spawn:wezterm";
        "Mod+C" = "window-close";
        "Mod+D" = "spawn:noctalia msg panel-toggle launcher";
      };
    };
  };
}
