-- Aperte <leader> (Espaço) e espere: o which-key mostra os atalhos disponíveis.
local hidden_buffers = {}
for i = 2, 9 do
  hidden_buffers[#hidden_buffers + 1] = { "<leader>" .. i, hidden = true }
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>b", group = "Buffers" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git / Format" },
      { "<leader>r", group = "Rename" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Test / Theme" },
      { "<leader>u", group = "Toggles" },
      { "<leader>1", desc = "Go to buffer 1…9" },
      hidden_buffers,
    },
  },
}
