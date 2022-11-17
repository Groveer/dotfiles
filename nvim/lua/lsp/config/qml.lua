return {
  on_setup = function(server)
    server.setup({
    -- 这里使用二进制绝对路径或者将该路径文件添加到环境变量中，然后只使用二进制名
    cmd = { "/usr/lib/qt6/bin/qmlls" },
      on_attach = function(client, bufnr)
        -- 绑定快捷键
        local function buf_set_keymap(...)
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        require("keybindings").mapLSP(buf_set_keymap)
      end,
    })
  end,
}
