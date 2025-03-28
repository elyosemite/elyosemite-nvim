local Config = {}

function Config.GetTelescopeConfig()
    return
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" }
    }
end

return Config
