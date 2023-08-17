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
let g:python3_host_prog = '/usr/bin/python'

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'Chiel92/vim-autoformat'
Plug 'sillybun/autoformatpythonstatement'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'tmhedberg/SimpylFold'
call plug#end()

let g:coc_disable_startup_warning=1
autocmd FileType python let g:autoformatpython_enabled = 1
let g:pymode_colorcolumn = 0 " useless now

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

"================== coc.nvim  ==========
" coc extensions
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-cmake',
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

let g:coc_compile_commands = '/root/projects/br_pytorch/build/Debug/compile_commands.json'

" ==== jackguo380/vim-lsp-cxx-highlight ====
" hi default link LspCxxHlSymFunction cxxFunction
" hi default link LspCxxHlSymFunctionParameter cxxParameter
" hi default link LspCxxHlSymFileVariableStatic cxxFileVariableStatic
" hi default link LspCxxHlSymStruct cxxStruct
" hi default link LspCxxHlSymStructField cxxStructField
" hi default link LspCxxHlSymFileTypeAlias cxxTypeAlias
" hi default link LspCxxHlSymClassField cxxStructField
" hi default link LspCxxHlSymEnum cxxEnum
" hi default link LspCxxHlSymVariableExtern cxxFileVariableStatic
" hi default link LspCxxHlSymVariable cxxVariable
" hi default link LspCxxHlSymMacro cxxMacro
" hi default link LspCxxHlSymEnumMember cxxEnumMember
" hi default link LspCxxHlSymParameter cxxParameter
" hi default link LspCxxHlSymClass cxxTypeAlias


" =============== Leaderf  ==============
"let g:Lf_WindowPosition = 'popup'
"let g:Lf_WorkingDirectoryMode='AF'
let g:Lf_RootMarkers = ['.git', '.svn', '.hg', '.project', '.root']
let g:Lf_DefaultExternalTool='rg'
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<c-l>'
noremap <leader>f :LeaderfSelf<cr>
noremap <leader>fm :LeaderfMru<cr>
noremap <leader>ff :LeaderfFunction<cr>
noremap <leader>fb :LeaderfBufTagAll<cr>
noremap <leader>ft :LeaderfBufTag<cr>
noremap <leader>fl :LeaderfLine<cr>
noremap <leader>fw :LeaderfWindow<cr>
" ripgrep set ==============
nmap <unique> <leader>fr <Plug>LeaderfRgPrompt
nmap <unique> <leader>fra <Plug>LeaderfRgCwordLiteralNoBoundary
nmap <unique> <leader>frb <Plug>LeaderfRgCwordLiteralBoundary
nmap <unique> <leader>frc <Plug>LeaderfRgCwordRegexNoBoundary
nmap <unique> <leader>frd <Plug>LeaderfRgCwordRegexBoundary

vmap <unique> <leader>fra <Plug>LeaderfRgVisualLiteralNoBoundary
vmap <unique> <leader>frb <Plug>LeaderfRgVisualLiteralBoundary
vmap <unique> <leader>frc <Plug>LeaderfRgVisualRegexNoBoundary
vmap <unique> <leader>frd <Plug>LeaderfRgVisualRegexBoundary

" ======================== color =============
" colorscheme codedark

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
let g:pymode_lint_checkers = ['flake8', 'pylint']
highlight Folded guibg=grey guifg=red
highlight FoldColumn guibg=darkgrey guifg=grey
