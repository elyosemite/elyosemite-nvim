require("config.lazy")
require("vimcommands.vim-options")

-- Indent the whole file on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function()
        if vim.bo.modifiable then
            vim.cmd('normal! gg=G')  -- Reindenta todo o arquivo
        end
    end,
})

