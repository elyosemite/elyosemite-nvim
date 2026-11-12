# Changelog

Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Details for each item are in the [README](README.md) and in the git history.

## [1.0.0] - Unreleased

The first release focused on people who only know a few Vim commands.

### Added

- **Discover keys**: named which-key groups, a generated cheatsheet (`<leader>?`), a command palette (`<leader><leader>`) and a right-click context menu.
- **Interface**: snacks.nvim dashboard, notifications, indent guides and terminal (`<C-\>`); noice command line; dropbar breadcrumbs; readable inline diagnostics.
- **Themes**: runtime switcher with live preview (`<leader>th`), 28 themes with light variants, light/dark toggle (`<leader>ub`), saved between sessions.
- **Learning Vim**: cursor line colored by mode, motion hints (precognition), opt-in training mode (hardtime), flash jumps (`s`).
- **Safety**: built-in undo tree (`<leader>uu`), persistent undo, session restore (`<leader>qs`).
- **Everyday tasks**: project search and replace (grug-far), git hunk keys and diffview, rename with live preview, trouble and todo-comments, Treesitter textobjects.
- **Toggles group** `<leader>u`: wrap, numbers, spell, diagnostics, inlay hints, indent guides, format on save, motion hints, training mode.
- **Formatting and lint**: format on save; formatters, linters and debuggers installed by Mason; ruff and ESLint language servers.
- **Debugger**: nvim-dap with UI for Go, Python, C# and Rust.
- **`:checkhealth nvyosemite`** for external tools, including the tree-sitter npm shim on Windows.
- **CI**: smoke test on Ubuntu and Windows (`tests/smoke.lua`).
- Sensible options: system clipboard, smartcase search, persistent undo, `<C-s>` to save, `<Esc>` clears the search.

### Changed

- nvim-treesitter moved to the `main` branch for Neovim 0.12.
- LSP configured with `vim.lsp.config` (mason-lspconfig v2).
- Close buffer: `<leader>x` → `<leader>bd`. Diagnostic list: `<leader>q` → `<leader>cd`. Signature help in Insert mode: `<C-s>` → `<C-k>`.
- alpha.nvim replaced by the snacks dashboard; neodev replaced by lazydev; rustaceanvim v5 → v9.

### Fixed

- Treesitter crash (`attempt to call method 'range'`) on Neovim 0.12.
- LSP server settings and keymaps silently ignored under mason-lspconfig v2.
- Inlay hints never enabled; csharpier never installed or matched (`cs` filetype).
- Hardcoded cursor line color that broke light themes.
