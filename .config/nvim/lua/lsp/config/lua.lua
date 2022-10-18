-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua

local opts = {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    -- 绑定快捷键
    require("keybindings").mapLSP(buf_set_keymap)
  end,
}

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- opts.capabilities = capabilities

-- 查看目录等信息
-- print(vim.inspect(server))

return {
  on_setup = function(server)
    require("neodev").setup({ })
    server.setup(opts)
  end,
}
