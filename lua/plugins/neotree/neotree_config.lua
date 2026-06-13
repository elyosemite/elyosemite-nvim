local NeoTreeConfig = {}

function NeoTreeConfig.GetNeotreeConfig()
    return
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim"
        },
        lazy = false,
        keys = {
            { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
        },
    }
end

return NeoTreeConfig
