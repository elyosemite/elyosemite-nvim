local Gruvbox = {}

function Gruvbox.GetGruvboxTheme()
  return
    {
      "ellisonleao/gruvbox.nvim",
      priority = 1000,
      config = function()
        require("gruvbox").setup()
        vim.cmd.colorscheme("gruvbox")
        vim.o.background = "light"
      end
    }
end

return Gruvbox
