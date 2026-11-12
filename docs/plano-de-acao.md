# NvYosemite: plano de ação

Objetivo: um Neovim que qualquer pessoa clona e usa no primeiro dia. Ele vem com padrões opinativos, mas tudo pode ser customizado sem fazer fork. São **20 steps em 4 fases**. Cada step é **um commit**: pequeno, testável e sem depender dos steps seguintes.

## Regras para cada step

1. **Um step = um commit** com [Conventional Commits](https://www.conventionalcommits.org/). A mensagem sugerida está em cada step.
2. **O README é atualizado no mesmo commit** sempre que o step muda atalhos, comandos ou formas de configurar.
3. **Verificação antes do commit**: rodar o smoke test abaixo e fazer o teste específico do step (campo *Pronto quando*).
4. **Comportamento novo vem desligado ou é fácil de desligar** quando puder incomodar, como formatar ao salvar ou lint.
5. Plugin novo entra com uma versão fixa no `lazy-lock.json`, que já é versionado.

Smoke test (abre o Neovim sem interface e falha se houver erro):

```bash
nvim --headless "+Lazy! sync" +qa
nvim --headless init.lua -c "sleep 3" -c "lua if vim.v.errmsg ~= '' then print(vim.v.errmsg) vim.cmd('cq') end" +qa
```

## Visão geral

| #  | Step                                   | Fase | Commit                                                  | Status |
|----|----------------------------------------|------|---------------------------------------------------------|--------|
| 1  | Remover CursorLine fixo                | 1    | `fix(ui): let the theme define CursorLine`              | [ ]    |
| 2  | Adicionar LICENSE                      | 1    | `docs: add MIT license`                                 | [ ]    |
| 3  | Opções essenciais                      | 1    | `feat(options): add sensible defaults`                  | [ ]    |
| 4  | Carregar `user.lua` opcional           | 2    | `feat(core): load optional user config`                 | [ ]    |
| 5  | Tema e opções via `user.lua`           | 2    | `feat(core): let user config set theme and options`     | [ ]    |
| 6  | Plugins extras via `user.lua`          | 2    | `feat(plugins): import user plugin specs`               | [ ]    |
| 7  | Centralizar ferramentas por linguagem  | 2    | `refactor(lang): centralize per-language tooling`       | [ ]    |
| 8  | Ligar/desligar linguagens              | 2    | `feat(lang): enable languages from user config`         | [ ]    |
| 9  | `:checkhealth nvyosemite`              | 2    | `feat(health): add nvyosemite health check`             | [ ]    |
| 10 | Formatar ao salvar + `:FormatToggle`   | 3    | `feat(format): format on save with toggle`              | [ ]    |
| 11 | Lint com nvim-lint                     | 3    | `feat(lint): add nvim-lint`                             | [ ]    |
| 12 | Terminal integrado                     | 3    | `feat(terminal): add toggleable terminal`               | [ ]    |
| 13 | trouble.nvim + todo-comments           | 3    | `feat(ui): add trouble and todo-comments`               | [ ]    |
| 14 | Treesitter textobjects                 | 3    | `feat(treesitter): add textobjects`                     | [ ]    |
| 15 | Debugger: núcleo (nvim-dap + dap-ui)   | 3    | `feat(dap): add nvim-dap core and UI`                   | [ ]    |
| 16 | Debugger: Go e Python                  | 3    | `feat(dap): add Go and Python adapters`                 | [ ]    |
| 17 | Debugger: C# e Rust                    | 3    | `feat(dap): add C# and Rust adapters`                   | [ ]    |
| 18 | CI: smoke test no GitHub Actions       | 4    | `ci: add headless startup smoke test`                   | [ ]    |
| 19 | README: guia de primeiros passos       | 4    | `docs(readme): add getting started guide`               | [ ]    |
| 20 | Release v1.0                           | 4    | `chore(release): v1.0.0`                                | [ ]    |

Feito antes deste plano: switch de tema com `:Theme` / `<leader>th` (`6d7b1a8`).

---

## Fase 1: Correções rápidas

### Step 1: Remover CursorLine fixo

- **Por quê:** `init.lua` força `CursorLine guibg=#2C2C2C`. Com tema claro (`catppuccin-latte`, `dawnfox`) aparece uma faixa escura, e ao trocar de tema essa cor some.
- **O que fazer:** remover a linha `vim.cmd([[highlight CursorLine ...]])` de `init.lua` e mover as opções `vim.opt.*` que estão em `init.lua` para `lua/core/options.lua`.
- **Pronto quando:** `:Theme dawnfox` e `:Theme carbonfox` mostram a linha do cursor com a cor do próprio tema.

### Step 2: Adicionar LICENSE

- **Por quê:** o selo MIT do README aponta para um arquivo `LICENSE` que não existe.
- **O que fazer:** criar `LICENSE` (MIT) com o ano e o autor.
- **Pronto quando:** o link do selo abre o arquivo no GitHub.

### Step 3: Opções essenciais

- **Por quê:** quem vem de outro editor espera esses comportamentos e hoje não os tem.
- **O que fazer:** em `lua/core/options.lua`:
  - `clipboard = "unnamedplus"` (copiar e colar com o sistema)
  - `ignorecase` + `smartcase` (busca ignora maiúsculas, a menos que você digite uma)
  - `undofile = true` (desfazer continua funcionando depois de fechar o arquivo)
  - `splitright` + `splitbelow`
  - `mouse = "a"`, `updatetime = 250`, `confirm = true`
  - remover o `vim.g.mapleader` duplicado em `lua/core/keymaps.lua`
- **Pronto quando:** `yy` no Neovim cola no navegador, e o desfazer funciona depois de reabrir o arquivo.

---

## Fase 2: Base customizável

O objetivo é que a pessoa customize tudo num único arquivo fora do git e continue recebendo atualizações com `git pull`, sem conflito.

### Step 4: Carregar `user.lua` opcional

- **O que fazer:**
  - `lua/core/user.lua`: lê `lua/user.lua` com `pcall`. Se o arquivo não existir, retorna `{}`.
  - Criar `lua/user.example.lua` documentado, como modelo.
  - Adicionar `lua/user.lua` ao `.gitignore`.
- **Pronto quando:** o Neovim abre normal sem o arquivo. Com um `user.lua` contendo um erro de sintaxe, aparece um aviso claro e o editor abre mesmo assim.

### Step 5: Tema e opções via `user.lua`

- **O que fazer:**
  - `theme = "gruvbox"` vira o padrão quando não há tema salvo pelo `:Theme`.
  - `options = { relativenumber = false, ... }` é aplicado depois de `core/options.lua`.
  - `leader` configurável.
- **Pronto quando:** num ambiente limpo (sem o tema salvo), o tema do `user.lua` é aplicado.

### Step 6: Plugins extras via `user.lua`

- **O que fazer:**
  - `plugins = { { "autor/plugin", opts = {} } }` é anexado a `Plugins.all_plugins`.
  - `disabled = { "neo-tree.nvim" }` vira `enabled = false` no spec correspondente.
- **Pronto quando:** um plugin adicionado no `user.lua` aparece no `:Lazy`, e um desabilitado some.

### Step 7: Centralizar ferramentas por linguagem

- **Por quê:** hoje a configuração de cada linguagem está espalhada em 5 lugares (LSP, formatter, parser, adapter de teste, rustaceanvim). É um pré-requisito do step 8.
- **O que fazer:** criar `lua/core/languages.lua`, uma tabela declarativa com o que cada linguagem usa: `lsp`, `formatters`, `parsers`, `neotest` e `mason`. `mason-config.lua`, `formatter.lua`, `treesitter.lua` e `neotest.lua` passam a ler dessa tabela.
- **Pronto quando:** o comportamento continua **idêntico**: os mesmos LSPs sobem em Lua, Rust, Python e Go, e os mesmos parsers e formatadores são usados. É só uma refatoração.

### Step 8: Ligar/desligar linguagens

- **O que fazer:** `languages = { go = true, rust = true, csharp = false }` no `user.lua`, com todas ligadas por padrão. Uma linguagem desligada não instala LSP, parser nem formatador.
- **Pronto quando:** com `csharp = false`, um ambiente limpo não instala o `csharp-language-server`.

### Step 9: `:checkhealth nvyosemite`

- **Por quê:** a quebra do treesitter no Windows aconteceu por falta de dependências externas. Um diagnóstico mostra isso logo de cara.
- **O que fazer:** criar `lua/nvyosemite/health.lua`, que verifica: Neovim 0.12+, `tree-sitter` 0.25+ executável (alertando sobre o shim do npm no Windows), compilador C, `git`, `rg`, `lazygit`, `make` e se o `user.lua` carregou.
- **Pronto quando:** `:checkhealth nvyosemite` mostra OK e WARN corretos, e removendo o `rg` do PATH aparece um WARN.

---

## Fase 3: Funcionalidades

### Step 10: Formatar ao salvar + `:FormatToggle`

- **O que fazer:** usar `format_on_save` do conform, ligado por padrão e desligável em `user.lua` (`format_on_save = false`). `:FormatToggle` liga e desliga na sessão, e `:FormatToggle!` só no buffer atual.
- **Pronto quando:** salvar um `.lua` desalinhado formata o arquivo, e depois de `:FormatToggle` não formata mais.

### Step 11: Lint com nvim-lint

- **O que fazer:** `mfussenegger/nvim-lint` com `eslint_d` (JS/TS) e `ruff` (Python), declarados em `core/languages.lua`. Roda em `BufWritePost` e `InsertLeave`.
- **Pronto quando:** um `import` sem uso num `.py` aparece como diagnóstico do ruff.

### Step 12: Terminal integrado

- **O que fazer:** `akinsho/toggleterm.nvim`, com `<C-\>` abrindo um terminal flutuante, `<leader>oh` num split horizontal e `<leader>ov` num vertical. O prefixo `o` ("open") evita colisão com `<leader>t*` do neotest e `<leader>th` do tema.
- **Pronto quando:** `<C-\>` abre e fecha o terminal, mantendo o processo vivo.

### Step 13: trouble.nvim + todo-comments

- **O que fazer:**
  - `folke/trouble.nvim`: `<leader>xx` para diagnósticos do projeto e `<leader>xq` para quickfix. Mover "fechar buffer" de `<leader>x` para `<leader>bd`, para não colidir.
  - `folke/todo-comments.nvim`: destaca `TODO`, `FIXME` e `HACK`. `<leader>ft` lista todos no Telescope.
- **Pronto quando:** `<leader>xx` lista os erros do projeto, e `<leader>ft` acha um `TODO` de teste.

### Step 14: Treesitter textobjects

- **O que fazer:** `nvim-treesitter/nvim-treesitter-textobjects` (branch `main`) com `af`/`if` (função), `ac`/`ic` (classe), `aa`/`ia` (argumento) e `]f`/`[f` para pular entre funções.
- **Pronto quando:** `vaf` seleciona a função inteira em Lua, Go e Rust.

### Step 15: Debugger, núcleo

- **O que fazer:** `mfussenegger/nvim-dap` + `rcarriga/nvim-dap-ui` + `theHamsta/nvim-dap-virtual-text`. Atalhos: `<F5>` continuar, `<F10>` próxima linha, `<F11>` entrar, `<S-F11>` sair, `<leader>db` breakpoint, `<leader>du` UI.
- **Pronto quando:** o plugin carrega sem erros e `<leader>db` marca um breakpoint. Ainda não há adapters nesse step.

### Step 16: Debugger, Go e Python

- **O que fazer:** `leoluz/nvim-dap-go` (delve) e `mfussenegger/nvim-dap-python` (debugpy via Mason), ligados pela tabela de linguagens.
- **Pronto quando:** parar num breakpoint de um `main.go` e de um `.py` simples.

### Step 17: Debugger, C# e Rust

- **O que fazer:** `netcoredbg` (C#) e `codelldb` (Rust, que o rustaceanvim detecta sozinho), via Mason.
- **Pronto quando:** parar num breakpoint de um console app .NET e de um `cargo new`.

---

## Fase 4: Qualidade e release

### Step 18: CI com smoke test

- **O que fazer:** `.github/workflows/ci.yml` com uma matriz `ubuntu-latest` + `windows-latest` que:
  1. instala o Neovim 0.12 e o `tree-sitter` CLI;
  2. roda `nvim --headless "+Lazy! restore" +qa`, usando as versões do lockfile;
  3. abre arquivos de amostra (Lua, Go, Rust, Python) e falha se `v:errmsg` não estiver vazio;
  4. roda `:checkhealth nvyosemite` e falha se houver ERROR.
- **Pronto quando:** o PR mostra o check verde. Para validar, quebrar um spec de propósito numa branch e confirmar que o CI fica vermelho.

### Step 19: README, primeiros passos

- **O que fazer:** adicionar uma seção "Primeiros 10 minutos" no topo: instalar, rodar `:checkhealth nvyosemite`, escolher o tema, criar o `user.lua` e uma lista dos 10 atalhos mais usados. Documentar `gcc`/`gc` (comentários nativos do Neovim).
- **Pronto quando:** uma pessoa que nunca usou a config consegue instalar e editar seguindo só o README.

### Step 20: Release v1.0

- **O que fazer:** criar `CHANGELOG.md` a partir do histórico, a tag `v1.0.0` e uma GitHub Release com as notas.
- **Pronto quando:** a release está publicada e o README aponta para ela.
