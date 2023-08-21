set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
set showmode
set cursorline
set nocompatible
set colorcolumn=0

let mapleader=";"
let g:python3_host_prog = '/usr/bin/python3'

" window size ctrl
nmap <C-j> <C-W>+
nmap <C-k> <C-W>-
nmap <C-h> <C-W><
nmap <C-l> <C-W>>

" ====================find ===========
highlight Search ctermbg=yellow ctermfg=blue
highlight IncSearch ctermbg=blue ctermfg=yellow
highlight MatchParen cterm=underline ctermbg=NONE ctermfg=NONE

" plugged 是插件存到目录
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/LeaderF'
Plug 'preservim/nerdtree'
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'Chiel92/vim-autoformat'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mg979/vim-visual-multi'
call plug#end()

" ================== nerdtree ===========
map <leader>t :NERDTreeToggle<CR>
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
nn <leader>[ :exec("NERDTree ".expand('%:h'))<CR>
autocmd VimEnter * NERDTree
wincmd w
autocmd VimEnter * wincmd w
map <leader><space> :FixWhitespace<cr>

" ====================   Leaderf  ================
"let g:Lf_WindowPosition = 'popup'
"let g:Lf_WorkingDirectoryMode='AF'
let g:Lf_RootMarkers = ['.git', '.svn', '.hg', '.project', '.root']
let g:Lf_DefaultExternalTool='rg'
let g:Lf_ShortcutF = '<c-p>'
noremap <leader>fb :<C-U><C-R>=printf("Leaderf! buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf! mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf! bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf! line %s", "")<CR><CR>

" ============ ripgrep set
" find word for self defined
" nmap <leader>F :Leaderf rg<CR>
noremap <leader>f :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
noremap <leader>b :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
nmap <unique> <leader>wf <Plug>LeaderfRgPrompt
nmap <unique> <leader>wa <Plug>LeaderfRgCwordLiteralNoBoundary
nmap <unique> <leader>wb <Plug>LeaderfRgCwordLiteralBoundary
nmap <unique> <leader>wc <Plug>LeaderfRgCwordRegexNoBoundary
nmap <unique> <leader>wd <Plug>LeaderfRgCwordRegexBoundary
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" ================ ctags+taglist+cscope =====================
let g:Tlist_Use_Right_Window = 1
nnoremap <F8> : TlistOpen<CR>
nmap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
set tags=./tags;,tags
set autochdir
set tags +=/root/.vim/tags
set tags +=/usr/local/lib/python3.8/dist-packages/torch/tags

""""""""""""""""""""""""""""""
" => C/CPP section
"""""""""""""""""""""""""""""""
function! CppTags()
    if has("cscope") && filereadable("/usr/bin/cscope")
        set csprg=/usr/bin/cscope
        set csto=1
        set cst
        set nocsverb
        " add any database in current directory and top directory
        let l:dir = getcwd()
        while len(l:dir) > 0 && isdirectory(l:dir."/")
            if filereadable(l:dir."/cscope.out")
                exe "cs add ".l:dir."/cscope.out"
            endif
            let l:dir = substitute(l:dir,'\(.*\)/[^/]*','\1',"")
        endwhile
        " else add database pointed to by environment
        if $CSCOPE_DB != ""
            cs add $CSCOPE_DB
        endif
        set csverb
    endif
    set tags+=tags;
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
