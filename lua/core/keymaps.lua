local M = {}

vim.g.mapleader = " "

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==",      { noremap = true, desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==",      { noremap = true, desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move selection up" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Split left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Split right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Split down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Split up" })

M.lsp_on_attach = function(_, bufnr)
  local opts = function(desc)
    return { buffer = bufnr, noremap = true, silent = true, desc = desc }
  end

  vim.keymap.set("n", "gD",          vim.lsp.buf.declaration,                              opts("Go to declaration"))
  vim.keymap.set("n", "gd",          vim.lsp.buf.definition,                               opts("Go to definition"))
  vim.keymap.set("n", "K",           vim.lsp.buf.hover,                                    opts("Hover docs"))
  vim.keymap.set("n", "gi",          vim.lsp.buf.implementation,                           opts("Go to implementation"))
  vim.keymap.set("n", "<C-s>",       vim.lsp.buf.signature_help,                           opts("Signature help"))
  vim.keymap.set("n", "<leader>rn",  vim.lsp.buf.rename,                                   opts("Rename"))
  vim.keymap.set("n", "gr",          vim.lsp.buf.references,                               opts("References"))
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,                     opts("Code action"))
  vim.keymap.set("n", "<leader>f",   function() vim.lsp.buf.format({ async = true }) end,  opts("Format"))

  vim.keymap.set("n", "[d",          vim.diagnostic.goto_prev,    opts("Prev diagnostic"))
  vim.keymap.set("n", "]d",          vim.diagnostic.goto_next,    opts("Next diagnostic"))
  vim.keymap.set("n", "<leader>e",   vim.diagnostic.open_float,   opts("Show diagnostic"))
  vim.keymap.set("n", "<leader>q",   vim.diagnostic.setloclist,   opts("Diagnostic list"))
end

return M
