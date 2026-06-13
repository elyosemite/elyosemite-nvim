return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-go",
    "marilari88/neotest-vitest",
    "rouge8/neotest-rust",
  },
  keys = {
    { "<leader>tt", function() require("neotest").run.run() end,                      desc = "Run nearest test" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,    desc = "Run test file" },
    { "<leader>ts", function() require("neotest").summary.toggle() end,               desc = "Toggle test summary" },
    { "<leader>to", function() require("neotest").output_panel.toggle() end,          desc = "Toggle test output" },
    { "<leader>tS", function() require("neotest").run.stop() end,                     desc = "Stop test" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-plenary"),
        require("neotest-go"),
        require("neotest-vitest"),
        require("neotest-rust"),
      },
    })
  end,
}
