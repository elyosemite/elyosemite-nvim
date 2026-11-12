-- Linha de comando em popup e mensagens como notificação (acaba o "Press ENTER").
-- Docs: https://github.com/folke/noice.nvim
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    lsp = {
      -- documentação do LSP renderizada com markdown e treesitter
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    presets = {
      bottom_search = true,         -- busca (/ e ?) continua embaixo
      command_palette = true,       -- linha de comando e sugestões juntas no topo
      long_message_to_split = true, -- mensagens longas abrem num split
      lsp_doc_border = true,
    },
  },
}
