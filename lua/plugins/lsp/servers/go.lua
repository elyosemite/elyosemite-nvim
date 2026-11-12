return {
  name = "gopls",
  config = {
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
  },
}
