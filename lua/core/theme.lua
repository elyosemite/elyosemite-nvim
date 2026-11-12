-- Troca de tema em tempo de execução, com a escolha salva entre sessões.
--   :Theme             abre o seletor
--   :Theme <nome>      aplica direto (Tab completa)
--   <leader>th         abre o seletor

local M = {}

M.default = "everforest"

-- Para adicionar um tema: crie o spec em lua/plugins/themes/, registre em
-- lua/plugins/themes/init.lua e coloque aqui os nomes de :colorscheme dele.
M.themes = {
  "everforest",
  "catppuccin-latte",
  "catppuccin-frappe",
  "catppuccin-macchiato",
  "catppuccin-mocha",
  "gruvbox",
  "nightfox",
  "nordfox",
  "carbonfox",
  "duskfox",
  "dawnfox",
  "terafox",
}

local state_file = vim.fn.stdpath("state") .. "/nvyosemite-theme"

local function read_saved()
  local ok, lines = pcall(vim.fn.readfile, state_file)
  if ok and lines[1] and lines[1] ~= "" then
    return lines[1]
  end
end

local function save(name)
  pcall(vim.fn.writefile, { name }, state_file)
end

--- Aplica um colorscheme. Com persist = true, ele vira o padrão das próximas sessões.
function M.apply(name, persist)
  local ok, err = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify(("Theme '%s' not found: %s"):format(name, err), vim.log.levels.ERROR)
    return false
  end
  if persist then
    save(name)
  end
  return true
end

function M.pick()
  local current = vim.g.colors_name
  vim.ui.select(M.themes, {
    prompt = "Theme",
    format_item = function(name)
      return name == current and (name .. "  (current)") or name
    end,
  }, function(choice)
    if choice and M.apply(choice, true) then
      vim.notify("Theme: " .. choice)
    end
  end)
end

function M.setup()
  if not M.apply(read_saved() or M.default, false) then
    M.apply(M.default, false)
  end

  vim.api.nvim_create_user_command("Theme", function(opts)
    if opts.args == "" then
      M.pick()
    elseif M.apply(opts.args, true) then
      vim.notify("Theme: " .. opts.args)
    end
  end, {
    nargs = "?",
    desc = "Switch theme",
    complete = function(lead)
      return vim.tbl_filter(function(name)
        return name:find(lead, 1, true) == 1
      end, M.themes)
    end,
  })

  vim.keymap.set("n", "<leader>th", M.pick, { desc = "Pick theme" })
end

return M
