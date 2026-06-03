require("config.lazy")
require("vimcommands.vim-options")
require("core.keymaps")
require("core.diagnostics")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.cmd([[highlight CursorLine cterm=NONE ctermbg=236 guibg=#2C2C2C]])

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    if vim.bo.modifiable then
      vim.cmd('normal! gg=G')
    end
  end,
})
