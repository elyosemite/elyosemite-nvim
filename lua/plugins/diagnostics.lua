-- Erros e avisos mais legíveis ao lado do código, quebrando linha quando são longos.
-- Docs: https://github.com/rachartier/tiny-inline-diagnostic.nvim
return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  priority = 1000,
  opts = {
    preset = "modern",
    options = {
      show_source = { enabled = true },
      multilines = { enabled = true },
    },
  },
}
