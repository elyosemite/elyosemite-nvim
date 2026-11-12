-- Smoke test: abre a config de verdade e falha se algo der erro.
-- Uso: nvim --headless -c "luafile tests/smoke.lua"
-- Sai com código 1 (e lista os erros) se qualquer verificação falhar.

local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
local failures = {}

local function check(name, fn)
  vim.v.errmsg = ""
  local ok, err = pcall(fn)
  if not ok then
    failures[#failures + 1] = name .. ": " .. tostring(err)
  elseif vim.v.errmsg ~= "" then
    failures[#failures + 1] = name .. ": " .. vim.v.errmsg
  end
  io.stdout:write(("%s %s\n"):format(ok and vim.v.errmsg == "" and "ok  " or "FAIL", name))
end

-- 1. Parsers (síncrono, para o CI esperar a compilação)
check("install treesitter parsers", function()
  -- SMOKE_SKIP_PARSERS="sql,..." pula parsers sabidamente quebrados num ambiente (ver ci.yml)
  local skip = vim.split(vim.env.SMOKE_SKIP_PARSERS or "", ",", { trimempty = true })
  local wanted = vim.tbl_filter(function(lang) return not vim.tbl_contains(skip, lang) end, require("core.parsers"))
  local ok = require("nvim-treesitter").install(wanted):wait(900000)
  assert(ok ~= false, "parser installation failed")
  -- a config já começou a instalar no startup; o install() acima pula esses, então espera todos
  local function missing()
    local installed = require("nvim-treesitter.config").get_installed()
    return vim.tbl_filter(function(lang) return not vim.tbl_contains(installed, lang) end, wanted)
  end
  vim.wait(300000, function() return #missing() == 0 end, 500)
  assert(#missing() == 0, "parsers not installed: " .. table.concat(missing(), ", "))
end)

-- 2. Plugins carregados sob demanda (no CI não há UI, então o VeryLazy não dispara sozinho)
check("VeryLazy plugins", function()
  vim.cmd("doautocmd User VeryLazy")
  vim.wait(500)
end)

-- 3. Arquivos de exemplo: abrem sem erro e com highlight do Treesitter
for _, file in ipairs(vim.fn.glob(root .. "/tests/samples/*", false, true)) do
  check("open " .. vim.fn.fnamemodify(file, ":t"), function()
    vim.cmd.edit(vim.fn.fnameescape(file))
    vim.wait(300)
    assert(vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()], "treesitter highlight not active")
  end)
end

-- 4. Recursos próprios da config
check("cheatsheet", function()
  require("core.cheatsheet").open()
  vim.cmd("close")
end)

check("every theme", function()
  local theme = require("core.theme")
  local original = theme.current
  for _, name in ipairs(theme.themes) do
    assert(theme.apply(name, false), "theme " .. name)
  end
  theme.apply(original, false)
end)

check("checkhealth nvyosemite has no errors", function()
  vim.cmd("checkhealth nvyosemite")
  local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  io.stdout:write(text .. "\n")
  assert(not text:find("ERROR"), "health check reported an error")
end)

if #failures > 0 then
  io.stdout:write("\nFailures:\n  " .. table.concat(failures, "\n  ") .. "\n")
  vim.cmd("cquit 1")
else
  io.stdout:write("\nAll checks passed\n")
  vim.cmd("qall!")
end
