{ lib, ... }:

{
  programs.wezterm = {
    enable = true;

    settings = {
      initial_cols = 120;
      initial_rows = 28;
      font = lib.generators.mkLuaInline "wezterm.font('Hermit')";
      font_size = 12;
      window_background_opacity = 0.8;
      window_frame = {
        active_titlebar_bg = "rgba(0, 0, 0, 0.8)";
        inactive_titlebar_bg = "rgba(0, 0, 0, 0.8)";
      };
    };
  };
}
