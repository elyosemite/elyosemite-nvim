-- snacks.nvim: dashboard, notificações, guias de indentação, terminal e mais.
-- Docs: https://github.com/folke/snacks.nvim
local header = [[
                                              
       ████ ██████           █████      ██
      ███████████             █████ 
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████]]

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      preset = {
        header = header,
        keys = {
          { icon = " ", key = "f", desc = "Find file", action = ":Telescope find_files" },
          { icon = " ", key = "r", desc = "Recent files", action = ":Telescope oldfiles" },
          { icon = " ", key = "g", desc = "Search text", action = ":Telescope live_grep" },
          { icon = " ", key = "n", desc = "New file", action = ":ene | startinsert" },
          { icon = " ", key = "t", desc = "Pick theme", action = function() require("core.theme").pick() end },
          { icon = " ", key = "?", desc = "All keys", action = function() require("core.cheatsheet").open() end },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = "󰒲 ", key = "l", desc = "Plugins", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    notifier = { enabled = true },   -- vim.notify em popups
    indent = { enabled = true },     -- guias de indentação
    words = { enabled = true },      -- destaca a palavra sob o cursor no arquivo
    input = { enabled = true },      -- vim.ui.input bonito (ex.: renomear)
    bigfile = { enabled = true },    -- desliga recursos pesados em arquivos grandes
    quickfile = { enabled = true },
    terminal = { enabled = true },
  },
  keys = {
    { "<C-\\>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Toggle terminal" },
    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification history" },
    { "]]", function() Snacks.words.jump(1, true) end, desc = "Next reference" },
    { "[[", function() Snacks.words.jump(-1, true) end, desc = "Prev reference" },
  },
}
