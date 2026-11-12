# NvYosemite Editor for Geek

[![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?style=flat&logo=neovim&logoColor=white)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat&logo=lua&logoColor=white)](https://www.lua.org)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)](LICENSE)

A production-ready Neovim configuration that works out of the box while remaining fully hackable. Built with Lua and designed for developers who want functionality without the configuration fatigue.

## Features

- **Modular architecture**: one Lua module per plugin, easy to customize
- **LSP** with automatic server installation (Mason), for Lua, TypeScript/JavaScript, C#, Go, Python, SQL, Clojure and Rust
- **Autocompletion** with snippets (nvim-cmp + LuaSnip)
- **Fuzzy finder** (Telescope) and **file explorer** (Neo-tree)
- **Git**: inline blame and change signs (gitsigns) + LazyGit
- **Testing** from the editor (neotest: Go, Vitest, Rust, Lua)
- **Formatting** per language (conform.nvim)
- **Syntax highlighting** with Treesitter
- Multiple pre-installed color schemes

## Requirements

- **Neovim 0.12+**
- `git`, and a C compiler (MSVC, gcc, clang or zig) for Treesitter parsers
- [`tree-sitter` CLI](https://github.com/tree-sitter/tree-sitter) **0.25+** on your `PATH`. On Windows, use the real `tree-sitter.exe` (`cargo install tree-sitter-cli`) rather than the npm shim, which Neovim cannot run
- A [Nerd Font](https://www.nerdfonts.com/) in your terminal, for icons
- Optional: [`lazygit`](https://github.com/jesseduffield/lazygit), `ripgrep` (needed by live grep), `make` (Telescope fzf)

## Installation

```bash
# Linux / macOS
mv ~/.config/nvim{,.bak}            # backup existing config, if any
git clone https://github.com/elyosemite/elyosemite-nvim.git ~/.config/nvim
```

```powershell
# Windows
git clone https://github.com/elyosemite/elyosemite-nvim.git $env:LOCALAPPDATA\nvim
```

Launch `nvim` and wait: plugins, LSP servers and Treesitter parsers install automatically. Plugin versions are pinned in `lazy-lock.json`.

## How to read the key mappings

Key mappings below use Neovim notation:

| Notation      | What to press                                                       |
|---------------|---------------------------------------------------------------------|
| `<leader>`    | **Space**                                                           |
| `<C-n>`       | **Ctrl + n** (held together)                                        |
| `<S-h>`       | **Shift + h** (the same as typing a capital `H`)                    |
| `<A-j>`       | **Alt + j**                                                         |
| `<CR>`        | **Enter**                                                           |
| `<Tab>`       | **Tab**                                                             |
| `<leader>ff`  | **Space**, then **f**, then **f**: *one after another*, not together |
| `gd`          | **g**, then **d**, one after another                                |
| `[d` / `]d`   | **[** then **d** / **]** then **d**                                  |

Mode column: **n** = Normal (default mode, press `Esc` to return), **i** = Insert (typing text), **v** = Visual (selection, enter with `v` or `V`).

> **Tip:** press **Space** and wait a moment. [which-key](https://github.com/folke/which-key.nvim) shows a popup with every available `<leader>` mapping.

## Key mappings

### Files and search (Telescope)

| Mode | Keys         | Action                       |
|------|--------------|------------------------------|
| n    | `<C-p>`      | Find files                   |
| n    | `<leader>ff` | Find files                   |
| n    | `<leader>fg` | Search text in project (grep) |
| n    | `<leader>fb` | List open buffers            |
| n    | `<leader>fh` | Search help                  |

Inside Telescope: type to filter, `<C-n>` / `<C-p>` or arrows to move, `<CR>` to open, `<C-x>` / `<C-v>` to open in a horizontal / vertical split, `Esc` to close.

### File explorer (Neo-tree)

| Mode | Keys    | Action                  |
|------|---------|-------------------------|
| n    | `<C-n>` | Toggle the file explorer |

Inside Neo-tree: `<CR>` open, `a` new file (end the name with `/` for a folder), `d` delete, `r` rename, `c` copy, `m` move, `H` toggle hidden files, `?` show all keys.

### Buffers (open files) and windows

| Mode | Keys                       | Action                        |
|------|----------------------------|-------------------------------|
| n    | `<S-h>` / `<S-l>`          | Previous / next buffer        |
| n    | `<leader>1` … `<leader>9`  | Go to buffer by its number    |
| n    | `<leader>x`                | Close current buffer          |
| n    | `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Move to the split left / down / up / right |

### Editing

| Mode | Keys              | Action                       |
|------|-------------------|------------------------------|
| n    | `<A-j>` / `<A-k>` | Move current line down / up  |
| v    | `<A-j>` / `<A-k>` | Move selected lines down / up |
| n    | `<leader>gf`      | Format file (falls back to LSP) |

Brackets and quotes close automatically (nvim-autopairs).

### Autocompletion (Insert mode)

| Keys                      | Action                                  |
|---------------------------|-----------------------------------------|
| `<C-Space>`               | Open the completion menu                |
| `<C-j>` / `<C-k>`         | Next / previous suggestion              |
| `<Tab>` / `<S-Tab>`       | Next / previous suggestion, or jump between snippet fields |
| `<CR>`                    | Confirm the selected suggestion         |
| `<C-e>`                   | Close the menu                          |
| `<C-d>` / `<C-u>`         | Scroll the documentation window         |

### Code navigation (LSP)

Active in any file with a language server attached.

| Mode | Keys         | Action                         |
|------|--------------|--------------------------------|
| n    | `gd`         | Go to definition               |
| n    | `gD`         | Go to declaration              |
| n    | `gi`         | Go to implementation           |
| n    | `gr`         | List references                |
| n    | `K`          | Hover documentation            |
| n    | `<C-s>`      | Signature help                 |
| n    | `<leader>rn` | Rename symbol                  |
| n, v | `<leader>ca` | Code actions (quick fixes)     |
| n    | `<C-o>`      | Jump back (after `gd`, etc.)   |

### Diagnostics (errors and warnings)

| Mode | Keys        | Action                              |
|------|-------------|-------------------------------------|
| n    | `[d` / `]d` | Previous / next diagnostic          |
| n    | `<leader>e` | Show the diagnostic under the cursor |
| n    | `<leader>q` | List all diagnostics of the file    |

### Git

| Mode | Keys         | Action        |
|------|--------------|---------------|
| n    | `<leader>gg` | Open LazyGit  |

The author and date of the last change appear at the end of the current line (git blame), and changed lines are marked in the left column.

### Tests (neotest)

| Mode | Keys         | Action                  |
|------|--------------|-------------------------|
| n    | `<leader>tt` | Run nearest test        |
| n    | `<leader>tf` | Run all tests in file   |
| n    | `<leader>ts` | Toggle test summary     |
| n    | `<leader>to` | Toggle test output      |
| n    | `<leader>tS` | Stop running tests      |

## Changing the theme

| Mode | Keys / command  | Action                                                  |
|------|-----------------|---------------------------------------------------------|
| n    | `<leader>th`    | Open the theme picker                                   |
| n    | `:Theme`        | Open the theme picker                                   |
| n    | `:Theme <name>` | Apply a theme directly (`Tab` completes the name)       |

The choice is **saved and restored** on the next start. No restart is needed to switch.

Available themes: `everforest` (default), `catppuccin-latte`, `catppuccin-frappe`, `catppuccin-macchiato`, `catppuccin-mocha`, `gruvbox`, `nightfox`, `nordfox`, `carbonfox`, `duskfox`, `dawnfox` and `terafox`.

`:colorscheme <name>` also works, but it only lasts for the current session.

**Add a theme:**

1. Create `lua/plugins/themes/<theme>.lua` with the plugin spec (`lazy = true`, and don't call `:colorscheme` in it).
2. Register it in `lua/plugins/themes/init.lua`.
3. Add its colorscheme name(s) to `M.themes` in `lua/core/theme.lua`. Change `M.default` there to pick the theme for new installs.

## Useful commands

Type them in Normal mode, starting with `:`, then press `Enter`.

| Command                | What it does                                       |
|------------------------|----------------------------------------------------|
| `:Lazy`                | Plugin manager (`U` update, `S` sync, `X` clean)   |
| `:Mason`               | Install / update LSP servers, formatters, linters  |
| `:TSUpdate`            | Update Treesitter parsers                          |
| `:TSInstall <lang>`    | Install a parser for a new language                |
| `:LspInfo`             | Show language servers attached to the buffer       |
| `:checkhealth`         | Diagnose problems in the setup                     |
| `:RustLsp runnables`   | Pick and run a Rust target (rustaceanvim)          |
| `:Neotree reveal`      | Show the current file in the explorer              |

## Project structure

```
nvim/
├── init.lua                 # Entry point
├── lazy-lock.json           # Pinned plugin versions
└── lua/
    ├── config/lazy.lua      # lazy.nvim bootstrap
    ├── core/                # Options, keymaps, diagnostics, autocmds, theme switcher
    └── plugins/
        ├── init.lua         # List of all plugins
        ├── lsp/
        │   ├── mason-config.lua   # LSP setup (vim.lsp.config + Mason)
        │   └── servers/           # Per-language LSP settings
        ├── themes/          # Color scheme plugins (switch with :Theme)
        └── *.lua            # One file per plugin
```

## Customizing

### Add a plugin

1. Create `lua/plugins/my-plugin.lua` returning a [lazy.nvim spec](https://lazy.folke.io/spec):

   ```lua
   return {
     "author/plugin",
     opts = {},
   }
   ```

2. Register it in `lua/plugins/init.lua`:

   ```lua
   local my_plugin = require("plugins.my-plugin")
   -- ...
   Plugins.all_plugins = {
     -- ...
     my_plugin,
   }
   ```

### Add a language server

1. Add the server name (as listed by nvim-lspconfig) to `servers` in `lua/plugins/lsp/mason-config.lua`.
2. Optional: for custom settings, create `lua/plugins/lsp/servers/<lang>.lua`:

   ```lua
   return {
     name = "server_name",
     config = { settings = { --[[ ... ]] } },
   }
   ```

   and add it to `custom_servers` in the same file.

### Add a formatter

Add the filetype in `lua/plugins/formatter.lua` and install the tool with `:Mason`.

## Troubleshooting

- Run `:checkhealth` to diagnose issues.
- **Treesitter parsers fail to compile:** check that `tree-sitter --version` works and reports 0.25+, and that a C compiler is available.
- **LSP not starting:** open `:Mason` to confirm the server is installed, then `:LspInfo`.
- **Icons show as squares:** set a Nerd Font in your terminal.
