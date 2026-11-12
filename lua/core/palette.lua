-- Paleta de comandos, como o Ctrl+Shift+P do VS Code.
-- Busque pela ação ("format", "theme") e aperte Enter para executar.
--   <leader><leader>   abre

local M = {}

-- Comandos sem atalho que vale a pena achar pela busca
M.commands = {
  { desc = "Manage plugins", cmd = "Lazy" },
  { desc = "Manage language servers and tools", cmd = "Mason" },
  { desc = "Diagnose the setup", cmd = "checkhealth" },
  { desc = "Language servers on this buffer", cmd = "LspInfo" },
  { desc = "Update Treesitter parsers", cmd = "TSUpdate" },
  { desc = "Show all keys", cmd = "Cheatsheet" },
}

local function items()
  local list = {}
  for _, entries in pairs(require("core.cheatsheet").collect(vim.api.nvim_get_current_buf())) do
    for _, e in ipairs(entries) do
      -- só atalhos do modo Normal podem ser executados daqui
      if e.modes:find("n") and not e.lhs:find("…") then
        list[#list + 1] = { desc = e.desc, hint = e.lhs, keys = e.lhs }
      end
    end
  end
  for _, c in ipairs(M.commands) do
    list[#list + 1] = { desc = c.desc, hint = ":" .. c.cmd, cmd = c.cmd }
  end
  table.sort(list, function(a, b) return a.desc < b.desc end)
  return list
end

local function run(item)
  if item.cmd then
    vim.cmd(item.cmd)
    return
  end
  local keys = item.keys:gsub("^<leader>", vim.g.mapleader or "\\")
  vim.api.nvim_feedkeys(vim.keycode(keys), "m", false)
end

function M.open()
  local list = items()
  local width = 0
  for _, item in ipairs(list) do
    width = math.max(width, vim.fn.strdisplaywidth(item.desc))
  end

  vim.ui.select(list, {
    prompt = "Command palette",
    format_item = function(item)
      return item.desc .. string.rep(" ", width - vim.fn.strdisplaywidth(item.desc) + 2) .. item.hint
    end,
  }, function(item)
    if item then
      -- espera o seletor fechar antes de executar
      vim.schedule(function() run(item) end)
    end
  end)
end

function M.setup()
  vim.keymap.set("n", "<leader><leader>", M.open, { desc = "Command palette" })
end

return M
