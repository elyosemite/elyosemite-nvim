-- Selecionar/apagar/copiar blocos de código: vaf (função), dic (classe), cia (argumento).
-- Docs: https://github.com/nvim-treesitter/nvim-treesitter-textobjects/tree/main
local function select(query)
  return function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
  end
end

local function goto(fn, query)
  return function()
    require("nvim-treesitter-textobjects.move")[fn](query, "textobjects")
  end
end

local xo = { "x", "o" }
local nxo = { "n", "x", "o" }

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    select = { lookahead = true }, -- vaf funciona mesmo com o cursor antes da função
    move = { set_jumps = true },   -- <C-o> volta depois de ]f
  },
  keys = {
    { "af", select("@function.outer"), mode = xo, desc = "Around function" },
    { "if", select("@function.inner"), mode = xo, desc = "Inside function" },
    { "ac", select("@class.outer"), mode = xo, desc = "Around class" },
    { "ic", select("@class.inner"), mode = xo, desc = "Inside class" },
    { "aa", select("@parameter.outer"), mode = xo, desc = "Around argument" },
    { "ia", select("@parameter.inner"), mode = xo, desc = "Inside argument" },
    { "]f", goto("goto_next_start", "@function.outer"), mode = nxo, desc = "Next function" },
    { "[f", goto("goto_previous_start", "@function.outer"), mode = nxo, desc = "Prev function" },
  },
}
