local Plugins = {}

local telescope = require("plugins.telescope")
local parser = require("plugins.parsers")
local neotree = require("plugins.neotree")
local lualine_config = require("plugins.lualine")
local lsp = require("plugins.lsp")
local none_ls = require("plugins.none-ls")
local alpha = require("plugins.alpha")
--local markdown = require("plugins.markdown")
local formatter = require("plugins.formatter")
local bufferline = require("plugins.bufferline")

local theme = require("plugins.themes.everforest")

Plugins.all_plugins = {
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  theme,
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
  formatter,
  bufferline
}

return Plugins
