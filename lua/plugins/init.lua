local Plugins = {}

local telescope = require("plugins.telescope")
local parser = require("plugins.parsers")
local neotree = require("plugins.neotree")
local lualine_config = require("plugins.lualine")
local lsp = require("plugins.lsp")
local alpha = require("plugins.alpha")
--local markdown = require("plugins.markdown")
local formatter = require("plugins.formatter")
local bufferline = require("plugins.bufferline")
local theme = require("plugins.themes.everforest")
local git = require("plugins.git")
local cmp = require("plugins.autocomplete.cmp")

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
  alpha,
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  formatter,
  bufferline,
  git,
  cmp,
}

return Plugins
