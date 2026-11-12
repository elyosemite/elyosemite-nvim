-- :checkhealth nvyosemite
-- Verifica as ferramentas externas que a config precisa.
-- Docs: https://neovim.io/doc/user/health.html

local M = {}

local health = vim.health

local function version_of(cmd)
  local ok, out = pcall(vim.fn.system, { cmd, "--version" })
  if not ok or vim.v.shell_error ~= 0 then
    return nil
  end
  return out:match("(%d+%.%d+%.?%d*)")
end

local function at_least(v, major, minor)
  local a, b = v:match("^(%d+)%.(%d+)")
  a, b = tonumber(a), tonumber(b)
  return a > major or (a == major and b >= minor)
end

local function check_tool(cmd, required, why, install)
  if vim.fn.executable(cmd) == 1 then
    health.ok(("`%s` found"):format(cmd))
    return true
  end
  local report = required and health.error or health.warn
  report(("`%s` not found: %s"):format(cmd, why), install and { install } or nil)
  return false
end

local function check_treesitter_cli()
  local path = vim.fn.exepath("tree-sitter")
  if path == "" then
    health.error("`tree-sitter` CLI not found: Treesitter parsers cannot be compiled", {
      "Install with `cargo install tree-sitter-cli`",
      "Or download a release: https://github.com/tree-sitter/tree-sitter/releases",
    })
    return
  end
  if vim.fn.has("win32") == 1 and not path:lower():match("%.exe$") then
    health.error(("`tree-sitter` resolves to `%s`, a script Neovim cannot run"):format(path), {
      "This is the npm shim. Use the real binary: `cargo install tree-sitter-cli`,",
      "or copy node_modules/tree-sitter-cli/tree-sitter.exe to a folder on PATH",
    })
    return
  end
  local v = version_of("tree-sitter")
  if not v then
    health.error("`tree-sitter --version` failed")
  elseif not at_least(v, 0, 25) then
    health.error(("`tree-sitter` %s is too old, 0.25+ is required"):format(v))
  else
    health.ok(("`tree-sitter` %s"):format(v))
  end
end

function M.check()
  health.start("Neovim")
  if vim.fn.has("nvim-0.12") == 1 then
    health.ok("Neovim " .. tostring(vim.version()))
  else
    health.error("Neovim 0.12+ is required, found " .. tostring(vim.version()))
  end

  health.start("Treesitter")
  check_treesitter_cli()
  local compilers = { "cc", "gcc", "clang", "zig", "cl" }
  local found = vim.tbl_filter(function(c) return vim.fn.executable(c) == 1 end, compilers)
  if #found > 0 then
    health.ok("C compiler: " .. table.concat(found, ", "))
  elseif vim.fn.has("win32") == 1 then
    health.info("No C compiler on PATH; tree-sitter can still find MSVC through vswhere if Visual Studio Build Tools are installed")
  else
    health.error("No C compiler found (cc, gcc, clang or zig)")
  end

  health.start("Tools")
  check_tool("git", true, "plugins cannot be installed")
  check_tool("rg", false, "project search (<leader>fg, <leader>sr) will not work", "https://github.com/BurntSushi/ripgrep#installation")
  check_tool("node", false, "several language servers and formatters installed by Mason need Node.js", "https://nodejs.org")
  check_tool("lazygit", false, "<leader>gg will not work", "https://github.com/jesseduffield/lazygit#installation")
  check_tool("make", false, "telescope-fzf-native cannot be built (search still works, just slower)")

  health.start("Font")
  health.info("Icons need a Nerd Font in your terminal: https://www.nerdfonts.com. If you see squares or question marks, change the terminal font.")
end

return M
