local Treesitter = {}

function Treesitter.GetTreesitterConfig()
    return
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
        -- dependencies = {
        --     "nvim-treesitter/nvim-treesitter-textobjects",
        --     "JoosepAlviste/nvim-ts-context-commentstring",
        --     "windwp/nvim-ts-autotag",
        --     "nvim-treesitter/playground",
        --     "nvim-treesitter/nvim-treesitter-refactor",
        --     "nvim-treesitter/nvim-treesitter-context"
        -- }
    }
end

return Treesitter