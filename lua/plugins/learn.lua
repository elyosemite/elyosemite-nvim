-- Ajuda a aprender Vim enquanto usa.
return {
  -- Mostra na linha onde w, b, e, $, ^ levariam o cursor. Desligado por padrão.
  -- Docs: https://github.com/tris203/precognition.nvim
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = {
      startVisible = false, -- custa a cada movimento do cursor; liga com <leader>up
      showBlankVirtLine = false,
    },
    config = function(_, opts)
      local precognition = require("precognition")
      precognition.setup(opts)
      Snacks.toggle.new({
        name = "Motion hints",
        get = precognition.is_visible,
        set = function(on)
          if on then precognition.show() else precognition.hide() end
        end,
      }):map("<leader>up")
    end,
  },

  -- Modo treino: avisa quando você repete jjjj em vez de usar 5j. Desligado por padrão.
  -- Docs: https://github.com/m4xshen/hardtime.nvim
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "Hardtime",
    opts = {
      enabled = false,
      disable_mouse = false, -- o menu de clique direito continua funcionando
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          Snacks.toggle.new({
            name = "Training mode (hardtime)",
            get = function()
              return package.loaded.hardtime ~= nil and require("hardtime").is_plugin_enabled
            end,
            set = function(on)
              local hardtime = require("hardtime") -- o lazy.nvim carrega o plugin aqui
              if on then hardtime.enable() else hardtime.disable() end
            end,
          }):map("<leader>uH")
        end,
      })
    end,
  },
}
