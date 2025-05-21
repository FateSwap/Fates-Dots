-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This is where you actually apply your config choices.
return {
    --Fonts
    font_size = 16,
    font = wezterm.font 'Hermit',
	
    --Opacity
    window_background_opacity = 0.9,

    --Top Bar
    enable_tab_bar = true,
    use_fancy_tab_bar = false,

    --Colors
    color_scheme = "gruvbox_material_dark_hard",
    color_schemes = {
        ["gruvbox_material_dark_hard"] = {
            foreground = "#D4BE98",
            background = "#1D2021",
            cursor_bg = "#D4BE98",
            cursor_border = "#D4BE98",
            cursor_fg = "#1D2021",
            selection_bg = "#D4BE98" ,
            selection_fg = "#3C3836",

            ansi = {"#1d2021","#ea6962","#a9b665","#d8a657", "#7daea3","#d3869b", "#89b482","#d4be98"},
            brights = {"#32302f","#ea6962","#a9b665","#d8a657", "#7daea3","#d3869b", "#89b482","#d4be98"},
        },
    },
}
