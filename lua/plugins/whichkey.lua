-- Aperte <leader> (Espaço) e espere: o which-key mostra os atalhos disponíveis.
local spec = {}
for key, name in pairs(require("core.keygroups")) do
  spec[#spec + 1] = { "<leader>" .. key, group = name }
end
spec[#spec + 1] = { "<leader>1", desc = "Go to buffer 1…9" }
for i = 2, 9 do
  spec[#spec + 1] = { "<leader>" .. i, hidden = true }
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = spec,
  },
}
