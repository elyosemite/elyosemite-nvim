vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")
require("core.options")
require("core.keymaps")
require("core.diagnostics")
require("core.autocmds")
require("core.theme").setup()
