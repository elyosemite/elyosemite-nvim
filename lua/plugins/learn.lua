-- Ajuda a aprender Vim enquanto usa.
return {
  -- Mostra na linha onde w, b, e, $, ^ levariam o cursor.
  -- Docs: https://github.com/tris203/precognition.nvim
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = {
      startVisible = true,
      showBlankVirtLine = false,
    },
    config = function(_, opts)
      local precognition = require("precognition")
      precognition.setup(opts)
      Snacks.toggle.new({
        name = "Motion hints",
        get = precognition.is_visible,
        set = function(on)
          if on then precognition.show() else precognition.hide() end
        end,
      }):map("<leader>up")
    end,
  },
}
