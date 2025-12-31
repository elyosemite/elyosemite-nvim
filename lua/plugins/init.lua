local Plugins = {}

local theme = require("plugins.themes")
local telescope = require("plugins.telescope")
local treesitter = require("plugins.parsers")
local neotree = require("plugins.neotree")
local lualine_config = require("plugins.lualine")
local lsp = require("plugins.lsp")
local none_ls = require("plugins.none-ls")
local alpha = require("plugins.alpha")
local switcher = require("plugins.switcher")

Plugins.all_plugins = {
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  theme.Catppuccin,
  telescope.Telescope,
  telescope.TelescopeUiSelect,
  treesitter.Treesitter.GetTreesitterConfig(),
  neotree.Setup.GetNeotreeConfig(),
  lualine_config.Setup.GetLualineConfig(),
  lsp.Mason.GetMasonConfig(),
  lsp.Mason.GetMasonLspConfig(),
  lsp.Mason.GetNvimLspConfig(),
  none_ls.NoneLsSetup.GetNoneLsConfig(),
  alpha,
  switcher.Themery
}

return Plugins
