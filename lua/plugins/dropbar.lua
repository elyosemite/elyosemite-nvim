-- Barra de navegação clicável no topo: pasta > arquivo > classe > função.
-- Docs: https://github.com/Bekaboo/dropbar.nvim
return {
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {},
  keys = {
    { "<leader>;", function() require("dropbar.api").pick() end, desc = "Pick from breadcrumbs" },
  },
}
