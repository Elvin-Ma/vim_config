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

let mapleader=";"
let g:python3_host_prog = '/usr/bin/python3'
set hlsearch
highlight search term=standout ctermfg=0 ctermbg=3 guifg=Blue guibg=Yellow
nnoremap <Leader>in :set foldmethod=indent<CR>
nnoremap <Leader>ma :set foldmethod=manual<CR>

" window size ctrl
nmap <C-j> <C-W>+
nmap <C-k> <C-W>-
nmap <C-h> <C-W><
nmap <C-l> <C-W>>

" plugged ______________
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/LeaderF'
"Plug 'davidhalter/jedi-vim'
Plug 'preservim/nerdtree'
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'Chiel92/vim-autoformat'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mg979/vim-visual-multi'
Plug 'vim-python/python-syntax'
Plug 'Yggdroot/indentLine'
Plug 'zivyangll/git-blame.vim'
call plug#end()

"let g:coc_disable_startup_warning=1
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
" 搜索时候排除如下
let g:Lf_WildIgnore={
    \ 'dir':['.svn', '.git', '.cache', '.gitIgnore', 'tags'],
    \ 'file':['*.idx', '*.so', '*.o', '.bak']
    \}
let g:Lf_UseVersionControlTool=1 "这个是默认选项, 可以不写
let g:Lf_DefaultSearchDir = system('git rev-parse --show-toplevel 2>/dev/null') " find from project other than file path
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
"noremap <leader>ff :<C-U><C-R>=printf("Leaderf! file  %s", "")<CR><CR>
"noremap <leader>f :LeaderfSelf<cr>
"noremap <leader>fm :LeaderfMru<cr>
"noremap <leader>ff :LeaderfFunction<cr>
"noremap <leader>fb :LeaderfBufTagAll<cr>
"noremap <leader>ft :LeaderfBufTag<cr>
"noremap <leader>fl :LeaderfLine<cr>
"noremap <leader>fw :LeaderfWindow<cr>
" ====================  ripgrep set ==============
" find word for self defined
" nmap <leader>F :Leaderf rg<CR>
nmap <unique> <leader>f <Plug>LeaderfRgPrompt
noremap <leader>b :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <leader>wf :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
noremap <leader>wa :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", expand("<cword>"))<CR>
noremap <leader>wb :<C-U><C-R>=printf("Leaderf! rg -F -w -e %s ", expand("<cword>"))<CR>
noremap <leader>wc :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
noremap <leader>wd :<C-U><C-R>=printf("Leaderf! rg -w -e %s ", expand("<cword>"))<CR> " ____
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR> " ________________
"nmap <unique> <leader>wa <Plug>LeaderfRgCwordLiteralNoBoundary
"nmap <unique> <leader>wb <Plug>LeaderfRgCwordLiteralBoundary
"nmap <unique> <leader>wc <Plug>LeaderfRgCwordRegexNoBoundary
"nmap <unique> <leader>wd <Plug>LeaderfRgCwordRegexBoundary
" alt + b, noremap--> only use for this command
" search visually selected text literally

" ======================== color =============
" colorscheme codedark
set textwidth=128
highlight Folded guibg=grey guifg=red
highlight FoldColumn guibg=darkgrey guifg=grey
highlight Search ctermbg=yellow ctermfg=blue
highlight IncSearch ctermbg=blue ctermfg=yellow
highlight MatchParen cterm=underline ctermbg=NONE ctermfg=NONE
hi search term=standout ctermfg=0 ctermbg=3 guifg=Blue guibg=Yellow

" ================ ctags+taglist+cscope =====================
let g:Tlist_Use_Right_Window = 1
nnoremap <F8> : TlistOpen<CR>
nmap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
set tags=./tags;,tags
set autochdir
set tags +=/root/.vim/tags
set tags +=/usr/local/lib/python3.8/dist-packages/tags
""""""""""""""""""""""""""""""
" => C/CPP section
"""""""""""""""""""""""""""""""
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
let g:indentLine_concealcursor = "" " ________________
let g:indentLine_char = '|'
let g:indentLine_space_char = '.'

" ================= git blame ================
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
