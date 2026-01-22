return {
  -- Mason para instalar LSPs, formatadores, etc.
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    local servers = {
      "lua_ls",
      "ts_ls",
      "csharp_ls",
      "sqlls",
    }

    -- Configuração do Mason
    require("mason").setup()

    -- Função on_attach: será executada sempre que um LSP for anexado a um buffer
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
    end
    
    -- Configuração do Mason-LSPConfig para instalar e configurar os servidores
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      handlers = {
        -- Handler padrão: será usado para todos os servidores que não têm um handler customizado abaixo
        function(server_name)
          require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            capabilities = vim.lsp.protocol.make_client_capabilities(),
          })
        end,

        -- Handler customizado para lua_ls, com configurações específicas
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            on_attach = on_attach,
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