```vimrc
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
set showmode
set cursorline
set nocompatible
set colorcolumn=0
set backspace=indent,eol,start
set encoding=utf-8
set nu
set updatetime=200
set list " set nolist to disable
set listchars=space:· "space display as .
set splitright
set hlsearch " : noh/nohlsearch to disable

let mapleader=";"
let g:python3_host_prog = '/usr/bin/python3'
highlight search term=standout ctermfg=0 ctermbg=3 guifg=Blue guibg=Yellow

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo "记录光标位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif "重新打开光标位置不变
autocmd BufNewFile,BufRead *.cu set filetype=cpp "将cuda文件视为cpp文件

" window size ctrl
" left -- right
nnoremap <C-g> 5<C-w><
nnoremap <C-h> 5<C-w>>

" up -- down 
nnoremap <C-j> 5<C-w>-
nnoremap <C-k> 5<C-w>+

nnoremap <leader>p :silent! vimgrep! /^\s*def / %<CR>:silent! vimgrepadd! /^\s*async\s\+def / %<CR>:silent! vimgrepadd! /^\s*class / %<CR>:call setqflist(sort(getqflist(), {a,b -> a.lnum - b.lnum}))<CR>:vertical copen<CR>:wincmd L<CR>:vertical resize 60<CR>
nnoremap <leader>c :silent! vimgrep! /^\s*class\s\+[A-Za-z_][A-Za-z0-9_]*/ %<CR>:silent! vimgrepadd! /^\s*class\s\+[A-Z_][A-Z0-9_]*\s\+[A-Za-z_][A-Za-z0-9_]*/ %<CR>:silent! vimgrepadd! /^\s*struct\s\+[A-Za-z_][A-Za-z0-9_]*/ %<CR>:silent! vimgrepadd! /^\s*struct\s\+[A-Z_][A-Z0-9_]*\s\+[A-Za-z_][A-Za-z0-9_]*/ %<CR>:silent! vimgrepadd! /^\s*[A-Za-z_~][A-Za-z0-9_:<>,*& \t]*\s\+[A-Za-z_~][A-Za-z0-9_:]*\s*(.*)\s*\(const\s*\)\?\(noexcept\s*\)\?{/ %<CR>:silent! vimgrepadd! /^\s*[A-Za-z_~][A-Za-z0-9_:<>,*& \t]*\s\+[A-Za-z_~][A-Za-z0-9_:]*\s*(.*)\s*\(const\s*\)\?\(noexcept\s*\)\?$/ %<CR>:silent! vimgrepadd! /^\s*[A-Za-z_~][A-Za-z0-9_:<>,*& \t]*\s\+[A-Za-z_~][A-Za-z0-9_:]*\s*($/ %<CR>:call setqflist(sort(getqflist(), {a,b -> a.lnum - b.lnum}))<CR>:vertical copen<CR>:wincmd L<CR>:vertical resize 60<CR>


" =================== window cut =====================
noremap <Leader>g1 :call win_gotoid(win_getid(1))<CR>
noremap <Leader>g2 :call win_gotoid(win_getid(2))<CR>
noremap <Leader>g3 :call win_gotoid(win_getid(3))<CR>
noremap <Leader>g4 :call win_gotoid(win_getid(4))<CR>
noremap <Leader>g5 :call win_gotoid(win_getid(5))<CR>
noremap <Leader>g6 :call win_gotoid(win_getid(6))<CR>
noremap <Leader>g7 :call win_gotoid(win_getid(7))<CR>
noremap <Leader>g8 :call win_gotoid(win_getid(8))<CR>

" =================== delete file name display =======
function! QfNoFilename(info) abort
  let items = getqflist({'id': a:info.id, 'items': 1}).items
  let out = []
  for idx in range(a:info.start_idx - 1, a:info.end_idx - 1)
    let item = items[idx]
    call add(out, item.lnum . ': ' . item.text)
  endfor
  return out
endfunction

set quickfixtextfunc=QfNoFilename

" ================== max window and recover : <leader>m  ========
function! ToggleMaximizeWindow()
    if exists('t:maximized') && t:maximized
        execute t:restorecmd
        let t:maximized = 0
    else
        let t:restorecmd = winrestcmd()
        wincmd _
        wincmd |
        let t:maximized = 1
    endif
endfunction

nnoremap <leader>m :call ToggleMaximizeWindow()<CR>
```
