return {
  name = "basedpyright",
  config = function(on_attach, capabilities)
    return {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = "standard",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    }
  end,
}
