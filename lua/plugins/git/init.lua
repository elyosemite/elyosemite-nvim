return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = "▎" },
      change       = { text = "▎" },
      delete       = { text = "" },
      topdelete    = { text = "" },
      changedelete = { text = "▎" },
      untracked    = { text = "▎" },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 300,
      virt_text_pos = "eol",
    },
    current_line_blame_formatter = " <author>, <author_time:%d/%m/%Y> · <summary>",
    -- Hunk = um bloco de linhas alteradas. Docs: https://github.com/lewis6991/gitsigns.nvim#-keymaps
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end
      map("n", "]h", function() gs.nav_hunk("next") end, "Next change (hunk)")
      map("n", "[h", function() gs.nav_hunk("prev") end, "Prev change (hunk)")
      map("n", "<leader>gp", gs.preview_hunk, "Preview change")
      map("n", "<leader>gr", gs.reset_hunk, "Undo change (reset hunk)")
      map("n", "<leader>gs", gs.stage_hunk, "Stage change")
      map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
    end,
  },
}
