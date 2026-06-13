local Plugins = {}

local telescope = require("plugins.telescope")
local neotree = require("plugins.neotree")
local lsp = require("plugins.lsp.mason-config")
local lualine = require("plugins.lualine")
local treesitter = require("plugins.treesitter")
local alpha = require("plugins.alpha")
local formatter = require("plugins.formatter")
local bufferline = require("plugins.bufferline")
local themes = require("plugins.themes")
local git = require("plugins.git")
local lazygit = require("plugins.git.lazygit")
local cmp = require("plugins.autocomplete.cmp")

Plugins.all_plugins = {
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  themes.active,
  telescope.Telescope,
  telescope.TelescopeUiSelect,
  treesitter,
  neotree,
  lualine,
  lsp,
  alpha,
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  formatter,
  bufferline,
  git,
  lazygit,
  cmp,
}

return Plugins
