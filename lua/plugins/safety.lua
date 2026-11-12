-- Rede de segurança: voltar a qualquer versão do arquivo e reabrir a última sessão.
return {
  -- Restaura os arquivos abertos na última vez, por pasta.
  -- Docs: https://github.com/folke/persistence.nvim
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore session (this folder)" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't save this session" },
    },
  },
}
