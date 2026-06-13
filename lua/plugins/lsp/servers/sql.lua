return {
  name = "sqlls",
  config = function(on_attach, capabilities)
    return {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "sql", "mysql" },
      -- sqlls lê a conexão do arquivo .sqllsrc.json na raiz do projeto
      root_dir = require("lspconfig.util").root_pattern(".sqllsrc.json", ".git"),
    }
  end,
}
