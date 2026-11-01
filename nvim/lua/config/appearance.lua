-- config/appearance.lua

vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
vim.g.colors_name = "yakushimaru"

local c = {
  surface  = "#111B1B",
  selection= "#203C3A",
  fg       = "#F2D9D8",
  muted    = "#A99B9C",
  teal     = "#36C6B1",
  teal_dim = "#218F84",
  coral    = "#FF5265",
  red      = "#E93650",
  pink     = "#F28CA0",
  cream    = "#FFE8D8",
  gold     = "#E8B95C",
  blue     = "#5A9FE8",
  purple   = "#B67BD1",
}

local groups = {
  Normal       = { fg = c.fg, bg = c.bg },
  NormalFloat  = { fg = c.fg, bg = c.surface },
  FloatBorder  = { fg = c.teal_dim, bg = c.surface },
  CursorLine   = { bg = c.surface },
  LineNr       = { fg = c.muted },
  CursorLineNr = { fg = c.gold, bold = true },
  Visual       = { bg = c.selection },
  Search       = { fg = c.bg, bg = c.gold },
  IncSearch    = { fg = c.bg, bg = c.coral },
  MatchParen   = { fg = c.cream, bg = c.selection, bold = true },

  Comment      = { fg = c.muted, italic = true },
  Constant     = { fg = c.pink },
  String       = { fg = c.teal },
  Character    = { fg = c.teal },
  Number       = { fg = c.gold },
  Boolean      = { fg = c.gold, bold = true },
  Identifier   = { fg = c.cream },
  Function     = { fg = c.teal, bold = true },
  Statement    = { fg = c.coral },
  Conditional  = { fg = c.coral },
  Repeat       = { fg = c.coral },
  Operator     = { fg = c.pink },
  Keyword      = { fg = c.red, bold = true },
  Type         = { fg = c.gold },
  Special      = { fg = c.pink },
  PreProc      = { fg = c.purple },
  Error        = { fg = c.cream, bg = c.red, bold = true },
  WarningMsg   = { fg = c.gold },
  Todo         = { fg = c.bg, bg = c.teal, bold = true },

  Pmenu        = { fg = c.fg, bg = c.surface },
  PmenuSel     = { fg = c.bg, bg = c.teal },
  StatusLine   = { fg = c.fg, bg = c.surface },
  StatusLineNC = { fg = c.muted, bg = c.bg },
  VertSplit    = { fg = c.selection },
  WinSeparator = { fg = c.selection },
  TabLine      = { fg = c.muted, bg = c.surface },
  TabLineSel   = { fg = c.cream, bg = c.bg, bold = true },
  Directory    = { fg = c.teal },
  Title        = { fg = c.coral, bold = true },
  NonText      = { fg = c.selection },
  SpecialKey   = { fg = c.teal_dim },

  DiagnosticError = { fg = c.red },
  DiagnosticWarn  = { fg = c.gold },
  DiagnosticInfo  = { fg = c.teal },
  DiagnosticHint  = { fg = c.purple },
  DiffAdd         = { fg = c.teal, bg = c.surface },
  DiffDelete      = { fg = c.red, bg = c.surface },
  DiffChange      = { fg = c.gold, bg = c.surface },
  DiffText        = { fg = c.cream, bg = c.selection, bold = true },
}

for group, options in pairs(groups) do
  vim.api.nvim_set_hl(0, group, options)
end

-- Common Tree-sitter highlight groups
local treesitter = {
  ["@comment"] = groups.Comment,
  ["@string"] = groups.String,
  ["@number"] = groups.Number,
  ["@boolean"] = groups.Boolean,
  ["@function"] = groups.Function,
  ["@function.call"] = groups.Function,
  ["@keyword"] = groups.Keyword,
  ["@operator"] = groups.Operator,
  ["@type"] = groups.Type,
  ["@variable"] = groups.Identifier,
  ["@constant"] = groups.Constant,
}

for group, options in pairs(treesitter) do
  vim.api.nvim_set_hl(0, group, options)
end

-- Terminal colors
vim.g.terminal_color_0  = c.bg
vim.g.terminal_color_1  = c.red
vim.g.terminal_color_2  = c.teal_dim
vim.g.terminal_color_3  = c.gold
vim.g.terminal_color_4  = c.blue
vim.g.terminal_color_5  = c.purple
vim.g.terminal_color_6  = c.teal
vim.g.terminal_color_7  = c.fg
vim.g.terminal_color_8  = c.muted
vim.g.terminal_color_9  = c.coral
vim.g.terminal_color_10 = c.teal
vim.g.terminal_color_11 = c.cream
vim.g.terminal_color_12 = c.blue
vim.g.terminal_color_13 = c.pink
vim.g.terminal_color_14 = c.teal
vim.g.terminal_color_15 = "#FFFFFF"

