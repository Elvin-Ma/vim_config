# coc.nvim 的安装流程(使用vim-plug插件管理器)
*主要解决代码自动补全、跳转等功能*

## 1.1 vim版本升级(8.2以上)
```shell
git clone git@github.com:vim/vim.git
cd vim
git checkout v8.2.0108
./configure --prefix=$HOME/.local --enable-python3interp=yes
make
sudo make install
```

## 1.1 安装node: ？ 14.14
```shell
# 方式1：依赖可能会版本不匹配
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash - # 更新源
sudo apt-get install -y nodejs # 安装
nodejs -v # 查看版本号

# 方式2：源码静态安装
git clone git@github.com:nodejs/node.git
git checkout v16.9.0
./configure --fully-static
make -j4

# 方式3： tar包安装(推荐)
cd https://nodejs.org/download/release/
wget https://nodejs.org/download/release/v16.10.0/node-v16.10.0-linux-x64.tar.gz
tar -zxvf node-v16.10.0-linux-x64.tar.gz
export PATH=node-v16.10.0-linux-x64.tar.gz/bin:$PATH
export LD_LIBRARY_PATH=node-v16.10.0-linux-x64.tar.gz/lib:$LD_LIBRARY_PATH
```

## 1.2 在.vimrc 加入以下语句
```python
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
```

## 1.3 开始安装
```shell
:PlugInstall # 安装coc.nvim
:CocInfo # 查看是否安装成功
```

## 2  使用coc 管理插件
### 2.1 安装cland 后端
```shell
wget https://github.com/clangd/clangd/releases/download/13.0.0/clangd-linux-13.0.0.zip
sudo ln -s /mnt/gpfs/E00310/downloads/clangd_13.0.0/bin/clangd /usr/bin/clangd
export PATH=/mnt/gpfs/E00310/downloads/clangd_13.0.0/bin/clangd:$PATH
```
### 2.2 安装ccls 后端
```shell
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd ccls
wget -c http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
tar xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04
cmake --build Release
cd Release
sudo make install
```

```vim
:CocInstall coc-ccls
```

## 2.3 coc 常用命令
```shell
:CocInstall 插件名 # 安装插件
:CocUninstall 插件名 # 下载插件
:CocList extensions # 查看已安装插件
:CocUpdate # 更新命令
:CocInfo #查看是否安装成功
```

## 2.4 配置语言服务
[language servers github](https://github.com/neoclide/coc.nvim/wiki/Language-servers)

### 2.4.1 打开配置选项
```vim
: CocConfig
```
### 2.4.2 输入以下内容
```python
"languageserver": {
  "ccls": {
    "command": "ccls",
    "filetypes": ["c", "cc", "cpp", "c++", "objc", "objcpp"],
    "rootPatterns": [".ccls", "compile_commands.json", ".git/", ".hg/"],
    "initializationOptions": {
        "cache": {
          "directory": "/tmp/ccls"
        }
      }
  }
}
```
### 2.4.3 上述内容会写到：
```shell
~/.vim/coc-setting.json
```

### 2.4.4 CocInfo 查看是否安装成功，不成功则即可
```shell
cd ~/.config/coc/extensions/node_mudules/coc-ccls # 扩展模块的路径
ln -s ndoe_modules/ws/lib lib
```

### 2.4.5 配置compoile_commands.json
```cmake
set(EXPORT_COMPILE_COMMANDS ON)
-DCMAKE_EXPORT_COMPILE_COMMANDS=YES
```

# 3 相关介绍
*coc.nvim只是一个平台，它能够允许你安装各种语言插件，达到不同语言的补全效果。*
*因此我们只有安装了对应的语言插件才能实现补全。*
[参考配置](https://zhuanlan.zhihu.com/p/145793963)

# vimrc 配置
[配置参考](https://www.cnblogs.com/codingbigdog/p/16624274.html)

```shell
" coc extensions
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-vimlsp',
      \ 'coc-cmake',
      \ 'coc-highlight',
      \ 'coc-python'
      \ ]

set signcolumn=number
" <TAB> to select candidate forward or
" pump completion candidate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" <s-TAB> to select candidate backward
inoremap <expr><s-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.')-1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" <CR> to comfirm selected candidate
" only when there's selected complete item
if exists('*complete_info')
  inoremap <silent><expr> <CR> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if(index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" highlight link CocHighlightText Visual
" autocmd CursorHold * silent call CocActionAsync('highlight')   " TODO

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>F :Leaderf rg<CR>
command! -nargs=0 Format :call CocAction('format')

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" diagnostic info
nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<CR>
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nmap <LEADER>qf <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" statusline support
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}  "TODO

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:generate_compile_commands()
  if empty(glob('CMakeLists.txt'))
    echo "Can't find CMakeLists.txt"
    return
  endif
  if empty(glob('.vscode'))
    execute 'silent !mkdir .vscode'
  endif
  execute '!cmake -DCMAKE_BUILD_TYPE=debug
      \ -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B .vscode'
endfunction
command! -nargs=0 Gcmake :call s:generate_compile_commands()
```
