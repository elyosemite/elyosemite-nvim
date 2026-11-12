return {
  "ellisonleao/gruvbox.nvim",
  lazy = true, -- carregado pelo lazy.nvim ao aplicar :colorscheme (ver core/theme.lua)
  priority = 1000,
  config = function()
    require("gruvbox").setup()
  end,
}
