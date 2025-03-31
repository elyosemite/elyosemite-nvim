local Mason = {}

function Mason.GetMasonConfig()
  return
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end
    }
end

function Mason.GetMasonLspConfig()
  return
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup(
          {
            ensure_installed = { "lua_ls", "ts_ls", "omnisharp" }
          })
      end
    }
end

function Mason.GetNvimLspConfig()
  return
    {
      "neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require("lspconfig")
        local omnisharpConfiguration = require("plugins.lsp.omnisharp")

        lspconfig.lua_ls.setup({})
        lspconfig.ts_ls.setup({})
        lspconfig.omnisharp.setup(omnisharpConfiguration.GetBaseConfig())

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
        vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
      end
    }
end

return Mason
