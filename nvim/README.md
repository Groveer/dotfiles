# 将 Neovim 打造成为自己的 IDE

本项目配置参考[learn-neovim-lua](https://github.com/nshen/learn-neovim-lua)，但大部分快捷键经过重设（因为本人不喜欢快捷键被重度修改，对新手不够友好），由于本人主要做 C++ 开发工作，所以本项目完全适用 C++ 开发场景。

本项目在保持插件原有快捷键配置的同时，尽量进行更加人性化的配置。

## 目录结构说明

```tree
.
├── filetype.lua        // 使用lua的文件类型检测，加载速度更快，效率更高
├── init.lua            // 所有配置的入口
├── LICENSE             // 本项目使用 MIT 协议
├── lua                 // 存放所有配置文件的目录
│  ├── autocmds.lua     // 设置自动命令
│  ├── basic.lua        // 基础设置
│  ├── colorscheme.lua  // 主题设置
│  ├── keybindings.lua  // 快捷键绑定
│  ├── lsp              // lsp 相关设置
│  │  ├── cmp.lua       // 智能补全设置
│  │  ├── config        // lsp 各语言设置
│  │  │  ├── bash.lua
│  │  │  ├── clangd.lua
│  │  │  ├── cmake.lua
│  │  │  ├── css.lua
│  │  │  ├── html.lua
│  │  │  ├── json.lua
│  │  │  ├── lua.lua
│  │  │  ├── markdown.lua
│  │  │  ├── pyright.lua
│  │  │  └── rust.lua
│  │  ├── setup.lua      // lsp 安装设置
│  │  └── ui.lua         // lsp ui 设置
│  ├── plugin-config     // nvim 各插件设置
│  │  ├── bufferline.lua
│  │  ├── comment.lua
│  │  ├── dashboard.lua
│  │  ├── fidget.lua
│  │  ├── gitsigns.lua
│  │  ├── indent-blankline.lua
│  │  ├── lualine.lua
│  │  ├── nvim-autopairs.lua
│  │  ├── nvim-notify.lua
│  │  ├── nvim-tree.lua
│  │  ├── nvim-treesitter.lua
│  │  ├── project.lua
│  │  ├── telescope.lua
│  │  └── todo-comments.lua
│  ├── plugins.lua        // 要安装哪些插件，可以在此设置
│  └── utils              // 通用设置
│     ├── change-colorscheme.lua
│     └── global.lua
└── README.md             // 本文件
```

## 快捷键绑定说明

这里列出一些常用快捷键说明，也可以查看或修改 keybindings.lua 文件

关于nvim-tree的快捷键可参考[官方文档](https://github.com/nvim-tree/nvim-tree.lua)

| **分类**   | **快捷键** | **说明**                                                            |
| ---------- | ---------- | ------------------------------------------------------------------- |
| 通用       | ;          | leader 键，vim 快捷键的一种方式，加上 leader 键和不加是两种快捷键。 |
| 通用       | qq         | normal 模式，退出                                                   |
| todo       | ]t         | normal 模式，下一个注释标签                                         |
| todo       | [t         | normal 模式，上一个注释标签                                         |
| todo       | lt         | normal 模式, 在telescope中列出标签                                  |
| 缩进       | <          | visual 模式，左缩进                                                 |
| 缩进       | >          | visual 模式，右缩进                                                 |
| 移动       | Ctrl+Up    | visual 模式， 向上移动选中文本                                      |
| 移动       | Ctrl+Down  | visual 模式，向下移动选中文本                                       |
| 通用       | Ctrl+Left  | insert 模式，光标移动到行首                                         |
| 通用       | Ctrl+Right | insert 模式，光标移动到行尾                                         |
| 窗口       | sv         | normal 模式，纵向分割                                               |
| 窗口       | sh         | normal 模式，横向分割                                               |
| 窗口       | sc         | normal 模式，关闭当前窗口                                           |
| 窗口       | so         | normal 模式，关闭其他窗口                                           |
| 窗口       | Alt+Left   | normal 模式，向左跳转窗口                                           |
| 窗口       | Alt+Right  | normal 模式，向右跳转窗口                                           |
| 窗口       | Alt+Up     | normal 模式，向上跳转窗口                                           |
| 窗口       | Alt+Down   | normal 模式，向下跳转窗口                                           |
| treesitter | zz         | normal 模式，折叠代码段                                             |
| treesitter | Z          | normal 模式，展开代码段                                             |
| tree       | Alt+m      | normal 模式，显示文件目录树                                         |
| 标签       | Ctrl+Left  | normal 模式，向左切换标签页                                         |
| 标签       | Ctrl+Right | normal 模式，向右切换标签页                                         |
| 标签       | Ctrl+c     | normal 模式，关闭当前标签页                                         |
| 空白符     | Ctrl+t     | normal 模式，删除当前文档所有尾部空白符                             |
| telescope  | ff         | normal 模式，查找文件                                               |
| telescope  | fw         | normal 模式，查找当前字符串                                         |
| telescope  | fg         | normal 模式，查找自定义字符                                         |
| telescope  | fd         | normal 模式，查找当前环境错误项                                     |
| telescope  | fh         | normal 模式，搜索帮助标签                                           |
| 注释       | Ctrl+/     | normal visual 模式，注释或取消注释当前行/选中行                     |
| lsp        | ga         | normal 模式，code action                                            |
| lsp        | gr         | normal 模式，重命名所有引用当前变量                                 |
| lsp        | gd         | normal 模式，跳转到定义处                                           |
| lsp        | gh         | normal 模式，预览定义                                               |
| lsp        | gj         | normal 模式，跳转到下一条错误处                                     |
| lsp        | gk         | normal 模式，跳转到上一条错误处                                     |
| lsp        | ;f         | normal 模式，格式化当前文档                                         |
| lsp        | ;o         | normal 模式，显示outline                                            |
| lsp        | K          | normal 模式，显示文档                                               |
| lsp        | Alt+d      | normal 模式，弹出终端                                               |
| cmp        | Tab        | insert 模式，切换到下一条补全条目                                   |
| cmp        | Shift+Tab  | insert 模式，切换到上一条补全条目                                   |
| git        | hd         | normal 模式，对比当前文件的修改                                     |
| git        | hs         | normal 模式，暂存当前块                                             |
| git        | hS         | normal 模式，暂存当前文档                                           |
| git        | hr         | normal 模式，取消暂存当前块                                         |
| git        | hR         | normal 模式，取消暂存当前文档                                       |
