-- Pule para qualquer lugar visível: aperte s, digite 1-2 letras do destino e o rótulo que aparecer.
-- Docs: https://github.com/folke/flash.nvim
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Jump (flash)" },
    { "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Select code block (flash)" },
  },
}
