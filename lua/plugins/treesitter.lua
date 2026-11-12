local parsers = {
  "lua", "ruby", "go", "python", "javascript", "typescript",
  "html", "css", "haskell", "c", "cpp", "sql", "c_sharp", "json", "clojure", "rust",
  "regex", "bash", -- usados pelo noice na linha de comando
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
      callback = function(ev)
        if pcall(vim.treesitter.start, ev.buf) then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
