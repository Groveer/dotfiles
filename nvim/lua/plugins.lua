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
    -- "folke/lazy.nvim",
    -------------------------- plugins -------------------------------------------
    -- nvim-tree
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = "nvim-tree/nvim-web-devicons",
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
    },
    -- bufferline
    {
      "akinsho/bufferline.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    -- lualine
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    -- telescope
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- telescope extensions
    "LinArcX/telescope-env.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    -- dashboard-nvim
    "glepnir/dashboard-nvim",
    -- project
    "ahmedkhalf/project.nvim",
    -- treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    },
    "p00f/nvim-ts-rainbow",
    -- indent-blankline
    "lukas-reineke/indent-blankline.nvim",
    --------------------- LSP --------------------
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- Lspconfig
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
    "tami5/lspsaga.nvim",
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
    "akinsho/toggleterm.nvim",
    -- Comment
    "numToStr/Comment.nvim",
    -- nvim-autopairs
    "windwp/nvim-autopairs",
    -- git
    "lewis6991/gitsigns.nvim",
    ----------------------------------------------
    "j-hui/fidget.nvim",
    {'jdhao/whitespace.nvim', event = 'VimEnter'},
    -- plantuml
    {'tyru/open-browser.vim', ft = {'plantuml'}, event = 'BufEnter'},
    {'aklt/plantuml-syntax'},
    -- use({'weirongxu/plantuml-previewer.vim', ft = {'plantuml'}, event = 'BufEnter'})
    {"rcarriga/nvim-notify"},
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim"
    },
})
