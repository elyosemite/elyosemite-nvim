-- Todos os temas ficam instalados; o ativo é escolhido em tempo de execução
-- com :Theme ou <leader>th (ver lua/core/theme.lua).
return {
  specs = {
    require("plugins.themes.everforest"),
    require("plugins.themes.catppuccin"),
    require("plugins.themes.gruvbox"),
    require("plugins.themes.nightfox"),
    require("plugins.themes.tokyonight"),
    require("plugins.themes.kanagawa"),
    require("plugins.themes.rosepine"),
    require("plugins.themes.onedarkpro"),
    require("plugins.themes.github"),
  },
}
