set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
set showmode
set cursorline
set nocompatible
set colorcolumn=0
set nu

let mapleader=";"
let g:python3_host_prog = '/usr/bin/python3'
set hlsearch
highlight search term=standout ctermfg=0 ctermbg=3 guifg=Blue guibg=Yellow

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
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'Chiel92/vim-autoformat'
"Plug 'sillybun/autoformatpythonstatement'
Plug 'python-mode/python-mode', {'for': 'python' , 'branch': 'develop'}
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mg979/vim-visual-multi'
Plug 'vim-python/python-syntax'
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
"nn <leader>[ :exec("NERDTree ".expand('%:h'))<CR>
autocmd VimEnter * NERDTree
wincmd w
autocmd VimEnter * wincmd w
map <leader><space> :FixWhitespace<cr>

"================== coc.nvim  ==========
" coc extensions
"let g:coc_global_extensions = [
"      \ 'coc-json',
"      \ 'coc-tsserver',
"      \ 'coc-cmake',
"      \ ]
"
"set signcolumn=number
"" <TAB> to select candidate forward or
"" pump completion candidate
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"" <s-TAB> to select candidate backward
"inoremap <expr><s-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"function! s:check_back_space() abort
"  let col = col('.')-1
"  return !col || getline('.')[col - 1] =~# '\s'
"endfunction
"
"" <CR> to comfirm selected candidate
"" only when there's selected complete item
"if exists('*complete_info')
"  inoremap <silent><expr> <CR> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
"endif
"
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"function! s:show_documentation()
"  if(index(['vim', 'help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  elseif (coc#rpc#ready())
"    call CocActionAsync('doHover')
"  else
"    execute '!' . &keywordprg . " " . expand('<cword>')
"  endif
"endfunction
"
"" highlight link CocHighlightText Visual
"" autocmd CursorHold * silent call CocActionAsync('highlight')   " TODO
"
"" nmap <leader>rn <Plug>(coc-rename)
"" xmap <leader>f <Plug>(coc-format-selected)
"command! -nargs=0 Format :call CocAction('format')
"
"augroup mygroup
"  autocmd!
"  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end
"
"" diagnostic info
"nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<CR>
"nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
"nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
"nmap <LEADER>qf <Plug>(coc-fix-current)
"
"" Remap <C-f> and <C-b> for scroll float windows/popups.
"if has('nvim-0.4.0') || has('patch-8.2.0750')
"  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
"  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
"  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"endif
"
"" statusline support
"" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}  "TODO
"
"" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"
"function! s:generate_compile_commands()
"  if empty(glob('CMakeLists.txt'))
"    echo "Can't find CMakeLists.txt"
"    return
"  endif
"  if empty(glob('.vscode'))
"    execute 'silent !mkdir .vscode'
"  endif
"  execute '!cmake -DCMAKE_BUILD_TYPE=debug
"      \ -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B .vscode'
"endfunction
"command! -nargs=0 Gcmake :call s:generate_compile_commands()
"
"let g:coc_compile_commands = '/root/projects/br_pytorch/build/Debug/compile_commands.json'

" ==== useless now: jackguo380/vim-lsp-cxx-highlight ====
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
noremap <leader>wd :<C-U><C-R>=printf("Leaderf! rg -w -e %s ", expand("<cword>"))<CR> " 正则
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR> " 上一次的查询结果
"nmap <unique> <leader>wa <Plug>LeaderfRgCwordLiteralNoBoundary
"nmap <unique> <leader>wb <Plug>LeaderfRgCwordLiteralBoundary
"nmap <unique> <leader>wc <Plug>LeaderfRgCwordRegexNoBoundary
"nmap <unique> <leader>wd <Plug>LeaderfRgCwordRegexBoundary
" alt + b, noremap--> only use for this command
" search visually selected text literally

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
" let g:pymode_lint_checkers = []
" let g:pymode_lint_write_quickfix = 0
" let g:pymode_lint_write_statusline = 0
highlight Folded guibg=grey guifg=red
highlight FoldColumn guibg=darkgrey guifg=grey

" ====================find ===========
highlight Search ctermbg=yellow ctermfg=blue
highlight IncSearch ctermbg=blue ctermfg=yellow
highlight MatchParen cterm=underline ctermbg=NONE ctermfg=NONE

" ================ ctags+taglist+cscope =====================
let g:Tlist_Use_Right_Window = 1
nnoremap <F8> : TlistOpen<CR>
nmap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
set tags=./tags;,tags
set autochdir
set tags +=/root/.vim/tags
set tags +=/usr/local/lib/python3.8/dist-packages/torch/tags
" cscope auto generate
"if has("cscope")
"    set csprg=/usr/bin/cscope
"    set csto=0
"    set cst
"    set nocsverb
"    " 添加数据库，但不添加同名但不在当前目录中的数据库
"    " （比如在另一个窗口中运行 'cscope -d'）
"    set cscopequickfix=s-,c-,d-,i-,t-,e-
"    if filereadable("cscope.out")
"        cs add cscope.out
"        " 来自 cscope 向导的 'cs add cscope.out'
"    elseif $CSCOPE_DB != ""
"        cs add $CSCOPE_DB " 指定其他cscope路径
"        " 来自 cscope 向导的 'cs add $CSCOPE_DB'
"    else
"        " 寻找包含 'cscope.out' 的目录，从当前目录开始
"        let s:root_dir = expand("%:p:h")
"        while s:root_dir != '/' && !filereadable(s:root_dir . "/cscope.out")
"            let s:root_dir = fnamemodify(s:root_dir, ':h')
"        endwhile
"        if filereadable(s:root_dir . "/cscope.out")
"            cs add s:root_dir . "/cscope.out"
"        endif
"    endif
"endif

"if has("cscope")
"  set csprg=/usr/bin/cscope
"  set csto=1
"  set cst
"  set nocsverb
"  " add any database in current directory
"  if filereadable("cscope.out")
"      cs add cscope.out
"  endif
"  set csverb
"endif

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
hi search term=standout ctermfg=0 ctermbg=3 guifg=Blue guibg=Yellow

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
