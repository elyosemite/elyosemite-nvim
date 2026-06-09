return {
  -- Mason para instalar LSPs, formatadores, etc.
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    local keymaps = require("core.keymaps")
    local servers = {
      "lua_ls",
      "ts_ls",
      "csharp_ls",
      "sqlls",
    }

    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = servers,
      handlers = {
        -- Handler padrão: será usado para todos os servidores que não têm um handler customizado abaixo
        function(server_name)
          require("lspconfig")[server_name].setup({
            on_attach = keymaps.lsp_on_attach,
            capabilities = vim.lsp.protocol.make_client_capabilities(),
          })
        end,

        -- Handler customizado para lua_ls, com configurações específicas
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            on_attach = keymaps.lsp_on_attach,
            capabilities = vim.lsp.protocol.make_client_capabilities(),
            settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                telemetry = { enable = false },
              },
            },
          })
        end,
      },
    })
  end,
}
