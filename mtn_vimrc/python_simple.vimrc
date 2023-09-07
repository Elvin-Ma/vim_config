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
set hlsearch
set nu

let mapleader=";"
let g:python3_host_prog = '/usr/bin/python3'
highlight search term=standout ctermfg=0 ctermbg=3 guifg=Blue guibg=Yellow
nnoremap <Leader>in :set foldmethod=indent<CR>
nnoremap <Leader>ma :set foldmethod=manual<CR>

" window size ctrl
nmap <C-j> <C-W>+
nmap <C-k> <C-W>-
nmap <C-h> <C-W><
nmap <C-l> <C-W>>

" plugged 是插件存到目录
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/LeaderF'
Plug 'davidhalter/jedi-vim'
Plug 'preservim/nerdtree'
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'Chiel92/vim-autoformat'
"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'octol/vim-cpp-enhanced-highlight' 
Plug 'mg979/vim-visual-multi'
Plug 'vim-python/python-syntax'
Plug 'Yggdroot/indentLine'
call plug#end()

autocmd FileType python let g:autoformatpython_enabled = 1
let g:pymode_colorcolumn = 0 " useless now

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

" ====================   Leaderf  ================
"let g:Lf_WindowPosition = 'popup'
let g:Lf_WorkingDirectoryMode='AF'
let g:Lf_RootMarkers = ['.git', '.svn', '.hg', '.project', '.root']
let g:Lf_WildIgnore= {
    \ 'dir':['.svn', '.git', '.cache', '.gitIgnore'],
    \ 'file': ['*.idx', '*.so', '*.o', '.bak']
    \ } 
" let g:Lf_DefaultSearchDir = system('git rev-parse --show-toplevel 2>/dev/null') " find from project other than file path
let g:Lf_DefaultExternalTool='rg'
let g:Lf_ShortcutF = '<c-p>'
" let g:Lf_ShortcutB = '<c-l>'
noremap <leader>fb :<C-U><C-R>=printf("Leaderf! buffer %s", "")<CR><CR>
" file opend recently
noremap <leader>fm :<C-U><C-R>=printf("Leaderf! mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf! bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf! line %s", "")<CR><CR>
noremap <leader>ff :<C-U><C-R>=printf("Leaderf! function %s", "")<CR><CR>
noremap <leader>fw :<C-U><C-R>=printf("Leaderf! window  %s", "")<CR><CR>

" ====================  ripgrep set ==============
" find word for self defined
" nmap <leader>F :Leaderf rg<CR>
nmap <unique> <leader>f <Plug>LeaderfRgPrompt
noremap <leader>b :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <leader>wf :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
noremap <leader>wa :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", expand("<cword>"))<CR>
noremap <leader>wb :<C-U><C-R>=printf("Leaderf! rg -F -w -e %s ", expand("<cword>"))<CR>
noremap <leader>wc :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
noremap <leader>wd :<C-U><C-R>=printf("Leaderf! rg -w -e %s ", expand("<cword>"))<CR> " 正则
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR> " 上一次的查询结果

" ===================jedi ==============
let g:jedi#force_py_version = 3
let g:jedi#python_path = '/usr/bin/python'

let mapleader=";"
let g:jedi#goto_command = "<leader>d" "跳转到定义
let g:jedi#goto_assignments_command = "<leader>g" "当前光标下标志符的定义位置
let g:jedi#documentation_command = "K" "查看python的文档
let g:jedi#usages_command = "<leader>n" "当前缓冲区中查找下一个
let g:jedi#completions_command = "<C-Space>" "触发代码补全
let g:jedi#rename_command = "<leader>r" " 重命名标识符(在整个代码中)
let g:jedi#force_py_version = 3  " 使用 Python 3.x 解析器
let g:jedi#python_path = '/usr/bin/python'

set colorcolumn=0
set textwidth=128
highlight Folded guibg=grey guifg=red
highlight FoldColumn guibg=darkgrey guifg=grey

" ====================find ===========
highlight Search ctermbg=yellow ctermfg=blue 
highlight IncSearch ctermbg=blue ctermfg=yellow 
highlight MatchParen cterm=underline ctermbg=NONE ctermfg=NONE

" ======================= Auto format ================
let g:autoformat_autoindent = 1
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1

" 针对特定文件类型配置格式化工具
let g:autoformat_c_cpp_clangformat = 'clang-format'

" =================== window cut ===============
noremap <Leader>g1 :call win_gotoid(win_getid(1))<CR>
noremap <Leader>g2 :call win_gotoid(win_getid(2))<CR>
noremap <Leader>g3 :call win_gotoid(win_getid(3))<CR>
noremap <Leader>g4 :call win_gotoid(win_getid(4))<CR>
noremap <Leader>g5 :call win_gotoid(win_getid(5))<CR>
noremap <Leader>g6 :call win_gotoid(win_getid(6))<CR>
noremap <Leader>g7 :call win_gotoid(win_getid(7))<CR>
noremap <Leader>g8 :call win_gotoid(win_getid(8))<CR>
set splitright

" ================== indent display =============
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = "" " 在那种模式下隐藏
let g:indentLine_char = '|'
let g:indentLine_space_char = '.'

