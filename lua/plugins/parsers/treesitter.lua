local Treesitter = {}

function Treesitter.GetTreesitterConfig()
  return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = { "lua", "ruby", "go", "python", "javascript", "typescript", "html", "css", "haskell", "c", "cpp", "sql", "c_sharp" },
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        }
      })
    end
  }
end

return Treesitter

