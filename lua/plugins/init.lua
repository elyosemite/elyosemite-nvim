local Plugins = {}

local theme = require("plugins.themes")
local telescope = require("plugins.telescope")
local treesitter = require("plugins.parsers")
local neotree = require("plugins.neotree")
local lualine = require("plugins.lualine")
local lsp = require("plugins.lsp")
local none_ls = require("plugins.none-ls")
local alpha = require("plugins.alpha")

Plugins.all_plugins = {
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  theme.Gruvbox.GetGruvboxTheme(),
  telescope.Config.GetTelescopeConfig(),
  telescope.Config.GetTelescopeUIConfig(),
  treesitter.Treesitter.GetTreesitterConfig(),
  neotree.Setup.GetNeotreeConfig(),
  lualine.Setup.GetLualineConfig(),
  lsp.Mason.GetMasonConfig(),
  lsp.Mason.GetMasonLspConfig(),
  lsp.Mason.GetNvimLspConfig(),
  none_ls.NoneLsSetup.GetNoneLsConfig(),
  alpha
}

return Plugins
