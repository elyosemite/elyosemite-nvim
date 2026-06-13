return {
  name = "clojure_lsp",
  config = function(on_attach, capabilities)
    return {
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = require("lspconfig.util").root_pattern(
        "project.clj", "deps.edn", "build.boot", "shadow-cljs.edn", ".git"
      ),
    }
  end,
}
