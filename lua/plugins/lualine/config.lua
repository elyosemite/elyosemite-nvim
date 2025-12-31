local Lualine = {}

function Lualine.GetLualineConfig()
  return
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('lualine').setup(require('plugins.lualine.options'))
      end
    }
end

return Lualine
