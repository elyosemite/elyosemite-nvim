local M = {}

vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>write<CR><Esc>", { desc = "Save file" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { desc = "Clear search highlight" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==",      { noremap = true, desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==",      { noremap = true, desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move selection up" })

-- Buffer navigation
vim.keymap.set("n", "<S-h>",      "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>",      "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>x",  "<cmd>bdelete<CR>",             { desc = "Close buffer" })

for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Buffer " .. i })
end

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Split left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Split right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Split down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Split up" })

M.lsp_on_attach = function(bufnr)
  local opts = function(desc)
    return { buffer = bufnr, noremap = true, silent = true, desc = desc }
  end

  vim.keymap.set("n", "gD",          vim.lsp.buf.declaration,                              opts("Go to declaration"))
  vim.keymap.set("n", "gd",          vim.lsp.buf.definition,                               opts("Go to definition"))
  vim.keymap.set("n", "K",           vim.lsp.buf.hover,                                    opts("Hover docs"))
  vim.keymap.set("i", "<C-k>",       vim.lsp.buf.signature_help,                           opts("Signature help"))
  vim.keymap.set("n", "gi",          vim.lsp.buf.implementation,                           opts("Go to implementation"))
  vim.keymap.set("n", "<leader>rn",  vim.lsp.buf.rename,                                   opts("Rename"))
  vim.keymap.set("n", "gr",          vim.lsp.buf.references,                               opts("References"))
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,                     opts("Code action"))
  -- Formatação: <leader>gf (conform, com fallback para o LSP)

  vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts("Prev diagnostic"))
  vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end,  opts("Next diagnostic"))
  vim.keymap.set("n", "<leader>e",   vim.diagnostic.open_float,   opts("Show diagnostic"))
  vim.keymap.set("n", "<leader>q",   vim.diagnostic.setloclist,   opts("Diagnostic list"))
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
  callback = function(ev)
    M.lsp_on_attach(ev.buf)

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end
  end,
})

return M
