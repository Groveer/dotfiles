-- 基础配置
require("basic")
-- 快捷键映射
require("keybindings")
-- Packer插件管理
require("plugins")
-- 自动命令
require("autocmds")
-- 插件配置
require("plugin-config.nvim-tree")
require("plugin-config.bufferline")
require("plugin-config.lualine")
require("plugin-config.telescope")
require("plugin-config.dashboard")
require("plugin-config.project")
require("plugin-config.nvim-treesitter")
require("plugin-config.indent-blankline")
require("plugin-config.toggleterm")
require("plugin-config.comment")
require("plugin-config.nvim-autopairs")
-- require("plugin-config.fidget")
require("plugin-config.gitsigns")
require("plugin-config.tokyonight")
require("plugin-config.todo-comments")
require("plugin-config.nvim-notify")
-- 主题设置 主题设置要在主题插件配置之后进行配置，否则不生效
require("colorscheme")
-- 内置LSP
require("lsp.setup")
require("lsp.cmp")
require("lsp.ui")
