return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    { "<C-p>",      "<cmd>Telescope find_files<cr>",  desc = "Find files" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Telescope find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Telescope live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Telescope buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Telescope help tags" },
    { "<C-op>",     "<cmd>Telescope buffers<cr>",     desc = "Telescope open buffers" },
  },
}
