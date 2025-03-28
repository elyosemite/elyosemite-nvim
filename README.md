# NvYosemite Editor for Geek

[![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?style=flat&logo=neovim&logoColor=white)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat&logo=lua&logoColor=white)](https://www.lua.org)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)](LICENSE)

A production-ready Neovim configuration that works out of the box while remaining fully hackable. Built with Lua and designed for developers who want functionality without the configuration fatigue.

## Features

- **Zero-config setup** - Just clone and start coding
- **Modular architecture** - Organized Lua modules for easy customization
- **Batteries included**:
  - LSP support with automatic server installation
  - Advanced autocompletion (nvim-cmp)
  - File explorer (nvim-tree)
  - Fuzzy finder (Telescope)
  - Git integration
  - Syntax highlighting (Treesitter)
  - Multiple pre-installed color schemes
- **Performance optimized** - No bloated plugins

## Installation

```bash
# Backup existing config (if any)
mv ~/.config/nvim{,.bak}

# Clone the repository
git clone https://github.com/elyosemite/el-yosemite-nvim.git ~/.config/nvim
```

Launch Neovim and wait for plugins to install automatically.

```bash
nvim/
├── init.lua          # Main entry point
└── lua/
    ├── core/         # Core settings and keymaps
    ├── plugins/      # Plugin configurations
    │   ├── init.lua  # Plugin declarations
    │   └── *.lua     # Individual plugin configs
    ├── themes/       # Colorscheme setup
    └── utils/        # Helper functions
```

## Customizing
To add new plugins:

1. Edit `lua/plugins/init.lua`:

```lua
use {
  'author/plugin',
  config = function()
    require('plugins.plugin-name')
  end
}
```

2. Create a new config file in lua/plugins/ if needed

## Key Mappings

| Mode | Key       | Action                 |
|------|-----------|------------------------|
| `n`  | `<space>`   | `Leader key            ` |
| `n`  | `<leader>f` | `Find files (Telescope)` |
| `n`  | `<leader>g` | `Live grep (Telescope) ` |
| `n`  | `<C-n>`     | `Toggle file tree      ` |

## Included Plugins

Core

Lazy.nvim (package manager)

### UI

- Telescope.nvim
- Nvim-tree.lua
- Lualine.nvim
- Bufferline.nvim

### LSP
- nvim-lspconfig
- mason.nvim
- nvim-cmp

### Editing
- Treesitter
- Comment.nvim
- LuaSnip

## Troubleshooting
Run :checkhealth in Neovim to diagnose potential issues.