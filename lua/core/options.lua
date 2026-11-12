vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Comportamentos que quem vem de outro editor espera
vim.opt.clipboard = "unnamedplus" -- copiar/colar com o sistema
vim.opt.ignorecase = true         -- busca ignora maiúsculas...
vim.opt.smartcase = true          -- ...a menos que você digite uma
vim.opt.undofile = true           -- desfazer sobrevive ao fechar o arquivo
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.mouse = "a"
vim.opt.confirm = true            -- pergunta em vez de falhar ao sair sem salvar
vim.opt.updatetime = 250
