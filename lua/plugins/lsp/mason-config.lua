return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local servers = {
      "lua_ls",
      "ts_ls",
      "csharp_ls",
      "sqlls",
      "gopls",
      "clojure_lsp",
      "basedpyright",
    }

    -- Configs customizadas por linguagem (carregadas de servers/)
    local custom_servers = {
      require("plugins.lsp.servers.lua"),
      require("plugins.lsp.servers.typescript"),
      require("plugins.lsp.servers.sql"),
      require("plugins.lsp.servers.go"),
      require("plugins.lsp.servers.clojure"),
      require("plugins.lsp.servers.csharp"),
      require("plugins.lsp.servers.python"),
    }

    -- Vale para todos os servidores; os atalhos ficam no LspAttach (core/keymaps.lua)
    vim.lsp.config("*", {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })

    -- Mescla por cima do config padrão que o nvim-lspconfig fornece em lsp/<name>.lua
    for _, server in ipairs(custom_servers) do
      vim.lsp.config(server.name, server.config)
    end

    require("mason").setup()
    -- mason-lspconfig v2: instala e chama vim.lsp.enable() para cada servidor instalado
    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })
  end,
}
