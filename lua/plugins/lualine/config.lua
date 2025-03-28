local Lualine = {}

function Lualine.GetLualineConfig()
    return
        {
            'nvim-lualine/lualine.nvim',
            requires = { 'nvim-tree/nvim-web-devicons', opt = true },
            config = function()
                require('lualine').setup({
                    theme = "gruvbox"
                })
            end
        }
end

return Lualine
