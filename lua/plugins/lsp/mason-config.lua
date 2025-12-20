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
        -- Nova API do Neovim 0.11+
        local omnisharpConfiguration = require("plugins.lsp.omnisharp")

        -- Configurar servidores com a nova API
        vim.lsp.config("lua_ls", {
          root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml", "selene.yml", ".git" },
        })

        vim.lsp.config("ts_ls", {
          root_markers = { "tsconfig.json", "package.json", ".git" },
        })

        -- OmniSharp com configurações customizadas
        vim.lsp.config("omnisharp", omnisharpConfiguration.GetBaseConfig())

        -- Ativar automaticamente os servidores configurados
        vim.lsp.enable({ "lua_ls", "ts_ls", "omnisharp" })

        -- Keymaps globais para LSP
        local function setup_keymaps()
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = true, desc = "Hover" })
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, desc = "Goto definition" })
          vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, { buffer = true, desc = "Code action" })
        end

        -- Aplicar keymaps quando um servidor LSP inicia
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = setup_keymaps,
          group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
        })
      end
    }
end

return Mason
