return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local keymaps = require("core.keymaps")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local servers = {
      "lua_ls",
      "ts_ls",
      "csharp_ls",
      "sqlls",
      "gopls",
      "clojure_lsp",
    }

    -- Configs customizadas por linguagem (carregadas de servers/)
    local custom_servers = {
      require("plugins.lsp.servers.lua"),
      require("plugins.lsp.servers.typescript"),
      require("plugins.lsp.servers.sql"),
      require("plugins.lsp.servers.go"),
      require("plugins.lsp.servers.clojure"),
    }

    -- Monta tabela de handlers customizados a partir dos arquivos em servers/
    local handlers = {
      -- Handler padrão para servidores sem config específica
      function(server_name)
        require("lspconfig")[server_name].setup({
          on_attach = keymaps.lsp_on_attach,
          capabilities = capabilities,
        })
      end,
    }

    for _, server in ipairs(custom_servers) do
      handlers[server.name] = function()
        require("lspconfig")[server.name].setup(
          server.config(keymaps.lsp_on_attach, capabilities)
        )
      end
    end

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      handlers = handlers,
    })
  end,
}
