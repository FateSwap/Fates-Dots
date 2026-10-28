# Configs/nixvim.nix
{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  home.packages = with pkgs; [
    stylua
    nixfmt
    astyle
    kdlfmt
  ];

  programs.nixvim = {
    enable = true;
    opts = {
      relativenumber = true;
      number = true;

      tabstop = 2;
      shiftwidth = 2;
      autoindent = true;
      expandtab = false;

      ignorecase = true;
      smartcase = true;

      termguicolors = true;
      background = "dark";
      signcolumn = "yes";
      cursorline = true;
      colorcolumn = "80";

      clipboard = "unnamedplus";
      backspace = "indent,eol,start";

      splitbelow = true;
      splitright = true;

      scrolloff = 8;

      swapfile = false;
      backup = false;
      undofile = true;
      undodir = "~/.vim/undodir";

      incsearch = true;
      updatetime = 50;
    };

    plugins = {
      lualine.enable = true;
      colorizer.enable = true;

      dashboard = {
        enable = true;
        settings = {
          config = {
            header = builtins.filter (line: line != "") (
              pkgs.lib.splitString "\n" ''
                 _____   ______    ____                        ____      ____  ____      ______  _______
                |\    \ |\     \  |    |_____      _____      |    |    |    ||    |    |      \/       \
                 \\    \| \     \ |    |\    \    /    /      |    |    |    ||    |   /          /\     \
                  \|    \  \     ||    | \    \  /    /       |    |    |    ||    |  /     /\   / /\     |
                   |     \  |    ||    |  \____\/____/        |    |    |    ||    | /     /\ \_/ / /    /|
                   |      \ |    ||    |  /    /\    \        |    |    |    ||    ||     |  \|_|/ /    / |
                   |    |\ \|    ||    | /    /  \    \       |\    \  /    /||    ||     |       |    |  |
                   |____||\_____/||____|/____/ /\ \____\      | \ ___\/___ / ||____||\____\       |____|  /
                   |    |/ \|   |||    ||    |/  \|    |       \ |   ||   | / |    || |    |      |    | /
                   |____|   |___|/|____||____|    |____|        \|___||___|/  |____| \|____|      |____|/
                     \(       )/    \(    \(        )/            \(    )/      \(      \(          )/
                     '       '      '     '        '              '    '        '       '
              ''
            );
            mru.limit = 4;
          };
        };
      };

      lsp = {
        enable = true;
        servers.nil_ls.enable = true;
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };

      conform-nvim = {
        enable = true;
        settings.formatters_by_ft = {
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          c = [ "astyle" ];
          cpp = [ "astyle" ];
          cs = [ "astyle" ];
          java = [ "astyle" ];
          kdl = [ "kdlfmt" ];
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>f";
        action = ''<cmd>lua require("conform").format({ async = true, lsp_format = "fallback" })<CR>'';
        options.desc = "Format buffer";
      }
    ];

    extraConfigLuaPost = ''
            vim.opt.termguicolors = true
            vim.o.background = "dark"

            local c = {
              bg = "#080D0D",
              surface = "#121B1C",
              fg = "#E8E5DC",
              muted = "#778886",
              coral = "#FF4264",
              turquoise = "#43E0C1",
              teal = "#1D9E9A",
              rose = "#F08AA5",
              gold = "#E8B85B",
              purple = "#BD83D1",
            }

            local groups = {
              Normal = { fg = c.fg, bg = "NONE" },
              NormalNC = { fg = c.fg, bg = "NONE" },
              NormalFloat = { fg = c.fg, bg = "NONE" },
              SignColumn = { bg = "NONE" },
              EndOfBuffer = { fg = c.muted, bg = "NONE" },

              CursorLine = { bg = c.surface },
              LineNr = { fg = c.muted },
              CursorLineNr = { fg = c.gold, bold = true },
              Visual = { bg = "#253638" },
              Search = { fg = c.bg, bg = c.gold },
              IncSearch = { fg = c.bg, bg = c.coral },

              Comment = { fg = c.muted, italic = true },
              String = { fg = c.turquoise },
              Character = { fg = c.turquoise },
              Function = { fg = c.gold },
              Keyword = { fg = c.coral, bold = true },
              Statement = { fg = c.coral },
              Type = { fg = c.rose },
              Constant = { fg = c.purple },
              Identifier = { fg = c.fg },
              Operator = { fg = c.teal },
              Delimiter = { fg = c.rose },

              DiagnosticError = { fg = c.coral },
              DiagnosticWarn = { fg = c.gold },
              DiagnosticInfo = { fg = c.turquoise },
              DiagnosticHint = { fg = c.purple },
            }

            for group, settings in pairs(groups) do
              vim.api.nvim_set_hl(0, group, settings)
            end

            local lualine_theme = {
              normal = {
                a = { fg = c.bg, bg = c.coral, gui = "bold" },
                b = { fg = c.fg, bg = c.surface },
                c = { fg = c.muted, bg = "NONE" },
              },
              insert = {
                a = { fg = c.bg, bg = c.turquoise, gui = "bold" },
                b = { fg = c.fg, bg = c.surface },
                c = { fg = c.muted, bg = "NONE" },
              },
              visual = {
                a = { fg = c.bg, bg = c.purple, gui = "bold" },
                b = { fg = c.fg, bg = c.surface },
                c = { fg = c.muted, bg = "NONE" },
              },
              replace = {
                a = { fg = c.bg, bg = c.coral, gui = "bold" },
                b = { fg = c.fg, bg = c.surface },
                c = { fg = c.muted, bg = "NONE" },
              },
              command = {
                a = { fg = c.bg, bg = c.gold, gui = "bold" },
                b = { fg = c.fg, bg = c.surface },
                c = { fg = c.muted, bg = "NONE" },
              },
              inactive = {
                a = { fg = c.muted, bg = "NONE" },
                b = { fg = c.muted, bg = "NONE" },
                c = { fg = c.muted, bg = "NONE" },
              },
            }

            require("lualine").setup({
              options = {
                theme = lualine_theme,
              },
            })
      			local cmp = require("cmp")

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      })
    '';
  };
}
