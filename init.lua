require("config.lazy")
require("vimcommands.vim-options")

-- Mostra números absolutos e relativos ao mesmo tempo
vim.opt.number = true         -- Ativa a numeração de linha absoluta
vim.opt.relativenumber = true -- Ativa a numeração relativa

-- Adiciona uma linha destacando a linha atual do cursor
vim.opt.cursorline = true     -- Ativa o destaque da linha do cursor

-- Ajusta a cor da linha do cursor (caso queira personalizar)
vim.cmd([[highlight CursorLine cterm=NONE ctermbg=236 guibg=#2C2C2C]])

-- Configura a largura da linha de número
vim.opt.signcolumn = "yes"    -- Mantém a coluna de sinais ativa para evitar "pulos" ao abrir diagnósticos

-- Melhorias na visibilidade e navegação
vim.opt.scrolloff = 8         -- Mantém margem ao rolar para facilitar leitura
vim.opt.sidescrolloff = 8     -- Margem lateral ao rolar horizontalmente
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Salvando e aplicando essas mudanças
vim.cmd("set nu rnu") -- Ativa `number` e `relativenumber` via comando
vim.cmd("set cursorline") -- Ativa `cursorline` via comando


-- Indent the whole file on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    if vim.bo.modifiable then
      vim.cmd('normal! gg=G')  -- Reindenta todo o arquivo
    end
  end,
})

