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
set splitright
set hlsearch
set mouse=
set nu

let mapleader=";"
let g:python3_host_prog = '/usr/bin/python3'

nmap <C-j> <C-W>+
nmap <C-k> <C-W>-
nmap <C-h> <C-W><
nmap <C-l> <C-W>>
noremap <Leader>g1 :call win_gotoid(win_getid(1))<CR>
noremap <Leader>g2 :call win_gotoid(win_getid(2))<CR>
noremap <Leader>g3 :call win_gotoid(win_getid(3))<CR>
noremap <Leader>g4 :call win_gotoid(win_getid(4))<CR>
noremap <Leader>g5 :call win_gotoid(win_getid(5))<CR>
noremap <Leader>g6 :call win_gotoid(win_getid(6))<CR>
noremap <Leader>g7 :call win_gotoid(win_getid(7))<CR>
noremap <Leader>g8 :call win_gotoid(win_getid(8))<CR>
nnoremap <Leader>in :set foldmethod=indent<CR>
nnoremap <Leader>ma :set foldmethod=manual<CR>

" ================= plug install ======================
" plugged ______________
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'Chiel92/vim-autoformat'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mg979/vim-visual-multi'
Plug 'vim-python/python-syntax'
Plug 'ctrlpvim/ctrlp-vim-everything-has-changed'
"Plug 'Yggdroot/LeaderF'
"Plug 'davidhalter/jedi-vim'
"Plug 'Yggdroot/indentLine'
"Plug 'sillybun/autoformatpythonstatement'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
call plug#end()

" ============ color =====================
highlight Folded guibg=grey guifg=red
highlight FoldColumn guibg=darkgrey guifg=grey
highlight Search ctermbg=yellow ctermfg=blue
highlight IncSearch ctermbg=blue ctermfg=yellow
highlight MatchParen cterm=underline ctermbg=NONE ctermfg=NONE
hi search term=standout ctermfg=0 ctermbg=3 guifg=Blue guibg=Yellow

" ================== nerdtree ===========
map <leader>t :NERDTreeToggle<CR>
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"nn <leader>[ :exec("NERDTree ".expand('%:h'))<CR>
autocmd VimEnter * NERDTree
wincmd w
autocmd VimEnter * wincmd w
map <leader><space> :FixWhitespace<cr>

" ======================== jedi ==================
let g:jedi#goto_command = "<leader>d" "跳转到定义
let g:jedi#goto_assignments_command = "<leader>g" #当前光标下标志符的定义位置
let g:jedi#documentation_command = "K" "查看python的文档
let g:jedi#usages_command = "<leader>n" "当前缓冲区中查找下一个
let g:jedi#completions_command = "<C-Space>" "触发代码补全
let g:jedi#rename_command = "<leader>r" " 重命名标识符(在整个代码中)
let g:jedi#force_py_version = 3  " 使用 Python 3.x 解析器
let g:jedi#python_path = '/home/mtn/miniconda3/bin/python' "解释器路径设置

" ================ ctags+taglist+cscope =====================
let g:Tlist_Use_Right_Window = 1
nnoremap <F8> : TlistOpen<CR>
nmap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
set tags=./tags;,tags
set autochdir
set tags +=/root/.vim/tags
set tags +=/usr/local/lib/python3.8/dist-packages/tags
" cpp section
function! CppTags()
  | if has("cscope") && filereadable("/usr/bin/cscope")
  | | | set csprg=/usr/bin/cscope
  | | | set csto=1
  | | | set cst
  | | | set nocsverb
  | | | " add any database in current directory and top directory
  | | | let l:dir = getcwd()
  | | | while len(l:dir) > 0 && isdirectory(l:dir."/")
  | | | | | if filereadable(l:dir."/cscope.out")
  | | | | | | | exe "cs add ".l:dir."/cscope.out"
  | | | | | endif
  | | | | | let l:dir = substitute(l:dir,'\(.*\)/[^/]*','\1',"")
  | | | endwhile
  | | | " else add database pointed to by environment
  | | | if $CSCOPE_DB != ""
  | | | | | cs add $CSCOPE_DB
  | | | endif
  | | | set csverb
  | endif
  | set tags+=tags;
endfunction
au FileType c,cpp call CppTags()

nmap <leader>cs :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>cg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>cc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ct :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ce :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>cf :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>ci :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader>cd :cs find d <C-R>=expand("<cword>")<CR><CR>

" ======================= Auto format ================
let g:autoformat_autoindent = 1
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1
let g:autoformat_c_cpp_clangformat = 'clang-format'


" ================== indent display =============
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = "" " ________________
let g:indentLine_char = '|'
let g:indentLine_space_char = '.'

" ================= install guide ===================
"cd && mkdir -p .vim && cd .vim
"pip install jedi
"# install vim-plug
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
"# ctags + taglist + cscope prepare
"sudo apt-get install -y exuberant-ctags
"sudo apt-get install cscope
"wget https://sourceforge.net/projects/vim-taglist/files/vim-taglist/4.6/taglist_46.zip/download
"unzip download
"ctags --fields=+iaS --extra=+q -R -f ~/.vim/tags /usr/include /usr/local/include
"
"echo "alias cs_get='find `pwd` -name *.cpp -o -name *.h -o -name *.hpp > cscope.files && cscope -Rbq'" >> ~/.bashrc
"echo "alias ct_get='ctags -R .'" >> ~/.bashrc
"echo "alias cc_get='ctags -R && find `pwd` -name *.cpp -o -name *.h -o -name *.hpp > cscope.files && cscope -Rbq'" >> ~/.bashrc

