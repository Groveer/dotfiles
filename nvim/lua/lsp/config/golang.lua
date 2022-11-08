return {
  on_setup = function(server)
    server.setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      flags = {
        debounce_text_changes = 150,
      },
      on_attach = function(client, bufnr)
        local function buf_set_keymap(...)
          ---@diagnostic disable-next-line: missing-parameter
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        require("keybindings").mapLSP(buf_set_keymap)
      end,
    })
  end,
}
