return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua        = { "stylua" },
      python     = { "isort", "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      c          = { "clang_format" },
      cpp        = { "clang_format" },
      csharp     = { "csharpier" },
    },
  },
  keys = {
    {
      "<leader>gf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Format file",
    },
  },
}
