return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    require("themery").setup({
      themes = {
        --"gruvbox",
        "catppuccin",
        "catppuccin-latte",
        "catppuccin-frappe",
        "catppuccin-macchiato",
        "catppuccin-mocha",
        "nightfox",
        "dayfox",
        "dawnfox",
        "duskfox",
        "nordfox",
        "terafox",
        "carbonfox"
      },
      livePreview = true
    })
  end
}
