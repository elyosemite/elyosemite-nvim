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

--- Seletor com preview ao vivo: o tema muda enquanto você navega.
--- Enter confirma e salva; Esc volta ao tema anterior.
function M.pick()
  local original = vim.g.colors_name
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local function preview()
    local entry = action_state.get_selected_entry()
    if entry then
      M.apply(entry.value, false)
    end
  end

  local function move(step)
    return function(bufnr)
      step(bufnr)
      preview()
    end
  end

  local function cancel(bufnr)
    actions.close(bufnr)
    M.apply(original, false)
  end

  require("telescope.pickers").new(require("telescope.themes").get_dropdown({ previewer = false }), {
    prompt_title = "Theme (Enter to keep, Esc to undo)",
    finder = require("telescope.finders").new_table({
      results = M.themes,
      entry_maker = function(name)
        return {
          value = name,
          ordinal = name,
          display = name == original and (name .. "  (current)") or name,
        }
      end,
    }),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(_, map)
      actions.select_default:replace(function(bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(bufnr)
        if entry and M.apply(entry.value, true) then
          vim.notify("Theme: " .. entry.value)
        end
      end)
      for _, key in ipairs({ "<C-n>", "<Down>", "<Tab>" }) do
        map({ "i", "n" }, key, move(actions.move_selection_next))
      end
      for _, key in ipairs({ "<C-p>", "<Up>", "<S-Tab>" }) do
        map({ "i", "n" }, key, move(actions.move_selection_previous))
      end
      map("n", "j", move(actions.move_selection_next))
      map("n", "k", move(actions.move_selection_previous))
      map({ "i", "n" }, "<Esc>", cancel)
      map({ "i", "n" }, "<C-c>", cancel)
      return true
    end,
  }):find()
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
