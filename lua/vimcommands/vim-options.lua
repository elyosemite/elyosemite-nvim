vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Mover linhas para cima/baixo no modo normal
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { noremap = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { noremap = true })

-- Mover linhas selecionadas para cima/baixo no modo visual
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true })
