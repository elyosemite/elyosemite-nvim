-- Formatação por linguagem. Formata ao salvar; desligue com <leader>uf.
-- Docs: https://github.com/stevearc/conform.nvim
return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  opts = {
    formatters_by_ft = {
      lua        = { "stylua" },
      python     = { "isort", "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      c          = { "clang_format" },
      cpp        = { "clang_format" },
      cs         = { "csharpier" },
    },
    format_on_save = function()
      if vim.g.disable_autoformat then
        return
      end
      return { timeout_ms = 1500, lsp_format = "fallback" }
    end,
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle.new({
          name = "Format on save",
          get = function() return not vim.g.disable_autoformat end,
          set = function(on) vim.g.disable_autoformat = not on end,
        }):map("<leader>uf")
      end,
    })
  end,
  keys = {
    {
      "<leader>gf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      desc = "Format file",
    },
  },
}
