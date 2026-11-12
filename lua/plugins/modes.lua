-- Colore a linha do cursor conforme o modo: Insert, Visual, Delete, Yank.
-- Docs: https://github.com/mvllow/modes.nvim
return {
  "mvllow/modes.nvim",
  event = "VeryLazy",
  opts = {
    line_opacity = 0.2,
  },
}
