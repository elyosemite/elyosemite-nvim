local Lualine = {}

function Lualine.GetLualineConfig()
  return
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' }
    }
end

return Lualine
