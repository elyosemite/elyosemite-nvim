return {
  name = "csharp_ls",
  config = function(on_attach, capabilities)
    return {
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = require("lspconfig.util").root_pattern("*.sln", "*.csproj", ".git"),
    }
  end,
}
