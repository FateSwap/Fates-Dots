-- plugins/conform.lua
return {
  {
    "stevearc/conform.nvim", -- plugin to install
    opts = {                 -- options passed to the plugin's setup()
      formatters_by_ft = {
        lua = { "stylua" },
	nix = { "nixfmt" },
      },
    },
  },
}

