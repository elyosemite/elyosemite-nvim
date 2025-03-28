local Plugins = {}

local theme = require("plugins.themes")
local telescope = require("plugins.telescope")
local treesitter = require("plugins.parsers")
local neotree = require("plugins.neotree")
local lualine = require("plugins.lualine")

Plugins.all_plugins = {
    "folke/neodev.nvim",
    "folke/which-key.nvim",
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    theme.Gruvbox.GetGruvboxTheme(),
    telescope.Config.GetTelescopeConfig(),
    treesitter.Treesitter.GetTreesitterConfig(),
    neotree.Setup.GetNeotreeConfig(),
    lualine.Setup.GetLualineConfig()
}

return Plugins
