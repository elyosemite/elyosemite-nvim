return {
  name = "sqlls",
  config = {
    filetypes = { "sql", "mysql" },
    -- sqlls lê a conexão do arquivo .sqllsrc.json na raiz do projeto
    root_markers = { ".sqllsrc.json", ".git" },
  },
}
