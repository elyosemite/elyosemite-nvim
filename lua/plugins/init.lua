local Plugins = {}

local theme = require("plugins.themes")
local telescope = require("plugins.telescope")
local parser = require("plugins.parsers")
local neotree = require("plugins.neotree")
local lualine_config = require("plugins.lualine")
local lsp = require("plugins.lsp")
local none_ls = require("plugins.none-ls")
local alpha = require("plugins.alpha")
local markdown = require("plugins.markdown")
local formatter = require("plugins.formatter")
local bufferline = require("plugins.bufferline")

Plugins.all_plugins = {
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  theme.Gruvbox,
  telescope.Telescope,
  telescope.TelescopeUiSelect,
  parser.Treesitter,
  neotree.Setup.GetNeotreeConfig(),
  lualine_config.Setup.GetLualineConfig(),
  lsp,
  none_ls.NoneLsSetup.GetNoneLsConfig(),
  alpha,
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  markdown,
  formatter,
  bufferline
}

return Plugins
