-- Ver o que mudou e resolver conflitos de merge lado a lado.
-- Docs: https://github.com/sindrets/diffview.nvim
return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = {
    {
      "<leader>gd",
      function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd("DiffviewOpen")
        else
          vim.cmd("DiffviewClose")
        end
      end,
      desc = "Toggle diff view (changes / conflicts)",
    },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
  },
}
