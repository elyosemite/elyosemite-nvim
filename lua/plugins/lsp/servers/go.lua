return {
  name = "gopls",
  config = function(on_attach, capabilities)
    return {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        gopls = {
          gofumpt = true,
          analyses = { unusedparams = true, shadow = true },
          staticcheck = true,
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    }
  end,
}
