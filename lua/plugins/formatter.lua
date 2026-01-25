return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      csharp = { "csharpier" }
      -- others here
    }
  }
}
