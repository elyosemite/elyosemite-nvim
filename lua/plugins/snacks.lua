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
          { icon = " ", key = "s", desc = "Restore session", action = function() require("persistence").load() end },
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
  init = function()
    -- Grupo <leader>u: liga/desliga recursos. O which-key mostra o estado atual.
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle.option("wrap", { name = "Line wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative numbers" }):map("<leader>ur")
        Snacks.toggle.option("spell", { name = "Spell check" }):map("<leader>us")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ui")
      end,
    })
  end,
  keys = {
    { "<C-\\>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Toggle terminal" },
    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification history" },
    { "]]", function() Snacks.words.jump(1, true) end, desc = "Next reference" },
    { "[[", function() Snacks.words.jump(-1, true) end, desc = "Prev reference" },
  },
}
