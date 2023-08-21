set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
set cursorline
set showmode

let mapleader=";"

set nocompatible 
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" git hub address : http://github.com/VundleVim/Vundle.vim.git
Plugin 'VundleVim/Vundle.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'Yggdroot/LeaderF'
Plugin 'preservim/nerdtree'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on

" jedi extension: g --> global variable
let g:jedi#force_py_version = 3  " 使用 Python 3.x 解析器
let g:jedi#python_path = '/home/mtn/miniconda3/bin/python'  " Python 解析器的路径

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

"let GTAGSLABEL='native-pygments'
"let GTAGSCONF='/usr/local/share/gtags/gtags.conf'
"let g:Lf_GtagsAutoGenerate = 1
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
