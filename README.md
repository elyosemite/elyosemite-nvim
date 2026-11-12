# NvYosemite Editor for Geek

[![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?style=flat&logo=neovim&logoColor=white)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat&logo=lua&logoColor=white)](https://www.lua.org)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)](LICENSE)

A Neovim configuration you can use on day one, even if you only know a few Vim commands. Opinionated defaults, a friendly UI, and every key documented. Each row below links to the official docs, so this page stays short.

## Requirements

- **Neovim 0.12+**
- `git` and a C compiler (MSVC, gcc, clang or zig)
- [`tree-sitter` CLI](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md) **0.25+**. On Windows use the real `tree-sitter.exe` (`cargo install tree-sitter-cli`), not the npm shim
- A [Nerd Font](https://www.nerdfonts.com/) in your terminal
- Optional: [`lazygit`](https://github.com/jesseduffield/lazygit), [`ripgrep`](https://github.com/BurntSushi/ripgrep) (project search), `make`

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

Run `nvim` and wait: plugins, language servers, formatters and parsers install by themselves.

## How to read the keys

| Notation     | Press                                  |
|--------------|----------------------------------------|
| `<leader>`   | **Space**                              |
| `<C-n>`      | **Ctrl + n**, together                 |
| `<S-h>`      | **Shift + h**                          |
| `<A-j>`      | **Alt + j**                            |
| `<CR>`       | **Enter**                              |
| `<leader>ff` | **Space**, then **f**, then **f**, one after another |

Mode: **n** Normal, **i** Insert, **v** Visual. The cursor line changes color with the mode ([modes.nvim](https://github.com/mvllow/modes.nvim)). Docs: [key notation](https://neovim.io/doc/user/intro.html#key-notation) · [modes](https://neovim.io/doc/user/intro.html#vim-modes).

> **Lost?** Press **Space** and wait: [which-key](https://github.com/folke/which-key.nvim) shows the next keys. Press **Space ?** (`<leader>?` or `:Cheatsheet`) to see every key on one screen, or **Space Space** to search actions by name and run them. **Right-click** (or `<C-t>`) opens a [context menu](https://github.com/nvzone/menu).

## Keys

### Find (Telescope)

| Mode | Keys         | Action                 | Docs |
|------|--------------|------------------------|------|
| n    | `<C-p>` / `<leader>ff` | Find files   | [find_files](https://github.com/nvim-telescope/telescope.nvim#file-pickers) |
| n    | `<leader>fg` | Search text in project | [live_grep](https://github.com/nvim-telescope/telescope.nvim#file-pickers) |
| n    | `<leader>fb` | Open buffers           | [buffers](https://github.com/nvim-telescope/telescope.nvim#vim-pickers) |
| n    | `<leader>fh` | Search help            | [help_tags](https://github.com/nvim-telescope/telescope.nvim#vim-pickers) |

Inside the picker: [default mappings](https://github.com/nvim-telescope/telescope.nvim#default-mappings).

### Files (Neo-tree)

| Mode | Keys    | Action              | Docs |
|------|---------|---------------------|------|
| n    | `<C-n>` | Toggle file explorer | [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim#quickstart) |

Inside the tree, press `?` for all keys.

### Buffers and windows

| Mode | Keys                            | Action                     | Docs |
|------|---------------------------------|----------------------------|------|
| n    | `<S-h>` / `<S-l>`               | Previous / next buffer     | [bufferline](https://github.com/akinsho/bufferline.nvim#usage) |
| n    | `<leader>1` … `<leader>9`       | Go to buffer N             | [bufferline](https://github.com/akinsho/bufferline.nvim#usage) |
| n    | `<leader>x`                     | Close buffer               | [:bdelete](https://neovim.io/doc/user/windows.html#%3Abdelete) |
| n    | `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Move between splits        | [CTRL-W](https://neovim.io/doc/user/windows.html#CTRL-W_h) |

### Editing

| Mode | Keys              | Action                      | Docs |
|------|-------------------|-----------------------------|------|
| n, i, v | `<C-s>`        | Save file                   | [:write](https://neovim.io/doc/user/editing.html#%3Awrite) |
| n    | `<Esc>`           | Clear search highlight      | [:nohlsearch](https://neovim.io/doc/user/pattern.html#%3Anohlsearch) |
| n    | `u` / `<C-r>`     | Undo / redo (kept after closing the file) | [undo](https://neovim.io/doc/user/undo.html#undo-commands) |
| n    | `<leader>uu`      | Undo tree: go back to any earlier version | [undotree](https://neovim.io/doc/user/plugins.html#undotree-plugin) |
| n, v | `<A-j>` / `<A-k>` | Move line(s) down / up      | [:move](https://neovim.io/doc/user/change.html#%3Amove) |
| n, v | `s` + letters | Jump anywhere on screen (type the label shown) | [flash](https://github.com/folke/flash.nvim#-usage) |
| n, v | `S`               | Select a code block         | [flash](https://github.com/folke/flash.nvim#-usage) |
| n    | `<leader>gf`      | Format file                 | [conform](https://github.com/stevearc/conform.nvim) |
| n, v | `gcc` / `gc`      | Comment line / selection    | [commenting](https://neovim.io/doc/user/various.html#commenting) |
| i    | `( [ { " '`       | Close pairs automatically   | [autopairs](https://github.com/windwp/nvim-autopairs) |

### Screen

The start screen ([dashboard](https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md)) has one-key shortcuts: `f` find, `r` recent, `s` restore session, `t` theme, `?` all keys. Typing `:` opens the command line as a popup with suggestions ([noice](https://github.com/folke/noice.nvim)).

| Mode | Keys        | Action                              | Docs |
|------|-------------|-------------------------------------|------|
| n, t | `<C-\>`     | Toggle terminal                     | [terminal](https://github.com/folke/snacks.nvim/blob/main/docs/terminal.md) |
| n    | `<leader>n` | Notification history                | [notifier](https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md) |
| n    | `<leader>;` | Jump via the breadcrumbs bar (also clickable) | [dropbar](https://github.com/Bekaboo/dropbar.nvim) |
| n    | `]]` / `[[` | Next / previous use of the word under cursor | [words](https://github.com/folke/snacks.nvim/blob/main/docs/words.md) |

### Sessions

| Mode | Keys         | Action                           | Docs |
|------|--------------|----------------------------------|------|
| n    | `<leader>qs` | Reopen files from last time (this folder) | [persistence](https://github.com/folke/persistence.nvim#-usage) |
| n    | `<leader>ql` | Reopen the last session anywhere | [persistence](https://github.com/folke/persistence.nvim#-usage) |
| n    | `<leader>qd` | Don't save this session          | [persistence](https://github.com/folke/persistence.nvim#-usage) |

### Toggles

Press `<leader>u` and wait: [which-key](https://github.com/folke/which-key.nvim) shows each toggle and whether it is on ([snacks toggle](https://github.com/folke/snacks.nvim/blob/main/docs/toggle.md)).

| Keys         | Toggle           | Keys         | Toggle            |
|--------------|------------------|--------------|-------------------|
| `<leader>uw` | Line wrap        | `<leader>ud` | Diagnostics       |
| `<leader>ul` | Line numbers     | `<leader>uh` | Inlay hints       |
| `<leader>ur` | Relative numbers | `<leader>ui` | Indent guides     |
| `<leader>us` | Spell check      | `<leader>ub` | Light / dark theme |
| `<leader>up` | [Motion hints](https://github.com/tris203/precognition.nvim): where `w` `b` `e` `$` `^` go | `<leader>uH` | [Training mode](https://github.com/m4xshen/hardtime.nvim): nudges you off `jjjj` |

### Completion (Insert mode)

| Keys                | Action                                   | Docs |
|---------------------|------------------------------------------|------|
| `<C-Space>`         | Open the menu                            | [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) |
| `<C-j>` / `<C-k>`   | Next / previous item                     | [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) |
| `<Tab>` / `<S-Tab>` | Next / previous item, or snippet field   | [LuaSnip](https://github.com/L3MON4D3/LuaSnip) |
| `<CR>`              | Confirm                                  | [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) |
| `<C-e>`             | Close the menu                           | [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) |

### Code (LSP)

| Mode | Keys         | Action                    | Docs |
|------|--------------|---------------------------|------|
| n    | `gd` / `gD`  | Definition / declaration  | [definition](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.definition()) |
| n    | `gi`         | Implementation            | [implementation](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.implementation()) |
| n    | `gr`         | References                | [references](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.references()) |
| n    | `K`          | Documentation popup       | [hover](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.hover()) |
| i    | `<C-k>`      | Function signature        | [signature_help](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.signature_help()) |
| n    | `<leader>rn` | Rename symbol             | [rename](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.rename()) |
| n, v | `<leader>ca` | Code actions / quick fix  | [code_action](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.code_action()) |
| n    | `<C-o>`      | Jump back                 | [jumplist](https://neovim.io/doc/user/motion.html#CTRL-O) |

### Diagnostics

| Mode | Keys        | Action                     | Docs |
|------|-------------|----------------------------|------|
| n    | `[d` / `]d` | Previous / next problem    | [jump](https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.jump()) |
| -    | (automatic) | Problems shown next to the code | [tiny-inline-diagnostic](https://github.com/rachartier/tiny-inline-diagnostic.nvim) |
| n    | `<leader>e` | Show problem under cursor  | [open_float](https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.open_float()) |
| n    | `<leader>cd` | List problems in file     | [setloclist](https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.setloclist()) |

### Git

| Mode | Keys         | Action                                 | Docs |
|------|--------------|----------------------------------------|------|
| n    | `<leader>gg` | Open LazyGit                           | [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) |
| -    | (automatic)  | Line blame and change signs            | [gitsigns](https://github.com/lewis6991/gitsigns.nvim) |

### Tests

| Mode | Keys         | Action             | Docs |
|------|--------------|--------------------|------|
| n    | `<leader>tt` | Run nearest test   | [neotest](https://github.com/nvim-neotest/neotest) |
| n    | `<leader>tf` | Run file           | [neotest](https://github.com/nvim-neotest/neotest) |
| n    | `<leader>ts` | Summary panel      | [neotest](https://github.com/nvim-neotest/neotest) |
| n    | `<leader>to` | Output panel       | [neotest](https://github.com/nvim-neotest/neotest) |
| n    | `<leader>tS` | Stop               | [neotest](https://github.com/nvim-neotest/neotest) |

## Themes

| Mode | Keys / command  | Action                                   |
|------|-----------------|------------------------------------------|
| n    | `<leader>th`    | Pick a theme: previews as you move, `Enter` keeps it, `Esc` undoes |
| n    | `:Theme <name>` | Apply directly, `Tab` completes          |
| n    | `<leader>ub`    | Switch between the light and dark variant |

Themes (28): everforest, gruvbox, [catppuccin](https://github.com/catppuccin/nvim), [nightfox](https://github.com/EdenEast/nightfox.nvim), [tokyonight](https://github.com/folke/tokyonight.nvim), [kanagawa](https://github.com/rebelot/kanagawa.nvim), [rose-pine](https://github.com/rose-pine/neovim), [onedarkpro](https://github.com/olimorris/onedarkpro.nvim) and [github](https://github.com/projekt0n/github-nvim-theme), each with dark and light variants. To add one, see the comments in [`lua/core/theme.lua`](lua/core/theme.lua).

## Commands

| Command              | What it does                         | Docs |
|----------------------|--------------------------------------|------|
| `:Lazy`              | Manage plugins                       | [lazy.nvim](https://lazy.folke.io/usage) |
| `:Mason`             | Manage language servers and tools    | [mason.nvim](https://github.com/mason-org/mason.nvim#commands) |
| `:TSUpdate`          | Update Treesitter parsers            | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/tree/main#commands) |
| `:LspInfo`           | Language servers on this buffer      | [lsp](https://neovim.io/doc/user/lsp.html#lsp-quickstart) |
| `:checkhealth`       | Diagnose the setup                   | [health](https://neovim.io/doc/user/health.html) |
| `:RustLsp runnables` | Run a Rust target                    | [rustaceanvim](https://github.com/mrcjkb/rustaceanvim#books-usage--features) |

## Customizing

- **Plugins**: one file per plugin in `lua/plugins/`, registered in [`lua/plugins/init.lua`](lua/plugins/init.lua). Format: [lazy.nvim spec](https://lazy.folke.io/spec).
- **Language servers**: list in [`lua/plugins/lsp/mason-config.lua`](lua/plugins/lsp/mason-config.lua), settings in `lua/plugins/lsp/servers/`. Names: [server configs](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md).
- **Formatters**: [`lua/plugins/formatter.lua`](lua/plugins/formatter.lua). Names: [conform formatters](https://github.com/stevearc/conform.nvim#formatters).

Roadmap: [`docs/plano-de-acao.md`](docs/plano-de-acao.md).

## Troubleshooting

| Problem                          | Try |
|----------------------------------|-----|
| Anything odd                     | `:checkhealth` |
| Treesitter fails to compile      | `tree-sitter --version` must work and be 0.25+ |
| Language server not starting     | `:Mason`, then `:LspInfo` |
| Icons are squares                | Use a Nerd Font in the terminal |
