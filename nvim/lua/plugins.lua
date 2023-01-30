-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.notify("正在安装lazy.nvim，请稍后...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  vim.notify("lazy.nvim 安装完毕")
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  vim.notify("没有安装 lazy.nvim")
  return
end

lazy.setup({
    -- Packer 可以升级自己
    "folke/lazy.nvim",
    -------------------------- plugins -------------------------------------------
    -- nvim-tree
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = "nvim-tree/nvim-web-devicons",
      version = 'nightly' -- optional, updated every week. (see issue #1193)
    },
    -- bufferline
    {
      "akinsho/bufferline.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      version = "v3.*",
    },
    -- lualine
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons", lazy =true },
    },
    -- telescope
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      version = '0.1.1',
    },
    -- telescope extensions
    "nvim-telescope/telescope-ui-select.nvim",
    -- project
    "ahmedkhalf/project.nvim",
    -- treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
    },
    "HiPhish/nvim-ts-rainbow2",
    -- indent-blankline
    "lukas-reineke/indent-blankline.nvim",
    --------------------- LSP --------------------
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- 补全引擎
    "hrsh7th/nvim-cmp",
    -- Snippet 引擎
    "hrsh7th/vim-vsnip",
    -- 补全源
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
    "hrsh7th/cmp-buffer", -- { name = 'buffer' },
    "hrsh7th/cmp-path", -- { name = 'path' }
    "hrsh7th/cmp-cmdline", -- { name = 'cmdline' }
    "hrsh7th/cmp-emoji", -- { name = 'emoji' }
    "hrsh7th/cmp-nvim-lsp-signature-help", -- { name = 'nvim_lsp_signature_help' }
    -- 常见编程语言代码段
    "rafamadriz/friendly-snippets",
    -- UI 增强
    "onsails/lspkind-nvim",
    {
      "glepnir/lspsaga.nvim",
      event = "BufRead",
      dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    -- 代码格式化
    -- use("mhartington/formatter.nvim")
    -- use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
    -- Lua 增强
    "folke/neodev.nvim",
    -- JSON 增强
    "b0o/schemastore.nvim",
    --------------------- colorschemes --------------------
    -- tokyonight
    "folke/tokyonight.nvim",
    -------------------------------------------------------
    -- Comment
    "numToStr/Comment.nvim",
    -- nvim-autopairs
    "windwp/nvim-autopairs",
    -- git
    "lewis6991/gitsigns.nvim",
    "moll/vim-bbye",
    ----------------------------------------------
    "j-hui/fidget.nvim",
    "johnfrankmorgan/whitespace.nvim",
    ----------------------------------------------
    "rcarriga/nvim-notify",
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim"
    },
})
