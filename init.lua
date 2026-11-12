vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("core.cheatsheet").snapshot() -- antes de qualquer atalho da config
require("config.lazy")
require("core.options")
require("core.keymaps")
require("core.diagnostics")
require("core.autocmds")
require("core.theme").setup()
require("core.cheatsheet").setup()
require("core.palette").setup()
