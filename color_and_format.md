# c++ 颜色高亮(good)
[vim-cpp-enhanced-highlight](https://github.com/octol/vim-cpp-enhanced-highlight/)

# python-mode 语法高亮
```vimrc
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
```
**去除中间竖条**
```vim
" ./plugged/python-mode/ftplugin/python/pymode.vim
if g:pymode_options_colorcolumn && exists('+colorcolumn')
      "setlocal colorcolumn=+1
```
  

# 官方仓库
[参考链接](https://github.com/vim-autoformat/vim-autoformat) <br>
[install](https://zhuanlan.zhihu.com/p/30022074)<br>
