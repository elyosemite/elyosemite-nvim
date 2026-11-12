-- Buscar e substituir no projeto inteiro, com preview das mudanças.
-- Docs: https://github.com/MagicDuck/grug-far.nvim
return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  opts = { headerMaxWidth = 80 },
  keys = {
    {
      "<leader>sr",
      function()
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        require("grug-far").open({
          transient = true,
          -- começa filtrando pelo tipo do arquivo atual; apague o filtro para buscar em tudo
          prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and replace in project",
    },
  },
}
