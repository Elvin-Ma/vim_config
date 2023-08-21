# install
```python
call plug#begin('~/.vim/plugged')
Plug 'Chiel92/vim-autoformat'
call plug#end()
```

# config
```vimrc
let g:autoformat_autoindent = 1
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1

" 针对特定文件类型配置格式化工具
let g:autoformat_c_cpp_clangformat = 'clang-format'
" nnoremap <F8> :Autoformat<CR> " ShortCut key
```


# use guide
```vim
:Autoformat
```
