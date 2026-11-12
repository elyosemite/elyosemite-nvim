-- Os tipos da API do Neovim vêm do lazydev.nvim (ver plugins/init.lua).
return {
  name = "lua_ls",
  config = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        telemetry = { enable = false },
      },
    },
  },
}
