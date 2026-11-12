-- Menu de contexto com o botão direito do mouse (ou <C-t> pelo teclado).
local function items()
  return {
    { name = "  Go to definition", cmd = vim.lsp.buf.definition, rtxt = "gd" },
    { name = "  References", cmd = vim.lsp.buf.references, rtxt = "gr" },
    { name = "  Documentation", cmd = vim.lsp.buf.hover, rtxt = "K" },
    { name = "  Rename symbol", cmd = vim.lsp.buf.rename, rtxt = "<leader>rn" },
    { name = "  Code actions", cmd = vim.lsp.buf.code_action, rtxt = "<leader>ca" },
    { name = "separator" },
    {
      name = "  Format file",
      cmd = function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
      rtxt = "<leader>gf",
    },
    { name = "  Show problem", cmd = vim.diagnostic.open_float, rtxt = "<leader>e" },
    { name = "separator" },
    { name = "  Find files", cmd = "Telescope find_files", rtxt = "<leader>ff" },
    { name = "  Search text", cmd = "Telescope live_grep", rtxt = "<leader>fg" },
    { name = "  LazyGit", cmd = "LazyGit", rtxt = "<leader>gg" },
    { name = "separator" },
    { name = "  Pick theme", cmd = function() require("core.theme").pick() end, rtxt = "<leader>th" },
    { name = "  All keys", cmd = function() require("core.cheatsheet").open() end, rtxt = "<leader>?" },
    { name = "  Command palette", cmd = function() require("core.palette").open() end, rtxt = "<leader><leader>" },
  }
end

return {
  "nvzone/menu",
  dependencies = { "nvzone/volt" },
  keys = {
    {
      "<C-t>",
      function() require("menu").open(items()) end,
      desc = "Context menu",
    },
    {
      "<RightMouse>",
      function()
        require("menu.utils").delete_old_menus()
        vim.cmd.exec('"normal! \\<RightMouse>"') -- move o cursor para onde clicou
        require("menu").open(items(), { mouse = true })
      end,
      mode = { "n", "v" },
      desc = "Context menu",
    },
  },
}
