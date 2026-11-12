local Plugins = {}

local telescope = require("plugins.telescope")
local neotree = require("plugins.neotree")
local lsp = require("plugins.lsp.mason-config")
local lualine = require("plugins.lualine")
local treesitter = require("plugins.treesitter")
local snacks = require("plugins.snacks")
local formatter = require("plugins.formatter")
local bufferline = require("plugins.bufferline")
local themes = require("plugins.themes")
local git = require("plugins.git")
local lazygit = require("plugins.git.lazygit")
local cmp = require("plugins.autocomplete.cmp")
local neotest = require("plugins.neotest")
local rust = require("plugins.rust")
local menu = require("plugins.menu")
local markdown = require("plugins.markdown")

Plugins.all_plugins = {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  require("plugins.whichkey"),
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  themes.specs,
  telescope.Telescope,
  telescope.TelescopeUiSelect,
  treesitter,
  neotree,
  lualine,
  lsp,
  snacks,
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
  neotest,
  rust,
  menu,
  markdown,
}

return Plugins
