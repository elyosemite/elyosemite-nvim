# NvYosemite: plano de ação

Objetivo: **alguém que acabou de aprender o básico de Vim consegue usar a config sem dificuldade**. A interface é boa, os atalhos aparecem sozinhos, o modo atual fica sempre visível e todo erro pode ser desfeito.

Referências: [LazyVim](https://www.lazyvim.org), [NvChad](https://nvchad.com) e [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

Branch de trabalho: `feat/usability`.

## Regras para cada step

1. **Um step = um commit** com [Conventional Commits](https://www.conventionalcommits.org/). A mensagem sugerida está na tabela.
2. **O README fica curto**: cada atalho ou comando novo ganha **uma linha** na tabela e um **link para a documentação** do plugin. Explicação longa fica na doc oficial, não no README.
3. **Verificação antes do commit**: rodar o smoke test abaixo e fazer o teste do campo *Pronto quando*.
4. **Recurso que pode incomodar vem fácil de desligar**, de preferência pelo grupo de toggles `<leader>u`.
5. Plugin novo fica com versão fixa no `lazy-lock.json`.

Smoke test:

```bash
nvim --headless "+Lazy! sync" +qa
nvim --headless init.lua -c "sleep 3" -c "lua if vim.v.errmsg ~= '' then print(vim.v.errmsg) vim.cmd('cq') end" +qa
```

## Visão geral

| #  | Step                                         | Fase | Commit                                                    | Status |
|----|----------------------------------------------|------|-----------------------------------------------------------|--------|
| 1  | Ligar inlay hints                            | 1    | `fix(lsp): enable inlay hints`                            | [x]    |
| 2  | Instalar formatadores automaticamente        | 1    | `feat(mason): auto-install formatters`                    | [x]    |
| 3  | Remover CursorLine fixo                      | 1    | `fix(ui): let the theme define CursorLine`                | [x]    |
| 4  | Adicionar LICENSE                            | 1    | `docs: add MIT license`                                   | [x]    |
| 5  | Opções e atalhos essenciais                  | 1    | `feat(options): add sensible defaults`                    | [x]    |
| 6  | which-key com grupos nomeados                | 2    | `feat(ui): name which-key groups`                         | [x]    |
| 7  | Cheatsheet `<leader>?`                       | 2    | `feat(ui): add generated keymap cheatsheet`               | [x]    |
| 8  | Paleta de comandos `<leader><leader>`        | 2    | `feat(ui): add command palette`                           | [x]    |
| 9  | Menu de clique direito                       | 2    | `feat(ui): add right-click context menu`                  | [x]    |
| 10 | snacks.nvim (dashboard, notificações, etc.)  | 3    | `feat(ui): add snacks.nvim and replace alpha`             | [x]    |
| 11 | noice.nvim                                   | 3    | `feat(ui): add noice for cmdline and messages`            | [x]    |
| 12 | Breadcrumbs (dropbar)                        | 3    | `feat(ui): add dropbar breadcrumbs`                       | [x]    |
| 13 | Diagnósticos legíveis                        | 3    | `feat(ui): add tiny-inline-diagnostic`                    | [x]    |
| 14 | Seletor de tema com preview ao vivo          | 4    | `feat(theme): live preview in theme picker`               | [x]    |
| 15 | Mais temas, incluindo claros                 | 4    | `feat(theme): add tokyonight, kanagawa, rose-pine, ...`   | [x]    |
| 16 | Alternar claro/escuro                        | 4    | `feat(theme): toggle light and dark variant`              | [x]    |
| 17 | Grupo de toggles `<leader>u`                 | 5    | `feat(ui): add toggles group`                             | [x]    |
| 18 | Mostrar o modo atual (modes.nvim)            | 5    | `feat(ui): color cursorline by mode`                      | [x]    |
| 19 | Dicas de movimento (precognition)            | 5    | `feat(learn): add precognition hints`                     | [x]    |
| 20 | Modo treino (hardtime, desligado)            | 5    | `feat(learn): add opt-in hardtime`                        | [x]    |
| 21 | Pular para qualquer lugar (flash)            | 5    | `feat(motion): add flash.nvim`                            | [x]    |
| 22 | Undotree + restaurar sessão                  | 6    | `feat(safety): add undotree and session restore`          | [ ]    |
| 23 | Buscar e substituir no projeto (grug-far)    | 6    | `feat(search): add grug-far`                              | [ ]    |
| 24 | Git: atalhos de hunk + diffview              | 6    | `feat(git): add hunk keymaps and diffview`                | [ ]    |
| 25 | Renomear com preview (inc-rename)            | 6    | `feat(lsp): add inc-rename`                               | [ ]    |
| 26 | trouble.nvim + todo-comments                 | 6    | `feat(ui): add trouble and todo-comments`                 | [ ]    |
| 27 | Treesitter textobjects                       | 6    | `feat(treesitter): add textobjects`                       | [ ]    |
| 28 | Formatar ao salvar                           | 6    | `feat(format): format on save with toggle`                | [ ]    |
| 29 | Lint via LSP (ruff, ESLint)                  | 6    | `feat(lint): lint Python and JS via LSP`                  | [ ]    |
| 30 | `:checkhealth nvyosemite`                    | 7    | `feat(health): add nvyosemite health check`               | [ ]    |
| 31 | Debugger: núcleo                             | 7    | `feat(dap): add nvim-dap core and UI`                     | [ ]    |
| 32 | Debugger: Go e Python                        | 7    | `feat(dap): add Go and Python adapters`                   | [ ]    |
| 33 | Debugger: C# e Rust                          | 7    | `feat(dap): add C# and Rust adapters`                     | [ ]    |
| 34 | CI: smoke test no GitHub Actions             | 8    | `ci: add headless startup smoke test`                     | [ ]    |
| 35 | README: primeiros passos                     | 8    | `docs(readme): add getting started guide`                 | [ ]    |
| 36 | Release v1.0                                 | 8    | `chore(release): v1.0.0`                                  | [ ]    |

Feito antes deste plano: switch de tema `:Theme` / `<leader>th` (`6d7b1a8`).

---

## Fase 1: Correções

### Step 1: Ligar inlay hints
- **Por quê:** gopls e ts_ls já estão configurados para mandar hints, mas `vim.lsp.inlay_hint.enable()` nunca é chamado.
- **O que fazer:** ligar no `LspAttach` quando o servidor suportar.
- **Pronto quando:** num `.go`, os nomes dos parâmetros aparecem nas chamadas de função.

### Step 2: Instalar formatadores automaticamente
- **Por quê:** o `csharpier` não está instalado, então `<leader>gf` em C# falha sem explicação.
- **O que fazer:** [mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) com stylua, prettier, black, isort, csharpier e clang-format.
- **Pronto quando:** num ambiente limpo, o `:Mason` mostra todos instalados.

### Step 3: Remover CursorLine fixo
- **Por quê:** `guibg=#2C2C2C` fica escuro em tema claro e some ao trocar de tema.
- **O que fazer:** remover a linha e mover os `vim.opt` de `init.lua` para `core/options.lua`.
- **Pronto quando:** `:Theme dawnfox` mostra a linha do cursor na cor do tema.

### Step 4: Adicionar LICENSE
- **O que fazer:** criar `LICENSE` (MIT), já que o selo do README aponta para ele.

### Step 5: Opções e atalhos essenciais
- **O que fazer:**
  - opções: `clipboard=unnamedplus`, `ignorecase`+`smartcase`, `undofile`, `splitright`/`splitbelow`, `mouse=a`, `confirm`;
  - `<C-s>` salva em qualquer modo, já que o Neovim oferece a ajuda de assinatura com `<C-s>` no modo Insert;
  - `Esc` no modo Normal limpa o destaque da busca;
  - remover o `mapleader` duplicado em `core/keymaps.lua`.
- **Pronto quando:** `yy` cola no navegador, `<C-s>` salva, e o desfazer funciona depois de reabrir o arquivo.

## Fase 2: Descobrir sozinho

### Step 6: which-key com grupos nomeados
- **O que fazer:** nomear os grupos (`f` Buscar, `g` Git, `t` Testes, `c` Código, `u` Toggles, `b` Buffers, `d` Debug).
- **Pronto quando:** ao apertar Espaço e esperar, os grupos aparecem com nomes.

### Step 7: Cheatsheet `<leader>?`
- **O que fazer:** uma janela flutuante gerada a partir dos `desc` dos atalhos e agrupada por prefixo. Ela nunca fica desatualizada.
- **Pronto quando:** um atalho novo com `desc` aparece na cheatsheet sem editar mais nada.

### Step 8: Paleta de comandos
- **O que fazer:** `<leader><leader>` abre uma busca por ação ("formatar", "tema") que executa o atalho correspondente.

### Step 9: Menu de clique direito
- **O que fazer:** [nvzone/menu](https://github.com/nvzone/menu) com LSP, formatar, git e tema.

## Fase 3: Interface

### Step 10: snacks.nvim
- **O que fazer:** [snacks.nvim](https://github.com/folke/snacks.nvim) com:
  - dashboard (substitui o alpha), com teclas: `f` arquivos, `r` recentes, `g` grep, `t` tema, `s` sessão, `l` Lazy, `q` sair;
  - notificações, guias de indentação e destaque das referências da palavra sob o cursor;
  - terminal com `<C-\>`.

### Step 11: noice.nvim
- **O que fazer:** [noice.nvim](https://github.com/folke/noice.nvim) para a linha de comando em popup e as mensagens como notificação. Acaba o "Press ENTER".

### Step 12: Breadcrumbs
- **O que fazer:** [dropbar.nvim](https://github.com/Bekaboo/dropbar.nvim), com o caminho e o símbolo atual clicáveis no topo.

### Step 13: Diagnósticos legíveis
- **O que fazer:** [tiny-inline-diagnostic.nvim](https://github.com/rachartier/tiny-inline-diagnostic.nvim) no lugar de `virtual_text`.

## Fase 4: Temas

### Step 14: Preview ao vivo
- **O que fazer:** o seletor do `:Theme` aplica o tema enquanto você navega e volta ao original com `Esc`.

### Step 15: Mais temas
- **O que fazer:** tokyonight, kanagawa, rose-pine, onedark e github, incluindo variantes claras.

### Step 16: Alternar claro/escuro
- **O que fazer:** `<leader>ub` troca para a variante clara ou escura do tema atual (ex.: `catppuccin-mocha` ↔ `catppuccin-latte`).

## Fase 5: Aprender Vim usando

### Step 17: Grupo de toggles `<leader>u`
- **O que fazer:** quebra de linha, números relativos, ortografia, inlay hints e diagnósticos. Os steps seguintes adicionam mais toggles.

### Step 18: Mostrar o modo atual
- **O que fazer:** [modes.nvim](https://github.com/mvllow/modes.nvim) colore a linha do cursor por modo.

### Step 19: Dicas de movimento
- **O que fazer:** [precognition.nvim](https://github.com/tris203/precognition.nvim), ligado por padrão e desligável em `<leader>up`.

### Step 20: Modo treino
- **O que fazer:** [hardtime.nvim](https://github.com/m4xshen/hardtime.nvim), desligado por padrão e ligado em `<leader>uH`.

### Step 21: flash.nvim
- **O que fazer:** [flash.nvim](https://github.com/folke/flash.nvim): `s` + 2 letras pula para qualquer lugar da tela.

## Fase 6: Segurança e tarefas comuns

### Step 22: Undotree + sessão
- **O que fazer:** `:Undotree`, nativo do Neovim 0.12 (`packadd nvim.undotree`), em `<leader>uu`, e [persistence.nvim](https://github.com/folke/persistence.nvim) para restaurar a sessão.

### Step 23: grug-far
- **O que fazer:** [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) em `<leader>sr`.

### Step 24: Git
- **O que fazer:** atalhos de hunk do gitsigns (preview, reset, stage) e [diffview.nvim](https://github.com/sindrets/diffview.nvim).

### Step 25: inc-rename
- **O que fazer:** [inc-rename.nvim](https://github.com/smjonas/inc-rename.nvim) em `<leader>rn`.

### Step 26: trouble + todo-comments
- **O que fazer:** [trouble.nvim](https://github.com/folke/trouble.nvim) em `<leader>xx` e [todo-comments](https://github.com/folke/todo-comments.nvim). Mover "fechar buffer" de `<leader>x` para `<leader>bd`.

### Step 27: Textobjects
- **O que fazer:** [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) (branch `main`) com `af`/`if`, `ac`/`ic` e `]f`/`[f`.

### Step 28: Formatar ao salvar
- **O que fazer:** `format_on_save` do conform, com toggle em `<leader>uf`.

### Step 29: Lint
- **O que fazer:** lint como servidores LSP: `ruff` (Python) e `eslint` (JS/TS, só em projetos com config do ESLint). Eles trazem quick fixes.
- **Mudança em relação ao plano original:** o nvim-lint com eslint_d foi descartado, porque o daemon do eslint_d não sobe no Windows ("Timed out waiting for config") e rodar o ruff também pelo nvim-lint duplicaria os avisos do ruff LSP.

## Fase 7: Diagnóstico e debugger

### Step 30: `:checkhealth nvyosemite`
- **O que fazer:** verificar Neovim 0.12+, `tree-sitter` 0.25+ (alertando sobre o shim do npm no Windows), compilador C, `git`, `rg`, `lazygit` e Nerd Font.

### Steps 31–33: Debugger
- **O que fazer:** [nvim-dap](https://github.com/mfussenegger/nvim-dap) + [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) com `<F5>`, `<F10>`, `<F11>` e `<leader>db`. Depois os adapters: delve e debugpy, e em seguida netcoredbg e codelldb.

## Fase 8: Qualidade e release

### Step 34: CI
- **O que fazer:** `.github/workflows/ci.yml` com matriz Ubuntu + Windows que roda `Lazy! restore`, abre arquivos de amostra e falha se houver erro.
- **Pronto quando:** quebrar um spec numa branch deixa o CI vermelho.

### Step 35: README, primeiros passos
- **O que fazer:** uma seção "Primeiros 10 minutos": instalar, `:checkhealth nvyosemite`, `<leader>th`, `<leader>?`.

### Step 36: Release v1.0
- **O que fazer:** `CHANGELOG.md`, a tag `v1.0.0` e uma GitHub Release.
