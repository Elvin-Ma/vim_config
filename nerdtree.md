# 安装方式
```shell
Plug 'preservim/nerdtree' # vim-plug 插件管理器
Plugin 'scrooloose/nerdtree' # vundle 插件管理器
```

# 启动方式
```vim
: NERDTree
: help NERDTree # 帮助文档
```

# vimrc 常用配置
```shell
map <leader>t :NERDTreeToggle<CR>
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
nn <leader>[ :exec("NERDTree ".expand('%:h'))<CR>
autocmd VimEnter * NERDTree
wincmd w
autocmd VimEnter * wincmd w
map <leader><space> :FixWhitespace<cr>
```

# nerdtree 常用快捷键
- 上下左右 或 jkhl 在 文件和目录间移动
- o/ enter : 打开选定的文件或目录
- t ： 在新标签页中打开文件或目录
- s ： 在水平分割窗口中打开选定的文件或目录
- i ： 在垂直分割窗口中打开选定的文件或目录
- u ： 向上导航到父目录
- C ： 切换根目录
- P ： 当前路径设置为根目录
