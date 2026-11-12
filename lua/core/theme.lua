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
  "tokyonight-night",
  "tokyonight-storm",
  "tokyonight-moon",
  "tokyonight-day",
  "kanagawa-wave",
  "kanagawa-dragon",
  "kanagawa-lotus",
  "rose-pine-main",
  "rose-pine-moon",
  "rose-pine-dawn",
  "onedark",
  "onedark_vivid",
  "onelight",
  "github_dark",
  "github_dark_dimmed",
  "github_light",
}

local state_file = vim.fn.stdpath("state") .. "/nvyosemite-theme"

-- Variante clara de cada tema escuro, usada por <leader>ub.
-- Temas sem variante própria (everforest, gruvbox) trocam vim.o.background.
M.light_of = {
  ["catppuccin-mocha"] = "catppuccin-latte",
  ["catppuccin-macchiato"] = "catppuccin-latte",
  ["catppuccin-frappe"] = "catppuccin-latte",
  nightfox = "dawnfox",
  nordfox = "dawnfox",
  carbonfox = "dawnfox",
  duskfox = "dawnfox",
  terafox = "dawnfox",
  ["tokyonight-night"] = "tokyonight-day",
  ["tokyonight-storm"] = "tokyonight-day",
  ["tokyonight-moon"] = "tokyonight-day",
  ["kanagawa-wave"] = "kanagawa-lotus",
  ["kanagawa-dragon"] = "kanagawa-lotus",
  ["rose-pine-main"] = "rose-pine-dawn",
  ["rose-pine-moon"] = "rose-pine-dawn",
  onedark = "onelight",
  onedark_vivid = "onelight",
  github_dark = "github_light",
  github_dark_dimmed = "github_light",
}

-- Variante escura padrão de cada tema claro (quando não há uma anterior para voltar)
M.dark_of = {
  ["catppuccin-latte"] = "catppuccin-mocha",
  dawnfox = "nightfox",
  ["tokyonight-day"] = "tokyonight-night",
  ["kanagawa-lotus"] = "kanagawa-wave",
  ["rose-pine-dawn"] = "rose-pine-main",
  onelight = "onedark",
  github_light = "github_dark",
}

-- Fundo transparente: deixa aparecer o fundo do terminal (útil com terminal transparente).
-- Só vale para temas escuros: num tema claro sobre terminal escuro, o texto ficaria
-- escuro sobre escuro e as janelas flutuantes (menu, popups) claras sobre o arquivo escuro.
M.transparent = true

-- Grupos que pintam o fundo da área de edição (não inclui janelas flutuantes)
local transparent_groups = {
  "Normal", "NormalNC", "SignColumn", "LineNr", "LineNrAbove", "LineNrBelow",
  "FoldColumn", "EndOfBuffer", "NonText", "WinBar", "WinBarNC", "StatusLine", "StatusLineNC",
}

-- O menu de contexto (nvzone/menu, via volt) calcula as cores a partir do fundo do tema
-- uma única vez, ao carregar. Recalcula a cada troca de tema, antes de limpar o fundo.
local function refresh_menu_colors()
  if package.loaded["volt.highlights"] then
    package.loaded["volt.highlights"] = nil
    pcall(require, "volt.highlights")
  end
end

local function on_colorscheme()
  refresh_menu_colors()
  if not M.transparent or vim.o.background ~= "dark" then
    return
  end
  for _, group in ipairs(transparent_groups) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    hl.bg, hl.ctermbg = nil, nil
    vim.api.nvim_set_hl(0, group, hl)
  end
end

local function read_saved()
  local ok, lines = pcall(vim.fn.readfile, state_file)
  if ok and lines[1] and lines[1] ~= "" then
    return lines[1], lines[2], lines[3]
  end
end

local function save(name)
  pcall(vim.fn.writefile, { name, vim.o.background, tostring(M.transparent) }, state_file)
end

--- Aplica um colorscheme. Com persist = true, ele vira o padrão das próximas sessões.
function M.apply(name, persist)
  -- nem todo tema ajusta o background sozinho (ex.: kanagawa-lotus)
  if M.dark_of[name] then
    vim.o.background = "light"
  elseif M.light_of[name] then
    vim.o.background = "dark"
  end
  local ok, err = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify(("Theme '%s' not found: %s"):format(name, err), vim.log.levels.ERROR)
    return false
  end
  -- alguns temas (kanagawa, rose-pine) gravam colors_name sem a variante
  M.current = name
  if persist then
    save(name)
  end
  return true
end

--- Seletor com preview ao vivo: o tema muda enquanto você navega.
--- Enter confirma e salva; Esc volta ao tema anterior.
function M.pick()
  local original = M.current
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  -- Aplica o tema só quando você para num item: trocar de tema custa ~100 ms
  -- (e mais na primeira vez de cada pacote), então rolar a lista fica fluido.
  local timer = assert(vim.uv.new_timer())
  local function preview()
    timer:stop()
    timer:start(120, 0, vim.schedule_wrap(function()
      local entry = action_state.get_selected_entry()
      if entry and entry.value ~= M.current then
        M.apply(entry.value, false)
      end
    end))
  end

  local function move(step)
    return function(bufnr)
      step(bufnr)
      preview()
    end
  end

  local function cancel(bufnr)
    timer:stop()
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
          display = name
            .. (M.dark_of[name] and "  (light)" or "")
            .. (name == original and "  (current)" or ""),
        }
      end,
    }),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(_, map)
      actions.select_default:replace(function(bufnr)
        timer:stop()
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

local last_dark = {}

--- Troca entre a variante clara e a escura do tema atual.
function M.toggle_background()
  local name = M.current
  local target
  if M.light_of[name] then
    target = M.light_of[name]
    last_dark[target] = name
  elseif M.dark_of[name] then
    target = last_dark[name] or M.dark_of[name]
  else
    vim.o.background = vim.o.background == "dark" and "light" or "dark"
    target = name
  end
  if M.apply(target, true) then
    vim.notify(("Theme: %s (%s)"):format(target, vim.o.background))
  end
end

--- Liga/desliga o fundo transparente e salva a escolha.
function M.set_transparent(on)
  M.transparent = on
  save(M.current)
  M.apply(M.current, false) -- reaplica o tema para restaurar ou limpar os fundos
end

function M.setup()
  local saved, background, transparent = read_saved()
  if background == "light" or background == "dark" then
    vim.o.background = background
  end
  M.transparent = transparent ~= "false"

  -- Reaplica a transparência sempre que um tema é carregado (também pelo :colorscheme)
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("nvyosemite_transparent", { clear = true }),
    callback = on_colorscheme,
  })
  if not M.apply(saved or M.default, false) then
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
  vim.keymap.set("n", "<leader>ub", M.toggle_background, { desc = "Toggle light/dark theme" })
  Snacks.toggle.new({
    name = "Transparent background (dark themes)",
    get = function() return M.transparent end,
    set = M.set_transparent,
  }):map("<leader>uT")
end

return M
